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
