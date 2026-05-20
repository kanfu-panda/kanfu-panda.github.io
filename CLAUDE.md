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

## 多语言（i18n）并行修改约束 ⭐

**本博客是 jekyll-polyglot 三语站**（en / zh / ja）。任何改动若涉及"内容 / 文案 / 路径 / 元数据"，**必须三语同步**，否则会出现：
- 默认语言（en）显示中文 description → 谷歌相关性降分
- 某个语言缺导航项 → 用户体验割裂
- 某语言版本 excerpt / 版本号过时 → 信息不一致

### 内容文件清单（每组必须三语齐全）

| 组别 | 文件 |
|---|---|
| 首页 | `index.md` / `index.zh.md` / `index.ja.md` |
| About | `about.md` / `about.zh.md` / `about.ja.md` |
| Projects | `projects.md` / `projects.zh.md` / `projects.ja.md` |
| aitm 产品页 | `aitm.md` / `aitm.zh.md` / `aitm.ja.md` |
| PDLC 产品页 | `pdlc.md` / `pdlc.zh.md` / `pdlc.ja.md` |
| arcade 产品页 | `arcade.md` / `arcade.zh.md` / `arcade.ja.md` |
| 博客文章 | `_posts/YYYY-MM-DD-slug.md` (en) / `.zh.md` / `.ja.md` |

> ⚠️ `_posts/*.md` 默认语言（en）**无后缀**，其他语言用 `.zh.md` / `.ja.md`。早期违规（无后缀但 lang: zh）已在 PR #14 规整。**新建文章必须遵守该命名**。

### Frontmatter 必填字段（三语都要）

| 字段 | 三语都要？ | 例 |
|---|---|---|
| `lang` | ✅ 必填，单字符代码 `en` / `zh` / `ja` | `lang: zh` |
| `title` | ✅ 各语言写各语言的标题 | EN: "PDLC: turn..." / ZH: "PDLC：把..." |
| `description` | ✅ 各语言写各语言版本（不许跨语言重用！） | 中文文件不写英文 description |
| `excerpt`（_posts） | ✅ 各语言对等翻译 | — |
| `permalink` | ✅ 三语共用同一个（polyglot 自动加前缀） | `/aitm/` 在三个文件里都写 |

### 共用资源清单（**不**分语言，三语共用一份）

| 路径 | 说明 |
|---|---|
| `assets/`（图片 / 下载文件 / 静态 JSON） | 已在 `_config.yml` `exclude_from_localization` |
| `arcade/`（工具 SPA dist） | 同上 |
| `_data/i18n.yml` | UI 框架文案库（nav / footer / search / post / tags / not_found / site_title / site_description）按语言键分组 |

**新增需要"全语言文案"的字符串时**，加进 `_data/i18n.yml` 而不是写死在 layout 里。

### 跨语言修改检查清单（每次提交三语相关改动时跑一遍）

- [ ] 三语文件都已修改？（用 `git status` 验证有 3 个 .md 变更）
- [ ] 三语 `description` 都用对应语言写了？没有出现"英文文件含中文描述"？
- [ ] 如果新建一组三语文件，`_data/i18n.yml` 里有没有需要补的字符串？
- [ ] _posts 文件名是否符合规范（默认 lang 无后缀，其他 lang 加 `.zh.md` / `.ja.md`）？
- [ ] hreflang 链接是否能从一种语言切到另外两种？（看 `_layouts/default.html` 的 hreflang 生成逻辑，对博客文章会自动加 `.lang.html` 后缀）

---

## SEO 红线 ⭐

### 必守约束

1. **`sitemap.xml`**：由 `jekyll-sitemap` 插件自动生成；**不要手动改**。已知问题：当前 sitemap 只列默认 lang URL，缺多语言副本——靠 hreflang 链让 Google 自己发现，目前可接受。完整覆盖待后续手写 sitemap.xml.liquid。
2. **`robots.txt`**：手维护文件（在仓库根）。当前禁止抓 `/arcade/play/`（SPA 空壳）。新加任何"低质量页面 / 工具页"也要在这里 Disallow。
3. **arcade 工具 SPA**：必须保持 `<meta name="robots" content="noindex,follow">`（在 arcade_emulator 源码 `index.html`）。每次重 build + sync 不要丢这条。
4. **canonical**：当前由 `jekyll-seo-tag` 自动生成。**已知问题**：非默认 lang 页面的 canonical 会错误指向 `/`（polyglot + seo-tag 兼容性）。临时容忍，因为 hreflang 提供了正确的语言关联。**未来修复**：在所有 `.zh.md` / `.ja.md` 加 frontmatter `canonical_url:` 字段显式声明。
5. **hreflang**：在 `_layouts/default.html` 自动生成，能正确处理 `.lang.html` 后缀（PR #16）。**新增页面 / 新文章不需要手动设 hreflang**，layout 自动加。
6. **三语 description 严格分语言写**（见上节多语言约束）。
7. **每个页面只有 1 个 `<h1>`**。多 `<h1>` 会拖累 SEO 评分。
8. **CSP 不可以拦截 GA / sitemap 爬虫**（当前白名单已含 googletagmanager + google-analytics）。改 CSP 时确认这一点。

### 新增页面时的 SEO checklist

- [ ] `title` 三语都写了？
- [ ] `description` 三语都写了？
- [ ] 是否会被 `jekyll-sitemap` 列入？（permalink 在 `_config.yml` `exclude_from_localization` 内的资源不会被列入）
- [ ] 内容是否会拖低站点平均质量？（SPA 空壳、占位页等应加 `noindex`）
- [ ] hreflang 在 layout 中生成正确吗？（curl `_site/<path>` 看 `<link rel="alternate" hreflang=...>`）

### 已知遗留 SEO 项（按优先级）

| 项 | 优先级 | 说明 |
|---|---|---|
| polyglot + jekyll-seo-tag canonical 错误 | P1 | 非默认 lang 页 canonical 指 `/`。临时容忍 |
| sitemap 缺多语言副本 | P2 | 靠 hreflang 链发现，但官方 sitemap 应完整 |
| og:image 缺失 | P2 | 社交分享无缩略图 |
| 自定义 404 页 | P3 | 当前 GitHub Pages 默认 |
| og:locale 用 `en` 而非 `en_US` | P3 | 小问题 |

---

## aitm 安装包升级流程（重要）

aitm 桌面端会拉 `https://kanfu-panda.github.io/assets/aitm/latest.json` 做 update_check。
**`latest.json` 的 version 必须与 `assets/downloads/` 下的 dmg 文件名版本号严格一致**，
否则 CI 会失败。下面是发新版本时的标准流程。

### 文件涉及范围

自 v0.8.2 起 aitm 跨平台（macOS + Windows），每次发布要处理 **5 个安装包**：

| 文件 | 改什么 |
|---|---|
| `assets/downloads/aitm_X.Y.Z_aarch64.dmg` + `.sha256` | macOS Apple Silicon 安装包 + 校验和 |
| `assets/downloads/aitm_X.Y.Z_x64_en-US.msi` + `.sha256` | Windows x86_64 MSI 安装包 + 校验和 |
| `assets/downloads/aitm_X.Y.Z_x64-setup.exe` + `.sha256` | Windows x86_64 NSIS 安装包 + 校验和 |
| `assets/downloads/aitm_X.Y.Z_arm64_en-US.msi` + `.sha256` | Windows ARM64 MSI 安装包 + 校验和 |
| `assets/downloads/aitm_X.Y.Z_arm64-setup.exe` + `.sha256` | Windows ARM64 NSIS 安装包 + 校验和 |
| `assets/aitm/latest.json` | `version` + `download_url`（仍指向 dmg）+ `notes` |
| `aitm.md` / `aitm.zh.md` / `aitm.ja.md` | 三语产品页：5 张下载卡的版本号 + 文件名 + 体积 |
| `_posts/2026-05-14-aitm-introduction.md` | excerpt 里如果有版本号也同步 |

### 命令模板（替换 `OLD` 与 `NEW`）

```bash
# 0. aitm 仓库会在 releases/v<NEW>/ 下产出 5 个安装包 + latest.json
OLD="0.7.0"
NEW="0.8.2"
SRC="$HOME/projects/aitm/releases/v${NEW}"

# 1. 删旧版（5 个安装包 + 各自 .sha256）
for arch in aarch64.dmg x64_en-US.msi x64-setup.exe arm64_en-US.msi arm64-setup.exe; do
  rm -f assets/downloads/aitm_${OLD}_${arch}{,.sha256}
done

# 2. 拷新版 5 个安装包 + 各自生成 SHA256
for f in aitm_${NEW}_aarch64.dmg aitm_${NEW}_x64_en-US.msi aitm_${NEW}_x64-setup.exe \
         aitm_${NEW}_arm64_en-US.msi aitm_${NEW}_arm64-setup.exe; do
  cp "$SRC/$f" assets/downloads/
  H=$(shasum -a 256 "assets/downloads/$f" | awk '{print $1}')
  echo "${H}  ${f}" > "assets/downloads/${f}.sha256"
done

# 3. latest.json 直接拷源 + 手动改 notes 去内部信息
cp "$SRC/latest.json" assets/aitm/latest.json
# 编辑器打开 latest.json，把 notes 字段重写为对外精简版（不含路线图 / 内部模块名）

# 4. 三语产品页 + 博客文章 excerpt 全文替换版本号 + 各平台体积（按需）
sed -i '' "s/${OLD}/${NEW}/g" aitm.md aitm.zh.md aitm.ja.md _posts/*.md
# 然后手动核对 5 个平台体积说明（aitm.md 三语下载卡里的 MB 数字）

# 5. 本地 build 自检
JEKYLL_ENV=production bundle exec jekyll build

# 6. PR + merge → 自动部署
```

### 易踩的坑

- **`latest.json` 的 `version` 字段必须与 dmg 文件名严格相等**。CI 会比对，不一致直接 fail
- **`download_url` 必须包含正确的 dmg 文件名**（自动更新仍以 macOS 为锚点）
- **5 个安装包都要换全**——少换一个，旧版会以"幽灵文件"形式残留在 site 里
- **5 个 `.sha256` 都要生成**——CI 红线之一（缺一个就 fail）
- **各平台体积**：sed 不会改下载卡里的 `· X.X MB` 数字。手动核对 5 个平台体积（macOS dmg / x64 msi / x64 exe / arm64 msi / arm64 exe）
- **`notes` 字段不能含敏感内部信息**（路线图、未发布功能、内部模块名、CI workflow 细节等）。一句话写本次最主要的对外变化
- **不要忘记删旧版安装包**。否则 git 历史里会越积越多大文件
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
