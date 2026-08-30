# 安全策略（SECURITY.md）

本文件描述本博客的**威胁模型、安全控制措施、第三方资产清单和运维手册**。任何 PR 改动以下内容时必须同步更新本文件：CSP、CDN 依赖、评论组件配置、统计组件配置、CI 安全步骤。

---

## 威胁模型

| 资产 | 威胁 | 严重度 | 缓解 |
|---|---|---|---|
| 评论组件（Giscus） | 第三方 iframe 可被劫持或滥用 | 低 | 凭证由 giscus GitHub App 侧持有，仓库内只存公开标识符（`repo_id` / `category_id`）；CSP 用 `frame-src` 白名单限定 `giscus.app` |
| 第三方 CDN 资产 | CDN 被劫持 / 包被恶意更新 | 中 | 全部锁定具体版本 + SRI sha384 校验 |
| 站点本身（XSS） | 注入恶意脚本到访客浏览器 | 低（无用户输入） | CSP 限制脚本来源 + 仅作者经 git 写入内容 |
| Git 历史 | 误提交 API key / token / 密码 | 中 | pre-commit 钩子 + CI 双重扫描 |
| CI Secrets | 在工作流日志中泄露 | 中 | 由托管平台自动 mask；禁止 `set -x` / 完整打印含密文件 |

## 安全控制清单（已落地）

- [x] **CSP**：`_layouts/default.html` 顶部 `<meta http-equiv="Content-Security-Policy">`
- [x] **Referrer-Policy**：`strict-origin-when-cross-origin`
- [x] **SRI**：所有 CDN 引用均带 `integrity` + `crossorigin="anonymous"`
- [x] **版本锁定**：CDN 资产禁止使用 `@latest` 或主版本号通配
- [x] **Pre-commit 密钥扫描**：`scripts/scan-secrets.sh`，覆盖 OpenAI / Anthropic / AWS / GCP / Slack / GitHub Token / DB connection string 等 14 条规则
- [x] **CI 密钥扫描**：`.github/workflows/jekyll.yml` 在构建前跑同一脚本，并先跑 `--self-test` 防规则本身回归
- [x] **.gitignore**：覆盖 `.env*`、`_config_*.yml`、`*.pem`、`*.key`、`credentials.json`
- [x] **Secrets 注入**：CI 通过 `_config_secrets.yml` 临时合并，不进仓库。当前唯一的 secret 是 `GOOGLE_ANALYTICS_ID`——评论组件迁到 Giscus 后不再需要任何仓库 secret
- [x] **产物校验**：CI 构建后校验 CSP / SRI 存在、禁 `@latest`、三语页面齐全、hreflang ≥4 条、邮箱明文不外泄、评论组件确实注入

## 第三方资产清单

清单中的 URL 与 SRI 必须与 `_layouts/default.html` 和 `search.md` 中的实际引用**完全一致**。审计或升级时请直接比对。

| 完整 URL | SRI sha384 | 用途 |
|---|---|---|
| `https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css` | `DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm` | 图标字体 |
| `https://cdn.jsdelivr.net/npm/marked@12.0.2/marked.min.js` | `/TQbtLCAerC3jgaim+N78RZSDYV7ryeoBCVqTuzRrFec2akfBkHS7ACQ3PQhvMVi` | 文章页生成 TOC |

### 无法上 SRI 的动态脚本

以下两个是**由服务方动态生成、无固定版本**的脚本，按 ADR 0001 的"明确例外"条款不承诺 SRI，改由 CSP 显式白名单约束来源：

| 完整 URL | 约束方式 | 用途 |
|---|---|---|
| `https://giscus.app/client.js` | CSP `script-src` + `frame-src` 白名单 | 评论组件（在 `_layouts/post.html` 中动态注入） |
| `https://www.googletagmanager.com/gtag/js` | CSP `script-src` 白名单；仅 `JEKYLL_ENV=production` 且 secret 已配置时注入 | 站点统计 |

> 历史记录：`gitalk@1.8.0`（评论）与 `simple-jekyll-search@1.10.0`（搜索）曾在本清单中，现均已移除——
> 评论迁至 Giscus，搜索改为 `search.md` 内的自写 `fetch` + 过滤实现，都不再引入第三方 CDN 资产。

### 升级第三方资产的步骤

```bash
# 1. 抓新版文件，计算 SRI（替换 PKG 和 VER）
PKG="marked"; VER="12.0.3"
curl -sL "https://cdn.jsdelivr.net/npm/${PKG}@${VER}/${PKG}.min.js" \
  | openssl dgst -sha384 -binary | openssl base64 -A
# => 拿到 sha384 base64 哈希

# 2. 用新哈希更新 _layouts/default.html 的 integrity=
# 3. 同步更新本文件第三方资产清单
# 4. 本地 jekyll serve 验证页面无 SRI 错误（浏览器 Console 无 "Failed to find a valid digest"）
# 5. 走 PR 合并
```

## 升级第三方资产 ≠ 修改 CSP

如果新依赖引入了新的域名（如某 CDN 切换、某 API 新地址），必须**同步**修改：
- `_layouts/default.html` 中 `Content-Security-Policy` 的相应 directive
- 本文件的"威胁模型"如有新增类别

## 评论组件（Giscus）运维

评论基于 [Giscus](https://giscus.app)，把 GitHub Discussions 当评论后端。接入与启用步骤见
[docs/comments-giscus.md](./docs/comments-giscus.md)。

**为什么从 Gitalk 迁过来**：Gitalk 需要把 OAuth App 的 `clientSecret` 写进客户端 JS，与
"秘钥不进仓库"直接冲突，只能靠 callback URL 白名单 + 最小 scope 缓解。Giscus 把凭证放在
giscus GitHub App 侧，仓库里只留 `repo_id` / `category_id` 两个**公开标识符**——它们出现在
任何人都能打开的 giscus.app 配置页上，不是密钥，可安全入仓。

**当前运维要点**：

1. **仓库不需要任何评论相关的 secret**。CI 里也没有——若在别处看到 `GITALK_*` 的残留配置，那是迁移前的遗物，应删除。
2. **权限面**：giscus App 只被授权访问本仓库，写入范围限于 Discussions。撤销授权在
   GitHub → Settings → Applications → Installed GitHub Apps。
3. **CSP**：`_layouts/default.html` 的 CSP 已放行 `https://giscus.app`（`script-src` + `frame-src`）。
   giscus 若更换域名，必须同步改 CSP，否则评论框静默不显示。
4. **内容治理**：删评论 / 封用户在仓库 Discussions 对应讨论串操作。
5. **三语评论**：`mapping: "pathname"` 意味着中/英/日三个 URL 各自独立成串。

## 误提交密钥后的应急流程

如果 pre-commit / CI 漏过、密钥已进入 git 历史：

1. **立即**到对应平台轮换 / 撤销该密钥
2. 用 `git filter-repo`（**不是** `git rm`）清理历史
3. 强推到远程（需与维护者确认，本仓库为单人项目相对简单）
4. 通知所有曾 clone 仓库的人重新 clone

## 报告漏洞

发现安全问题请通过站点 [关于页面](https://kanfu-panda.github.io/about/) 中的"联系我"渠道私下告知，标题前缀建议带 `[SECURITY]`。请勿在 GitHub Issues 中公开披露。
