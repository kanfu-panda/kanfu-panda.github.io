# CLAUDE.md（项目级 AI agent 指引）

本文件遵守 `~/.claude/CLAUDE.md`（全局军规）。如有冲突，**本项目规则优先**，且本项目可以比全局更严，但不能更松。

---

## 项目概览

`kanfu-panda.github.io` —— 功夫熊猫的个人技术博客，纯静态站点。

- **架构**：Jekyll 静态站点生成器 → GitHub Pages 托管
- **主题**：自定义样式，基于 `minima` 主题继承
- **多语言**：jekyll-polyglot 三语站（en 默认 / zh / ja）
- **评论**：Giscus（基于 GitHub Discussions）。仓库内只存公开标识符，**不需要任何 secret**
- **统计**：Google Analytics（仅生产环境，唯一需要 secret 的组件）
- **搜索**：`search.md` 内自写的 `fetch` + 客户端过滤，读 `search.json`，按当前语言筛选

## 技术栈

- Ruby 3.2 + Bundler
- Jekyll + `jekyll-feed` + `jekyll-seo-tag` + `jekyll-polyglot` + `jekyll-sitemap` + `kramdown`
- 无 JS 构建链路（前端依赖直接走 CDN + SRI 校验）
- CI/CD：GitHub Actions

## 目录结构

```
_config.yml             # 站点配置（公开值）
_config_secrets.yml     # 由 CI 临时生成，永不提交（已在 .gitignore）
_data/i18n.yml          # 三语 UI 文案总表（nav / footer / search / post / tags …）
_layouts/               # 布局模板（已设 CSP / Referrer-Policy / hreflang / 语言切换）
_posts/                 # 文章（YYYY-MM-DD-slug.md，非默认语言加 .zh.md / .ja.md）
assets/css/style.scss   # 站点样式
assets/images/posts/    # 文章配图（每篇三语各一套：无后缀 / -en / -ja）
arcade/play/            # arcade 模拟器 SPA 构建产物（由 scripts/sync-arcade.sh 同步）
scripts/                # 本地开发脚本 + 安全工具
.github/workflows/      # CI/CD
docs/decisions/         # ADR（架构决策记录）
.private/               # 私有草稿与威胁模型，已 gitignore，绝不入仓
SECURITY.md             # 安全策略与运维手册
```

## 常用命令

```bash
# ⚠️ 先确保用的是 rbenv 的 Ruby 3.2（.ruby-version 指定）。
#    macOS 自带 /usr/bin/ruby 是 2.6，会因 bundler 版本不匹配直接报错。
export PATH="$HOME/.rbenv/shims:$PATH"

# 安装依赖
bundle install

# 本地开发（不走 production，不注入 GA；Giscus 不依赖环境，本地也会渲染）
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

> ⚠️ **本站不使用 `jekyll-seo-tag` / `jekyll-sitemap` / `jekyll-feed`**。三者都不认识 polyglot 的
> 多语言 URL，会分别产出错误的 canonical、只含默认语言的 sitemap、以及混语言的 feed。
> 对应功能全部手写：SEO 头在 `_layouts/default.html`，`sitemap.xml` / `feed.xml` / `search.json`
> 在仓库根（均参与本地化，三语各一份）。**不要为了"少写点代码"把这些插件装回来。**

### 必守约束

1. **`sitemap.xml`**：**手写**（仓库根 `sitemap.xml`），参与 polyglot 本地化，三语各生成一份
   （`/sitemap.xml` · `/zh/sitemap.xml` · `/ja/sitemap.xml`），三份都在 `robots.txt` 里声明。
   只列**规范 URL**，与 layout 里的 canonical 完全一致。**不要装回 `jekyll-sitemap`**——
   它不认识 polyglot，只会列默认语言且路径不带前缀。
2. **`robots.txt`**：手维护文件（在仓库根）。当前禁止抓 `/arcade/play/`（SPA 空壳）。新加任何"低质量页面 / 工具页"也要在这里 Disallow。
3. **arcade 工具 SPA**：必须保持 `<meta name="robots" content="noindex,follow">`（在 arcade_emulator 源码 `index.html`）。每次重 build + sync 不要丢这条。
4. **canonical**：在 `_layouts/default.html` 手写，由 `canonical_path` 变量统一计算，
   与 hreflang 同源。**不要装回 `jekyll-seo-tag`**——它把 `/zh/` 页的 canonical 写成 `/`，
   等于让中文页对搜索引擎宣告"我不是正版"，2/3 的内容因此拿不到自然流量（2026-08-30 修复）。
   polyglot 会把每篇文章额外复制到其他语言目录，那些副本靠 canonical 指回规范地址消歧义。
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
| ~~canonical 错误~~ | ✅ 已修 | 2026-08-30 改为手写，见上方第 4 条 |
| ~~sitemap 缺多语言副本~~ | ✅ 已修 | 2026-08-30 改为手写三语，见上方第 1 条 |
| ~~og:image 缺失~~ | ✅ 已有 | 全站默认图 + 文章 `image:` 覆盖 |
| ~~og:locale 用 `en`~~ | ✅ 已修 | 现为 `en_US` / `zh_CN` / `ja_JP` |
| 自定义 404 页 | P3 | 当前 GitHub Pages 默认 |
| polyglot 生成重复副本 | P3 | 每篇文章在各语言目录下都有副本，已用 canonical 消歧义。
彻底解决需改 URL 策略，收益不大 |

---

## 产品页版本同步流程（aitm / PDLC）

两个产品都是**公开仓 + GitHub Releases 分发**，博客只承担产品页展示，**不托管任何二进制**。
所以"发版"对本仓库来说只有一件事：**把三语产品页上的版本号和下载链接对齐到最新 release**。

| 产品 | 公开仓 | 协议 | 博客页面 |
|---|---|---|---|
| aitm | [kanfu-panda/aitm](https://github.com/kanfu-panda/aitm) | Apache-2.0 | `aitm.md` / `aitm.zh.md` / `aitm.ja.md` |
| PDLC | [kanfu-panda/pdlc-skills](https://github.com/kanfu-panda/pdlc-skills) | MIT | `pdlc.md` / `pdlc.zh.md` / `pdlc.ja.md` |

### 同步步骤

```bash
# 1. 查最新 release 版本号
gh release list --repo kanfu-panda/aitm --limit 1
gh release list --repo kanfu-panda/pdlc-skills --limit 1

# 2. 三语页面全文替换版本号（aitm 为例）
OLD="1.4.3"; NEW="1.5.0"
sed -i '' "s/${OLD}/${NEW}/g" aitm.md aitm.zh.md aitm.ja.md

# 3. 核对 sed 改不到的东西：
#    - aitm：5 张下载卡的文件名必须与 release assets 实际名字一致
#      （gh release view v${NEW} --repo kanfu-panda/aitm --json assets）
#    - PDLC：命令总数（hero / description / "N 条命令，分三层" / 验证安装那段）
#      实际数量 = ls ~/projects/pdlc-skills/skills/ | wc -l
#    - 两者：新版本引入的重要能力是否该补进"核心能力"卡片

# 4. 本地生产构建自检
export PATH="$HOME/.rbenv/shims:$PATH"
JEKYLL_ENV=production bundle exec jekyll build --config _config.yml

# 5. 走 PR（禁止直推 main）
```

### `assets/aitm/latest.json` 是什么

一个**冻结的兼容垫片**，不是分发渠道。

aitm 自 **v1.0.0** 起改从 GitHub Releases API 取更新（内部仓 commit `c3f6439`「废弃博客中转」），
此后博客与 aitm 的更新链路已完全解耦。这个文件只为 **v0.10.6 及更早**的遗留客户端保留——
它们仍会来拉这个 URL，需要看到一个足够新的 `version` 才会提示用户升级；用户升上去之后，
客户端自带的 updater 就接管了，不会再回来拉它。

因此：

- **不需要**随每次 aitm 发版更新它。它的作用是把遗留用户推走一次，不是持续广播最新版。
- schema 必须保持 `{version, download_url, notes}`（老客户端的约定，改了会解析失败）。
- `download_url` 必须指向 `github.com/kanfu-panda/aitm/releases/...` 且包含 `version` 的值——
  CI 会校验这两点。
- **不要**往 `assets/downloads/` 放安装包。2026-08-30 已清掉 32MB 的 0.10.6 遗留二进制，
  当时它们已无任何页面引用。博客不再是 aitm 的分发端。
