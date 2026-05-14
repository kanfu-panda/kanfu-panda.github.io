# 安全策略（SECURITY.md）

本文件描述本博客的**威胁模型、安全控制措施、第三方资产清单和运维手册**。任何 PR 改动以下内容时必须同步更新本文件：CSP、CDN 依赖、评论组件配置、统计组件配置、CI 安全步骤。

---

## 威胁模型

| 资产 | 威胁 | 严重度 | 缓解 |
|---|---|---|---|
| 第三方评论组件 OAuth 凭证 | 第三方组件按其设计将客户端凭证嵌入前端 | 中 | OAuth App 设置最小 scope + 严格 callback URL 白名单 + 定期轮换；长期评估更安全的替代方案 |
| 第三方 CDN 资产 | CDN 被劫持 / 包被恶意更新 | 中 | 全部锁定具体版本 + SRI sha384 校验 |
| 站点本身（XSS） | 注入恶意脚本到访客浏览器 | 低（无用户输入） | CSP 限制脚本来源 + 仅作者经 git 写入内容 |
| Git 历史 | 误提交 API key / token / 密码 | 中 | pre-commit 钩子 + CI 双重扫描 |
| CI Secrets | 在工作流日志中泄露 | 中 | 由托管平台自动 mask；禁止 `set -x` / 完整打印含密文件 |

## 安全控制清单（已落地）

- [x] **CSP**：`_layouts/default.html` 顶部 `<meta http-equiv="Content-Security-Policy">`
- [x] **Referrer-Policy**：`strict-origin-when-cross-origin`
- [x] **SRI**：所有 CDN 引用均带 `integrity` + `crossorigin="anonymous"`
- [x] **版本锁定**：CDN 资产禁止使用 `@latest` 或主版本号通配
- [x] **Pre-commit 密钥扫描**：`scripts/scan-secrets.sh`，覆盖 OpenAI / AWS / GCP / Slack / GitHub Token / DB connection string 等
- [x] **CI 密钥扫描**：`.github/workflows/jekyll.yml` 在构建前跑同一脚本
- [x] **.gitignore**：覆盖 `.env*`、`_config_*.yml`、`*.pem`、`*.key`、`credentials.json`
- [x] **Secrets 注入**：CI 通过 `_config_secrets.yml` 临时合并，不进仓库

## 第三方资产清单

清单中的 URL 与 SRI 必须与 `_layouts/default.html` 和 `search.md` 中的实际引用**完全一致**。审计或升级时请直接比对。

| 完整 URL | SRI sha384 | 用途 |
|---|---|---|
| `https://cdn.jsdelivr.net/npm/gitalk@1.8.0/dist/gitalk.css` | `X7z7PUv2B67D8sPJyzDyGZSco1ADwmdI7ed4eCGtTKkClfyDFpPL9WgAn9XVr/Io` | 评论组件样式 |
| `https://cdn.jsdelivr.net/npm/gitalk@1.8.0/dist/gitalk.min.js` | `kspnZUWBoSWwoJHa0hBCXYbHGbhvU/lcEH5O8eVbSDhbPwsiVUTp/aGX/z/5EuMA` | 评论组件 |
| `https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css` | `DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm` | 图标字体 |
| `https://cdn.jsdelivr.net/npm/marked@12.0.2/marked.min.js` | `/TQbtLCAerC3jgaim+N78RZSDYV7ryeoBCVqTuzRrFec2akfBkHS7ACQ3PQhvMVi` | 文章页生成 TOC |
| `https://cdn.jsdelivr.net/npm/simple-jekyll-search@1.10.0/dest/simple-jekyll-search.min.js` | `UN+lyciv8Ta643YxZ9sY2tdTSmk3KE61Qq84ZIXG9NRTbD9+NFXy38m9h6Exxx3n` | 客户端搜索 |

### 升级第三方资产的步骤

```bash
# 1. 抓新版文件，计算 SRI（替换 PKG 和 VER）
PKG="gitalk"; VER="1.8.1"
curl -sL "https://cdn.jsdelivr.net/npm/${PKG}@${VER}/dist/${PKG}.min.js" \
  | openssl dgst -sha384 -binary | openssl base64 -A
# => 拿到 sha384 base64 哈希

# 2. 用新哈希更新 _layouts/default.html（或 search.md）的 integrity=
# 3. 同步更新本文件第三方资产清单
# 4. 本地 jekyll serve 验证页面无 SRI 错误（浏览器 Console 无 "Failed to find a valid digest"）
# 5. 走 PR 合并
```

## 升级第三方资产 ≠ 修改 CSP

如果新依赖引入了新的域名（如某 CDN 切换、某 API 新地址），必须**同步**修改：
- `_layouts/default.html` 中 `Content-Security-Policy` 的相应 directive
- 本文件的"威胁模型"如有新增类别

## 评论组件 OAuth 凭证运维

**已知约束**：当前所用评论组件按其设计将客户端凭证嵌入前端。该限制源自组件本身，仓库代码无法绕过。

**当前缓解**：
1. 对应 OAuth App 配置：
   - `Authorization callback URL` 严格限定为站点域名
   - 仅勾选最小 scope（不授予仓库写权限或管理员权限）
   - 定期轮换凭证（建议每 6 个月）
2. 关注 OAuth App 的使用情况，留意异常授权请求

**推荐长期方案**：评估迁移到由后端持有凭证的替代组件（如基于 GitHub Discussions 的方案），详见 ADR。

## 误提交密钥后的应急流程

如果 pre-commit / CI 漏过、密钥已进入 git 历史：

1. **立即**到对应平台轮换 / 撤销该密钥
2. 用 `git filter-repo`（**不是** `git rm`）清理历史
3. 强推到远程（需与维护者确认，本仓库为单人项目相对简单）
4. 通知所有曾 clone 仓库的人重新 clone

## 报告漏洞

发现安全问题请发送到 `slbluefox@gmail.com`，标题前缀 `[SECURITY]`。请勿在 GitHub Issues 中公开披露。
