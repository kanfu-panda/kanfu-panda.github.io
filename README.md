# 功夫熊猫的博客

[kanfu-panda.github.io](https://kanfu-panda.github.io) 的源码 —— 一个 Jekyll 静态站点，
托管在 GitHub Pages 上，同时是三个个人项目的产品页。

## 特点

- **三语站点**：英文（默认）/ 中文 / 日文，由 `jekyll-polyglot` 驱动，
  hreflang 与语言切换器自动生成
- **内容**：AI 工程、开发工具与开源项目的长文笔记
- **产品页**：[aitm](https://kanfu-panda.github.io/aitm/)（AI 终端）·
  [PDLC](https://kanfu-panda.github.io/pdlc/)（Claude Code 插件）·
  [arcade](https://kanfu-panda.github.io/arcade/)（浏览器街机模拟器）
- **评论**：Giscus（GitHub Discussions），无需任何仓库 secret
- **搜索**：客户端实现，按当前语言过滤
- **安全基线**：CSP + SRI + 提交前密钥扫描，详见 [SECURITY.md](./SECURITY.md)

## 本地运行

需要 Ruby 3.2（见 `.ruby-version`）。macOS 自带的 Ruby 2.6 版本不够，
请用 rbenv 之类的版本管理器：

```bash
export PATH="$HOME/.rbenv/shims:$PATH"   # 若用 rbenv
bundle install
bundle exec jekyll serve --livereload
```

访问 <http://localhost:4000>。

验证生产构建（CI 跑的就是这个）：

```bash
JEKYLL_ENV=production bundle exec jekyll build --config _config.yml
```

首次拉仓库后装一次本地 git 钩子（提交前自动扫描密钥）：

```bash
bash scripts/install-hooks.sh
```

## 目录结构

```
_config.yml        # 站点配置
_data/i18n.yml     # 三语 UI 文案总表
_layouts/          # 布局模板（CSP、hreflang、语言切换、评论）
_posts/            # 文章。默认语言无后缀，其他语言用 .zh.md / .ja.md
assets/            # 样式、文章配图、favicon
arcade/play/       # arcade 模拟器 SPA 构建产物
scripts/           # 开发脚本与密钥扫描
docs/decisions/    # 架构决策记录（ADR）
.github/workflows/ # CI/CD
```

## 贡献约定

改动内容、文案、路径或元数据时**必须三语同步**，
详细约束（含 SEO 红线与 frontmatter 必填字段）见 [CLAUDE.md](./CLAUDE.md)。

所有改动走 Pull Request，禁止直接推 `main`。

## 许可证

MIT
