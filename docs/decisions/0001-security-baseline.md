# 0001 - 安全基线

- **状态**：已采纳
- **日期**：2026-05-13
- **决策者**：项目维护者

## 背景

`kanfu-panda.github.io` 是一个对外公开的 Jekyll 静态博客，托管在 GitHub Pages。在初次安全审视中发现：

1. **第三方评论组件**的客户端凭证按其设计会被渲染到前端 HTML（已知社区问题）
2. 所有第三方 CDN 资产**无 SRI 校验**，存在版本通配引用（供应链可被劫持）
3. 站点**无 CSP / Referrer-Policy** 等安全响应头
4. **缺少自动化的密钥误提交防护**
5. CI 工作流在 Secrets 缺失时硬失败，对 fork PR 不友好

未来用户会陆续添加文章和项目内容，需要一个**可持续运行的安全屏障**，让后续每次内容更新都自动经过安全校验。

## 决策

实施以下安全基线（已在本 PR 落地）：

### 1. 前端供应链安全

- **锁定**所有 CDN 资产到具体版本，禁止 `@latest` / 主版本通配
- **强制 SRI**：所有**可版本锁定的第三方 CDN JS/CSS 资产**均带 `integrity` + `crossorigin`
- **明确例外**：内联 `<script>` 不适用 SRI；类似 GA 的第三方动态脚本若无法稳定锁定内容，不承诺 SRI，改由 CSP 中显式白名单来源进行约束
- **CSP**：通过 `<meta http-equiv>` 注入，限制：
  - `default-src 'self'`
  - 显式列举可信 CDN 域名
  - `frame-ancestors 'none'` 防点击劫持
  - `script-src` 含 `'unsafe-inline'` —— 是个权衡，见下方"已知限制"
- **Referrer-Policy**：`strict-origin-when-cross-origin`

### 2. 密钥防泄露

- `scripts/scan-secrets.sh`：扫描常见密钥模式（AWS/GCP/OpenAI/Anthropic/Slack/GitHub Token/DB URI/PEM 私钥）
- `scripts/install-hooks.sh`：一键安装 pre-commit 钩子（拉仓后首次运行）
- CI 在构建前**复用同一脚本**全量扫一遍（防本地钩子被绕过）

### 3. 文档化

- `SECURITY.md`：威胁模型、第三方资产清单、运维手册、应急流程
- `CLAUDE.md`：AI agent 项目级指引（命令、内容贡献规范、模型选择）
- 本 ADR：决策记录

### 4. CI 调整

- 在 fork PR 上：Secrets 缺失改为**降级**（跳过相关组件注入）而非硬失败
- 在构建前增加密钥扫描步骤

## 不采纳（备选方案）

### A. 更换评论组件至后端持有凭证的方案

**好处**：彻底规避当前组件将客户端凭证嵌入前端的设计限制。

**未采纳原因**：
- 需在 GitHub 开启 Discussions 并安装新的 GitHub App，属仓库管理员的外部操作
- 历史评论数据迁移成本未评估
- 本 PR 聚焦"安全基线"，留作下一个独立 PR 处理

### B. 使用 CSP nonce 替代 `'unsafe-inline'`

**好处**：完全杜绝内联脚本被注入。

**未采纳原因**：
- Jekyll 静态构建难以生成每请求唯一 nonce（除非走 Workers / Edge function）
- 现有 `_layouts/default.html` 和 `_layouts/post.html` 内联了多段逻辑（主题切换、TOC 生成、Gitalk 渲染、gtag 配置），重写为外部脚本工作量大
- 当前没有用户输入入口，XSS 攻击面本就极小

### C. 使用 `gitleaks` 替代自写扫描脚本

**好处**：检测规则更全，社区维护。

**未采纳原因**：
- 引入外部二进制依赖，对个人博客是过度工程
- 自写脚本覆盖了全局军规第 10 条列出的所有模式，已够用
- 未来若发现误报 / 漏报，再换 gitleaks 也不迟（本 ADR 不阻塞）

## 已知限制

1. **CSP `'unsafe-inline'`**：保留以兼容现有内联脚本。这意味着 CSP 不能防御所有 XSS，但因为本站无用户输入，实际风险可控。
2. **评论组件凭证仍在前端**：依赖 OAuth App 的 callback URL 白名单 + 最小 scope + 定期轮换来缓解；属外部配置。
3. **kramdown 默认允许原始 HTML**：作者在 Markdown 中可写 `<script>`。安全屏障靠 `scripts/scan-secrets.sh` 检测可疑模式 + 作者自律 + PR 评审，不通过技术强制。

## 后续工作（建议但本 PR 不做）

- [ ] 评估更换评论组件至后端持有凭证的方案（独立 PR）
- [ ] 清理 `_config.yml` 中的占位邮箱
- [ ] 切换 git author email 至无邮邮箱（noreply）
- [ ] OAuth App 配置定期回顾（scope、callback URL）
