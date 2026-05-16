---
layout: default
title: aitm
permalink: /aitm/
lang: en
description: aitm — a macOS desktop terminal app with AI built in. Let the AI read your files, search command history, and run commands on demand. Every high-risk action requires your explicit confirmation.
---

<div class="hero-section">
    <div class="hero-content">
        <h1>aitm</h1>
        <p>A macOS desktop terminal app with AI built in.</p>
        <p>Work with AI inside the terminal you already know — the AI can read files, search command history, and run commands when you ask. Every high-risk action waits for your explicit OK.</p>
        <div class="hero-links">
            <a href="#download" class="cta-button">Download now →</a>
            <a href="#first-use" class="github-link">Quick start</a>
        </div>
    </div>
</div>

<div class="content-section" markdown="1">

<div class="about-section">
    <h2>✨ Core capabilities</h2>
    <div class="about-grid">
        <div class="about-card">
            <h3>🪟 Multi-tab native terminal</h3>
            <p>Each tab is its own PTY process. xterm.js + WebGL rendering keeps input snappy.</p>
        </div>
        <div class="about-card">
            <h3>🤖 AI sidebar</h3>
            <p>A drawer-style AI chat on the right — streaming responses, Markdown rendering, summonable any time without disrupting your terminal work.</p>
        </div>
        <div class="about-card">
            <h3>🔧 AI tool-calling loop</h3>
            <p>The AI doesn't just suggest commands — it can read files, search command history, and run commands on demand. Every high-risk action shows a confirm dialog first.</p>
        </div>
        <div class="about-card">
            <h3>🔔 System notifications</h3>
            <p>Long task done? AI waiting for approval? You get a macOS notification with a status dot in the dock. <code>⌘⇧U</code> jumps straight to the most recent unread.</p>
        </div>
        <div class="about-card">
            <h3>📋 Tab metadata</h3>
            <p>Each tab surfaces its current git branch / dirty state / listening ports — no more losing track when juggling many tabs.</p>
        </div>
        <div class="about-card">
            <h3>🧭 The AI knows where you are</h3>
            <p>When the AI reads terminal history, it automatically gets your current git branch, working directory, and listening ports as context — no need to keep re-explaining "where you are."</p>
        </div>
        <div class="about-card">
            <h3>🎨 Flexible layout</h3>
            <p>Move the AI sidebar and file tree to whichever side suits your screen setup.</p>
        </div>
    </div>
</div>

<div class="recent-posts">
    <h2>🎯 What you can do with it</h2>
    <div class="post-grid">
        <div class="post-card">
            <div class="post-content">
                <h3>Have AI scan your project structure</h3>
                <p class="post-excerpt">Just ask "what's in my project root?" — the AI calls the file-browse and read tools and gives you a structured summary, saving you <code>ls -R</code> and flipping through files.</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>Delegate execution to AI (but you stay in charge)</h3>
                <p class="post-excerpt">AI proposes a command and requests execution → confirm dialog shows you "about to run: xxx" → you approve → command runs in your terminal. AI sees the output and decides the next step.</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>Recall what you just ran</h3>
                <p class="post-excerpt">"What was that build command I ran earlier?" — the AI reads the current tab's command history and finds it faster than scrolling or Ctrl+R.</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>Run long tasks in the background, get notified</h3>
                <p class="post-excerpt">When a build / test / deploy finishes, a system notification pops up. When the AI completes a turn or needs your approval, the status ring on the tab bar changes color.</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>Switch between models as needed</h3>
                <p class="post-excerpt">Choose from 6 LLM providers. Use one model for debugging, another for writing, another for code transformations — never locked into a single vendor.</p>
            </div>
        </div>
    </div>
</div>

<div class="about-section">
    <h2>🧠 Supported AI providers</h2>
    <div class="about-grid">
        <div class="about-card">
            <h3>China-based</h3>
            <p>DeepSeek · Qwen (DashScope) · Zhipu GLM · Moonshot Kimi</p>
        </div>
        <div class="about-card">
            <h3>International</h3>
            <p>OpenAI · Anthropic Claude</p>
        </div>
        <div class="about-card">
            <h3>How to configure</h3>
            <p>Settings → AI Provider → pick a model + paste your API key → save. No restart needed.</p>
        </div>
        <div class="about-card">
            <h3>Switching cost</h3>
            <p>A unified OpenAI-compatible abstraction means swapping providers doesn't break your chat history or tool-calling behavior.</p>
        </div>
    </div>
</div>

<h2 id="download">⬇️ Download</h2>

<div class="about-grid">
    <div class="about-card">
        <h3>Current version</h3>
        <p><strong>v0.6.0</strong> · macOS Apple Silicon (aarch64) · 6.4 MB</p>
        <p style="margin-top: 1rem;">
            <a href="/assets/downloads/aitm_0.6.0_aarch64.dmg" class="cta-button" download>Download dmg →</a>
        </p>
    </div>
    <div class="about-card">
        <h3>Verify integrity (recommended)</h3>
        <p>After downloading, check the SHA256:</p>
        <pre><code>shasum -a 256 ~/Downloads/aitm_0.6.0_aarch64.dmg</code></pre>
        <p>It should match the <a href="/assets/downloads/aitm_0.6.0_aarch64.dmg.sha256">official checksum</a> exactly.</p>
    </div>
</div>

### Install steps

> ⚠️ aitm doesn't yet ship with an Apple Developer signature. macOS automatically attaches a quarantine attribute to any unsigned .app downloaded via browser — double-clicking will show **"aitm is damaged and can't be opened"**. That's a misleading Gatekeeper message; the file is fine. The dmg includes a one-click install script to handle this for you.

1. Download and open the dmg above. Finder will show three icons:
   - `aitm.app`
   - `Applications` (symlink to /Applications)
   - `install-aitm.command`
2. **Double-click `install-aitm.command`** (macOS opens it in Terminal automatically)
   - It copies `aitm.app` to `/Applications/`
   - And clears the quarantine attribute
3. When you see `✅ Install complete`, press any key to close the Terminal window
4. Launch via Launchpad or Spotlight: search "aitm"

If the bundled `install-aitm.command` fails for any reason, you can download <a href="/assets/downloads/install-aitm.sh">install-aitm.sh</a> separately as a fallback:

```bash
bash ~/Downloads/install-aitm.sh
```

The script doesn't require `sudo` and only touches `/Applications/aitm.app` and the dmg you point it at.

<h2 id="first-use">🚀 First-time use</h2>

1. **Launch the app**: Launchpad or Spotlight, search "aitm"
2. **Configure an AI provider**: top-right settings icon → AI Provider → pick one → paste the API key you got from that platform → save
3. **(Optional) Initialize a project scope**: in any terminal tab, `cd` to your project root, then run
   ```bash
   aitm init
   # or with explicit path / name
   aitm init /path/to/project --name my-app
   ```
   The AI's file-read tools will be confined to this directory boundary.
4. **Open the AI sidebar**: click the right rail icon or use the keyboard shortcut
5. **Have your first conversation**: just ask something like *"show me what's in the project root"*. The AI will call tools as needed; for command-execution actions, a confirm dialog will pop up.

## 🛡️ Security design

- **Local-first storage**: Terminal sessions and command history live on your machine. aitm itself never uploads this data to any backend. AI conversation content only goes to the provider you've configured, when you actively send a message.
- **Bounded AI tool scope**: The `aitm init` project boundary keeps AI file reads inside that directory.
- **High-risk command blacklist**: Patterns like `rm -rf /` / `dd of=/dev/...` / fork bombs cannot be triggered by the AI.
- **Execution requires confirmation**: Before running any command, the AI shows you the full command in a confirm dialog. Nothing runs without your approval.
- **Tool-loop limit**: Within a single conversation, automatic tool calls are capped to prevent runaway loops.

## ❓ FAQ

**Q: Double-clicking `aitm.app` says "damaged, can't open"?**
That's a Gatekeeper false alarm. Run `install-aitm.command` / `install-aitm.sh` per the [install steps](#download).

**Q: Is it Apple Silicon only for now?**
Yes. The current build targets Apple Silicon (M1/M2/M3/M4 series). Intel Mac and Linux support are on the roadmap.

**Q: How is the API key managed?**
The API key is stored in your local aitm config directory only — never uploaded anywhere. We recommend creating a dedicated, scope-restricted key with a usage cap for aitm, and rotating it per your usual security practice.

**Q: Found a bug or want to chat?**
Reach out via the contact link on the [About page](/about/).

</div>
