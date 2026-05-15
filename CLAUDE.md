# CLAUDE.md（项目级 AI agent 指引）

本文件遵守 `~/.claude/CLAUDE.md`（全局军规）。如有冲突，**本项目规则优先**，且本项目可以比全局更严，但不能更松。

---

## 项目概览

`kanfu-panda.github.io` —— 功夫熊猫的个人技术博客，纯静态站点。

- **架构**：Jekyll 静态站点生成器 → GitHub Pages 托管
- **主题**：自定义样式，基于 `minima` 主题继承
- **评论**：Gitalk（基于 GitHub Issues）
- **统计**：Google Analytics（仅生产环境）
- **搜索**：`simple-jekyll-search`（客户端搜索）

## 技术栈

- Ruby 3.2 + Bundler
- Jekyll + `jekyll-feed` + `jekyll-seo-tag` + `kramdown`
- 无 JS 构建链路（前端依赖直接走 CDN + SRI 校验）
- CI/CD：GitHub Actions

## 目录结构

```
_config.yml             # 站点配置（公开值）
_config_secrets.yml     # 由 CI 临时生成，永不提交（已在 .gitignore）
_layouts/               # 布局模板（已设 CSP / Referrer-Policy）
_posts/                 # 文章（YYYY-MM-DD-slug.md）
_includes/              # 可复用片段（如有）
assets/css/style.scss   # 站点样式
scripts/                # 本地开发脚本 + 安全工具
.github/workflows/      # CI/CD
docs/decisions/         # ADR（架构决策记录）
SECURITY.md             # 安全策略与运维手册
```

## 常用命令

```bash
# 安装依赖
bundle install

# 本地开发（不走 production，不注入 GA / Gitalk）
bundle exec jekyll serve --livereload

# 生产构建（验证 CI 行为）
JEKYLL_ENV=production bundle exec jekyll build --config _config.yml

# 安全扫描（提交前自动跑，也可手动跑）
bash scripts/scan-secrets.sh

# 安装本地 git hooks（首次拉仓库后跑一次）
bash scripts/install-hooks.sh
```

## 内容贡献规范

### 新增文章

1. 文件命名：`_posts/YYYY-MM-DD-slug.md`
2. Front matter 必须包含：`layout: post`、`title`、`date`、`categories`、`tags`、`excerpt`
3. **禁止**在文章 Markdown 中嵌入：
   - `<script>` 标签（违反 CSP，且引入 XSS 风险）
   - 外部 `<iframe>`（CSP 设了 `frame-ancestors 'none'`，反向也建议不引入）
   - 未在 CSP 白名单内的 CDN 链接
4. 图片优先放 `assets/images/<post-slug>/`，引用相对路径；若需外链图片，必须 HTTPS

### 新增页面 / 项目展示

1. 顶级页面放仓库根（如 `projects.md`），permalink 显式声明
2. 引入任何新的第三方 JS / CSS：
   - **必须锁版本**（禁止 `@latest`）
   - **必须加 SRI**（`integrity="sha384-..." crossorigin="anonymous"`）
   - **必须更新 `_layouts/default.html` 里的 CSP** 白名单
   - 在 `SECURITY.md` 的"第三方资产清单"里登记

## 安全模型

详见 [SECURITY.md](./SECURITY.md) 和 [docs/decisions/0001-security-baseline.md](./docs/decisions/0001-security-baseline.md)。

**红线**：
- 任何 OAuth / API key / token 严禁提交（pre-commit 钩子会扫描阻拦）
- 升级 CDN 依赖必须同步更新 SRI 哈希
- 修改 CSP 必须在 PR 描述里说明动机

## AI agent 模型选择

- 写文章 / 改样式 / 文档：**Haiku** 足够
- 模板逻辑改造、CSP 调整、依赖升级：**Sonnet**
- 架构性重构（如评论系统迁移、CI 改造）：**Opus**

## 部署

- 推到 `main` 分支即自动部署到 GitHub Pages（见 `.github/workflows/jekyll.yml`）
- **禁止**直接推 `main`，必须走 PR
- CI 会做：依赖安装 → secrets 校验 → 密钥扫描 → 构建 → SRI/CSP 健全性检查 → 部署

---

## aitm 安装包升级流程（重要）

aitm 桌面端会拉 `https://kanfu-panda.github.io/assets/aitm/latest.json` 做 update_check。
**`latest.json` 的 version 必须与 `assets/downloads/` 下的 dmg 文件名版本号严格一致**，
否则 CI 会失败。下面是发新版本时的标准流程。

### 文件涉及范围

| 文件 | 改什么 |
|---|---|
| `assets/downloads/aitm_X.Y.Z_aarch64.dmg` | 新 dmg（旧的删除） |
| `assets/downloads/aitm_X.Y.Z_aarch64.dmg.sha256` | 新 SHA256 文件（旧的删除） |
| `assets/aitm/latest.json` | `version` + `download_url` + `notes` 三处更新 |
| `aitm.md` / `aitm.zh.md` / `aitm.ja.md` | 三语产品页：版本号、dmg 文件名、SHA256 命令、SHA256 链接、体积（如变化） |
| `_posts/2026-05-14-aitm-introduction.md` | excerpt 里如果有版本号也同步 |

### 命令模板（替换 `OLD` 与 `NEW`）

```bash
# 0. 假设新 dmg 已经在 ~/Downloads/aitm_NEW_aarch64.dmg
OLD="0.5.2"
NEW="0.5.3"
DMG_SRC="$HOME/Downloads/aitm_${NEW}_aarch64.dmg"

# 1. 替换 dmg 与 SHA256
rm -f assets/downloads/aitm_${OLD}_aarch64.dmg assets/downloads/aitm_${OLD}_aarch64.dmg.sha256
cp "$DMG_SRC" assets/downloads/
HASH=$(shasum -a 256 "$DMG_SRC" | awk '{print $1}')
echo "${HASH}  aitm_${NEW}_aarch64.dmg" > assets/downloads/aitm_${NEW}_aarch64.dmg.sha256

# 2. 更新 latest.json（手动改 notes，version 与 url 直接 sed）
#    或者直接用编辑器改三处字段
sed -i '' "s/${OLD}/${NEW}/g" assets/aitm/latest.json
# 然后手动更新 notes 字段为本次发布的关键变化（一句话即可）

# 3. 三语产品页 + 博客文章 excerpt 全文替换版本号
sed -i '' "s/${OLD}/${NEW}/g" aitm.md aitm.zh.md aitm.ja.md _posts/*.md

# 4. 校验（CI 也会跑）
cd assets/downloads && shasum -a 256 -c aitm_${NEW}_aarch64.dmg.sha256 && cd -

# 5. 本地 build 自检
JEKYLL_ENV=production bundle exec jekyll build

# 6. PR + merge → 自动部署
```

### 易踩的坑

- **`latest.json` 的 `version` 字段必须与 dmg 文件名严格相等**。CI 会比对，不一致直接 fail
- **`download_url` 必须包含正确的 dmg 文件名**。CI 会 grep 校验
- **dmg 体积**：sed 不会改 `<p><strong>v0.X.Y</strong> ... · 6.X MB</p>` 里的 MB 数字。**手动看 `stat -f %z dmg` 算一下，必要时改三个 .md 的体积说明**
- **`notes` 字段不能含敏感内部信息**（路线图、未发布功能、内部模块名等）。按用户视角一句话写本次主要变化
- **不要忘记删旧 dmg**。否则 git 历史里会越积越多 6MB 二进制文件
- **assets/aitm/ 与 assets/downloads/ 共享所有语言**。polyglot 配置里已 exclude，三语用户共用同一份资源

### 关于 `latest.json` 的格式约定

字段由 aitm 客户端约定，目前形式：

```json
{
  "version": "X.Y.Z",
  "download_url": "https://kanfu-panda.github.io/assets/downloads/aitm_X.Y.Z_aarch64.dmg",
  "notes": "本次发布的关键变化（一句话，对外措辞）"
}
```

**如果 aitm 客户端约定字段变了**（例如要加 `signature`、`pub_date` 之类），
按客户端的新约定改。**改完务必同步更新 CI 校验**（`.github/workflows/jekyll.yml`
里"aitm 自动更新清单"那段），否则旧校验可能放过格式错误。
