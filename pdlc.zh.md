---
layout: default
title: PDLC
permalink: /pdlc/
lang: zh
description: PDLC —— 给 Claude Code 加上"产品开发生命周期"工作流的开源插件。31 个标准化阶段、状态机、TDD 红灯强制门、阶段自检、自动修复仅一轮。把"软规范"升级为"硬契约"。MIT 开源。
---

<div class="hero-section">
    <div class="hero-content">
        <h1>PDLC</h1>
        <p>给 <strong>Claude Code</strong> 加上"产品开发生命周期"工作流的开源插件。</p>
        <p>31 个标准化阶段，全部以斜杠命令暴露。每份产物落到磁盘、每个阶段更新状态机、实现前必须有失败的测试。让"软规范"变成"硬契约"。</p>
        <div class="hero-links">
            <a href="https://github.com/kanfu-panda/pdlc-skills" class="cta-button">在 GitHub 查看 →</a>
            <a href="#install" class="github-link">查看安装</a>
        </div>
    </div>
</div>

<div class="content-section" markdown="1">

<div class="about-section">
    <h2>✨ 为什么需要 PDLC</h2>
    <div class="about-grid">
        <div class="about-card">
            <h3>📝 产物落盘</h3>
            <p>每个阶段都产出磁盘上的真实文件到 <code>docs/</code>，杜绝"PRD 只活在对话里"。可以 <code>git diff</code> 看 AI 真的做了什么。</p>
        </div>
        <div class="about-card">
            <h3>📊 每个功能一份状态机</h3>
            <p><code>docs/.pdlc-state/&lt;feature-id&gt;.json</code> 记录每次阶段流转。<code>/pdlc-status</code> 永远知道每个功能进展到哪。</p>
        </div>
        <div class="about-card">
            <h3>🚦 先有测试，再写代码</h3>
            <p>真正的 TDD 红灯门禁。实现阶段被失败的测试挡住，不能跳。再没有"写完了顺手补几个测试"。</p>
        </div>
        <div class="about-card">
            <h3>🔍 阶段交接前必自检</h3>
            <p>每个阶段在交接前跑一次自检。偏差在边界拦截，不会拖到几周后的评审才被发现。</p>
        </div>
        <div class="about-card">
            <h3>🛠️ 自动修复仅一轮</h3>
            <p>自动修复循环至多跑一次。卡壳的失败会向上抛给人，杜绝"修复 → 检查 → 再修复"的死循环。</p>
        </div>
        <div class="about-card">
            <h3>🧭 每阶段显式 next_step</h3>
            <p>每个阶段都声明下一步是什么。多阶段串联由命令驱动，不靠脑子记，也不靠 AI 记。</p>
        </div>
    </div>
</div>

<div class="recent-posts">
    <h2>🎯 它能帮你做什么</h2>
    <div class="post-grid">
        <div class="post-card">
            <div class="post-content">
                <h3>端到端做一个新功能</h3>
                <p class="post-excerpt"><code>/pdlc-feature 给用户登录加手机号验证</code> —— PDLC 串完 PRD → 设计 → TDD → 实现 → 评审 → 发布，每个阶段都把产物落盘。</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>修 bug 留下完整审计</h3>
                <p class="post-excerpt"><code>/pdlc-fix 翻页在空列表上崩溃</code> —— 定位、复现、修、测、文档。<code>docs/04_testing/defects/</code> 下的缺陷记录比对话长存。</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>一眼看每个功能在哪个阶段</h3>
                <p class="post-excerpt"><code>/pdlc-status</code> 读所有状态机文件，一屏告诉你：哪些功能在 PRD、哪些在 TDD 红灯、哪些可以发布。</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>把老项目接入 PDLC</h3>
                <p class="post-excerpt"><code>/pdlc-adopt</code> 扫描既有代码库，补齐缺失的规范与设计文档，搭好 PDLC 目录结构 —— 不重写你的代码。</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>带趋势的迭代复盘</h3>
                <p class="post-excerpt"><code>/pdlc-retro</code> 把本期与历史状态机里的数据对比 —— "评审通过率下降"、"这一期 TDD 红灯被跳过"等趋势直接浮现。</p>
            </div>
        </div>
    </div>
</div>

<div class="about-section">
    <h2>📦 31 条命令，分三层</h2>
    <div class="about-grid">
        <div class="about-card">
            <h3>第一层 · 入口（3 条）</h3>
            <p><code>/pdlc-feature</code> · <code>/pdlc-fix</code> · <code>/pdlc-status</code></p>
            <p style="opacity: 0.75; font-size: 0.9em;">一句话 prompt 驱动整条链路。</p>
        </div>
        <div class="about-card">
            <h3>第二层 · 阶段（11 条）</h3>
            <p><code>prd</code> · <code>design</code> · <code>tdd</code> · <code>implement</code> · <code>review</code> · <code>e2e</code> · <code>refactor</code> · <code>ship</code> · <code>deploy</code> · <code>retro</code> · <code>task</code></p>
            <p style="opacity: 0.75; font-size: 0.9em;">精细控制单一阶段。</p>
        </div>
        <div class="about-card">
            <h3>第三层 · 工具（17 条）</h3>
            <p>UI 设计 / 数据库设计 / 架构 / 安全 / 性能 / 代码脚手架 / 添加服务 / 添加应用 / i18n / 迁移 / changelog / bootstrap / adopt / onboard / 等等</p>
            <p style="opacity: 0.75; font-size: 0.9em;">需要时显式调用的专项阶段。</p>
        </div>
        <div class="about-card">
            <h3>分发形式</h3>
            <p>作为标准的 <strong>Claude Code plugin</strong> 发布。安装后位于 <code>~/.claude/plugins/pdlc/</code>。</p>
            <p style="opacity: 0.75; font-size: 0.9em;">MIT 开源，GitHub 仓库公开。</p>
        </div>
    </div>
</div>

<h2 id="install">⬇️ 安装</h2>

<div class="about-grid">
    <div class="about-card">
        <h3>一行命令（全局）</h3>
        <p>装到 <code>~/.claude/plugins/pdlc/</code>，无需 clone。</p>
        <pre><code>curl -fsSL https://raw.githubusercontent.com/kanfu-panda/pdlc-skills/main/install.sh \
  | bash -s -- --global</code></pre>
    </div>
    <div class="about-card">
        <h3>仅作用于某个项目</h3>
        <p>装到指定项目的 <code>.claude/plugins/pdlc/</code>。</p>
        <pre><code>curl -fsSL https://raw.githubusercontent.com/kanfu-panda/pdlc-skills/main/install.sh \
  | bash -s -- --project /path/to/my-project</code></pre>
    </div>
</div>

### 等效原生命令

如果你更习惯直接用 Claude Code 自带的 plugin CLI：

```bash
claude plugin marketplace add kanfu-panda/pdlc-skills
claude plugin install pdlc@pdlc-skills
```

### 验证安装

```bash
claude plugin list | grep pdlc
# 预期：pdlc@pdlc-skills  Version: 1.0.0  Status: ✔ enabled
```

重启 Claude Code 会话后，在输入框敲 `/` 然后开始打 `pdlc-`，autocomplete 会列出全部 31 条子命令。

## 🧪 三步快速上手

```bash
# 1. 安装
curl -fsSL https://raw.githubusercontent.com/kanfu-panda/pdlc-skills/main/install.sh \
  | bash -s -- --global

# 2. 做一个功能（在 Claude Code 里）
/pdlc-feature 给登录加图形验证码

# 3. 修 bug
/pdlc-fix 翻页在空列表上崩溃
```

任何时候用 `/pdlc-status` 查进度。

## 🛡️ Iron Law（铁律）

每一条**产出产物的**第一层 / 第二层阶段都必须满足五条不变量。只读阶段（如 `/pdlc-status`）豁免。

1. **产物落盘** —— 每份产物都是磁盘上的真实文件，而不仅是对话输出
2. **更新状态机** —— 每个完成的阶段都把 `docs/.pdlc-state/<feature-id>.json` 写一遍
3. **测试先行** —— 实现阶段被失败的测试挡住（TDD 红灯）
4. **自检** —— 每个阶段在交接前跑一次自检
5. **自动修复仅一轮** —— 自动修复至多跑一次，卡壳的失败提交给人处理

## 📁 目标项目契约

阶段运行时，会读写你项目里的这些路径：

```
docs/00_standards/coding/                          # 编码规范（只读）
docs/01_requirements/prd/                          # PRD
docs/02_design/{api,database,architecture,ui-ux}/  # 技术设计
docs/03_development/                               # 开发者手册
docs/04_testing/{unit-tests,e2e-tests,defects,...} # 测试 & 缺陷
docs/05_deployment/                                # 部署文档
docs/06_tasks/                                     # 阶段内任务跟踪
docs/07_reviews/{doc,code,design,retro}/           # 评审记录
docs/.pdlc-state/<feature-id>.json                 # 每功能一份状态机
```

## 📄 协议

MIT。用、改、发都行。源码、issue、完整文档：**[github.com/kanfu-panda/pdlc-skills](https://github.com/kanfu-panda/pdlc-skills)**。

## ❓ 常见问题

**Q：不用 Claude Code 能用吗？**
不能 —— PDLC 是 Claude Code 的 plugin，依赖 Claude Code 的 plugin / slash command 基础设施。目前仅支持 Claude Code。

**Q：会不打招呼就改我代码吗？**
产出产物的阶段确实会写文件（到 `docs/` 和你的代码库）。每个阶段都会跑自检并在交接前显式提示。Claude Code 自带的权限确认提示也照常生效。

**Q：怎么定制模板？**
clone 仓库 → 改 `references/templates/*.md` 或 `skills/pdlc-*/SKILL.md` → 在 clone 目录跑 `bash install.sh --global` 装你定制后的版本。详见 [CONTRIBUTING.md](https://github.com/kanfu-panda/pdlc-skills/blob/main/CONTRIBUTING.md)。

**Q：发现 bug 或想讨论？**
用法 / 设计讨论走 [GitHub Discussions](https://github.com/kanfu-panda/pdlc-skills/discussions)；确认的 bug 走 [Issues](https://github.com/kanfu-panda/pdlc-skills/issues)。安全私信渠道见仓库内的 [SECURITY.md](https://github.com/kanfu-panda/pdlc-skills/blob/main/SECURITY.md)。

</div>
