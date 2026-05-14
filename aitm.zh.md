---
layout: default
title: aitm
permalink: /aitm/
description: aitm — 一个把 AI 能力做进终端的 macOS 桌面应用。让 AI 直接读文件、看命令历史、按需帮你执行命令，所有高危操作都要你点头确认。
---

<div class="hero-section">
    <div class="hero-content">
        <h1>aitm</h1>
        <p>一个把 AI 能力做进终端的 macOS 桌面应用。</p>
        <p>在熟悉的终端里直接和 AI 协作 —— AI 能读文件、查命令历史、必要时帮你执行命令，所有高危操作都要你点头才会发生。</p>
        <div class="hero-links">
            <a href="#download" class="cta-button">立即下载 →</a>
            <a href="#first-use" class="github-link">查看快速开始</a>
        </div>
    </div>
</div>

<div class="content-section" markdown="1">

<div class="about-section">
    <h2>✨ 核心能力</h2>
    <div class="about-grid">
        <div class="about-card">
            <h3>🪟 多 tab 原生终端</h3>
            <p>每个 tab 一个独立 PTY 进程，xterm.js + WebGL 渲染，输入响应即时。</p>
        </div>
        <div class="about-card">
            <h3>🤖 AI 侧栏</h3>
            <p>右侧抽屉式 AI 对话，流式响应、Markdown 渲染、随时呼出不打断手头终端工作。</p>
        </div>
        <div class="about-card">
            <h3>🔧 AI 工具调用闭环</h3>
            <p>AI 不只给指令——能直接查文件、看命令历史、按需执行命令。每个高危动作都先弹窗等你确认。</p>
        </div>
        <div class="about-card">
            <h3>🔔 系统通知</h3>
            <p>长任务跑完、AI 等待审批，自动发系统通知 + 任务栏小红点。<code>⌘⇧U</code> 直接跳到最近未读。</p>
        </div>
        <div class="about-card">
            <h3>📋 Tab 元信息</h3>
            <p>每个 tab 上直接显示当前 git 分支 / dirty 状态 / 监听端口，多 tab 来回切不再迷失方向。</p>
        </div>
        <div class="about-card">
            <h3>🧭 AI 知道你在哪</h3>
            <p>AI 调用工具读终端历史时自动带上当前 git 分支、工作目录、占用端口，不用反复"先告诉它你在哪"。</p>
        </div>
        <div class="about-card">
            <h3>🎨 布局可调</h3>
            <p>AI 侧栏与文件树左右位置任你切换，适应不同主屏 / 副屏的工作姿势。</p>
        </div>
    </div>
</div>

<div class="recent-posts">
    <h2>🎯 它能帮你做什么</h2>
    <div class="post-grid">
        <div class="post-card">
            <div class="post-content">
                <h3>让 AI 看一眼项目结构</h3>
                <p class="post-excerpt">直接问 "项目根目录有什么"，AI 会自动调用文件浏览与读取工具，几秒后给出结构总结，省去自己 <code>ls -R</code> + 翻文件的工夫。</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>把执行权交给 AI（但你说了算）</h3>
                <p class="post-excerpt">AI 给出建议命令并请求执行 → 弹出确认框告诉你"将要运行：xxx" → 你点 OK 才真正在终端里跑。AI 看到输出，自动判断下一步。</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>回顾刚才那条命令</h3>
                <p class="post-excerpt">"我刚才跑的那条 build 命令是什么？" AI 直接查当前 tab 的命令历史并搜索关键词，比翻屏 / Ctrl+R 快。</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>长任务后台跑，做完叫你</h3>
                <p class="post-excerpt">编译 / 测试 / 部署任务跑完，系统通知自动弹出；AI 完成一轮对话或需要你审批时，tab 栏的状态环会变色提醒。</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>多模型按需切换</h3>
                <p class="post-excerpt">国内外 6 家 LLM 任选，调试问题、写文案、代码改造可以分别配最合适的模型，不被一家锁死。</p>
            </div>
        </div>
    </div>
</div>

<div class="about-section">
    <h2>🧠 支持的 AI 提供方</h2>
    <div class="about-grid">
        <div class="about-card">
            <h3>国内</h3>
            <p>DeepSeek · 通义千问（DashScope）· 智谱 GLM · Moonshot Kimi</p>
        </div>
        <div class="about-card">
            <h3>海外</h3>
            <p>OpenAI · Anthropic Claude</p>
        </div>
        <div class="about-card">
            <h3>配置方式</h3>
            <p>设置面板 → AI Provider → 选模型 + 填 API Key → 保存即可，无需重启。</p>
        </div>
        <div class="about-card">
            <h3>切换成本</h3>
            <p>OpenAI 兼容协议统一抽象，换 Provider 不影响对话历史和工具调用行为。</p>
        </div>
    </div>
</div>

<h2 id="download">⬇️ 下载</h2>

<div class="about-grid">
    <div class="about-card">
        <h3>当前版本</h3>
        <p><strong>v0.5.2</strong> · macOS Apple Silicon (aarch64) · 6.3 MB</p>
        <p style="margin-top: 1rem;">
            <a href="/assets/downloads/aitm_0.5.2_aarch64.dmg" class="cta-button" download>下载 dmg →</a>
        </p>
    </div>
    <div class="about-card">
        <h3>校验完整性（推荐）</h3>
        <p>下载完后，请校验文件 SHA256：</p>
        <pre><code>shasum -a 256 ~/Downloads/aitm_0.5.2_aarch64.dmg</code></pre>
        <p>结果应与 <a href="/assets/downloads/aitm_0.5.2_aarch64.dmg.sha256">官方校验和</a> 完全一致。</p>
    </div>
</div>

### 安装步骤

> ⚠️ aitm 当前阶段尚未带 Apple Developer 签名。macOS 会给通过浏览器下载的未签名 .app 自动加 quarantine 标记，双击启动会报 **"aitm 已损坏，无法打开"** —— 这是 Gatekeeper 的误导文案，文件本身没问题。dmg 内已附带一键安装脚本帮你处理。

1. 下载并打开上面的 dmg，Finder 会显示三个图标：
   - `aitm.app`
   - `Applications`（指向 /Applications 的符号链接）
   - `install-aitm.command`
2. **双击 `install-aitm.command`**（macOS 会自动用终端执行）
   - 它会把 `aitm.app` 拷到 `/Applications/`
   - 同时清掉 quarantine 标记
3. 看到 `✅ 安装完成` 后按任意键关掉终端窗口
4. 通过 Launchpad 或 Spotlight 搜 "aitm" 启动

如果 dmg 内的 `install-aitm.command` 没法运行，可以单独下载 <a href="/assets/downloads/install-aitm.sh">install-aitm.sh</a> 作为后备方案：

```bash
bash ~/Downloads/install-aitm.sh
```

脚本无需 `sudo`，只会操作 `/Applications/aitm.app` 和你指定的 dmg。

<h2 id="first-use">🚀 第一次使用</h2>

1. **启动应用**：Launchpad 或 Spotlight 搜 "aitm"
2. **配置 AI Provider**：右上角设置图标 → AI Provider → 任选一家 → 填入对应平台申请的 API Key → 保存
3. **（可选）初始化项目作用域**：在任意终端 tab `cd` 到项目根目录后执行
   ```bash
   aitm init
   # 或显式指定路径和名称
   aitm init /path/to/project --name my-app
   ```
   AI 工具调用的文件读写会被限制在这个目录边界内，避免越界。
4. **唤出 AI 侧栏**：点右侧栏图标，或使用快捷键
5. **第一次对话**：直接发问，例如 *"看一下项目根目录有什么文件"*。AI 会按需调用工具；遇到执行命令这类操作时会弹确认框。

## 🛡️ 安全设计

- **本地优先存储**：终端会话与命令历史保存在你本机；aitm 本身不会把这些数据上传到任何后台服务。AI 对话内容仅在你主动发送时按所选 Provider 的协议送达对应模型方。
- **AI 工具范围可控**：通过 `aitm init` 划定的项目目录边界，AI 文件读取不会越界。
- **高危命令拦截**：内置一道黑名单规则，例如 `rm -rf /` / `dd of=/dev/...` / fork bomb 等典型危险模式无法被 AI 触发。
- **执行需确认**：AI 想运行任何命令前都会先弹确认框，你能看到完整命令再决定是否放行。
- **工具循环上限**：单轮对话内最多自动循环若干次工具调用，防止失控。

## ❓ 常见问题

**Q：双击 `aitm.app` 提示 "已损坏，无法打开"？**
就是 Gatekeeper 误报，按 [安装步骤](#download) 里的 `install-aitm.command` / `install-aitm.sh` 跑一遍即可。

**Q：暂时只支持 macOS Apple Silicon 吗？**
是的。当前版本只针对 Apple Silicon（M1/M2/M3/M4 系列）构建。Intel Mac 和 Linux 支持后续考虑。

**Q：API Key 怎么管理？**
API Key 仅保存在你本机的 aitm 用户配置目录中，不会上传任何外部服务器。建议为 aitm 单独申请一个权限最小化、额度受限的 Key，并按你常规的安全实践定期轮换。

**Q：发现了 bug 或想反馈？**
欢迎通过 [关于页面](/about/) 的邮箱联系作者。

</div>
