---
layout: default
title: aitm
permalink: /aitm/
lang: en
description: aitm — a desktop terminal app with AI built in, available for macOS and Windows. Let the AI read your files, search command history, and run commands on demand. Every high-risk action requires your explicit confirmation.
---

<div class="hero-section">
    <div class="hero-content">
        <h1>aitm</h1>
        <p>A desktop terminal app with AI built in — for macOS and Windows.</p>
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

**Current version: v0.8.2**

<div class="about-grid">
    <div class="about-card">
        <h3>🍎 macOS Apple Silicon</h3>
        <p>dmg · 7.4 MB · aarch64 (M1/M2/M3/M4)</p>
        <p style="margin-top: 1rem;">
            <a href="/assets/downloads/aitm_0.8.2_aarch64.dmg" class="cta-button" download>Download .dmg →</a>
        </p>
        <p style="margin-top: 0.5rem; font-size: 0.85em;">
            <a href="/assets/downloads/aitm_0.8.2_aarch64.dmg.sha256">SHA256</a>
        </p>
    </div>
    <div class="about-card">
        <h3>🪟 Windows x86_64</h3>
        <p>Intel / AMD 64-bit</p>
        <p style="margin-top: 1rem;">
            <a href="/assets/downloads/aitm_0.8.2_x64_en-US.msi" class="cta-button" download>Download .msi · 7.1 MB →</a>
        </p>
        <p style="margin-top: 0.5rem; font-size: 0.85em;">
            or <a href="/assets/downloads/aitm_0.8.2_x64-setup.exe" download>NSIS .exe · 5.3 MB</a> ·
            <a href="/assets/downloads/aitm_0.8.2_x64_en-US.msi.sha256">SHA256 (msi)</a>
        </p>
    </div>
    <div class="about-card">
        <h3>🪟 Windows ARM64</h3>
        <p>Surface Pro X / Snapdragon</p>
        <p style="margin-top: 1rem;">
            <a href="/assets/downloads/aitm_0.8.2_arm64_en-US.msi" class="cta-button" download>Download .msi · 6.7 MB →</a>
        </p>
        <p style="margin-top: 0.5rem; font-size: 0.85em;">
            or <a href="/assets/downloads/aitm_0.8.2_arm64-setup.exe" download>NSIS .exe · 4.7 MB</a> ·
            <a href="/assets/downloads/aitm_0.8.2_arm64_en-US.msi.sha256">SHA256 (msi)</a>
        </p>
    </div>
</div>

### Install steps — macOS

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

### Install steps — Windows

> ⚠️ aitm isn't code-signed yet, so Windows SmartScreen / Defender may show a "Windows protected your PC" warning on first run. Click **More info → Run anyway**. The binary is fine.

**MSI installer (recommended):**

1. Double-click the downloaded `.msi`
2. Follow the wizard — installs per-user by default, no admin needed
3. Launch from Start menu: type "aitm"

**NSIS `.exe` installer (alternative, smaller):**

1. Double-click the downloaded `-setup.exe`
2. Pick install location → next → install
3. Launch from Start menu: type "aitm"

Pick MSI for org / IT deployment friendliness; pick NSIS if you want a leaner installer with a familiar wizard UI.

### Verify integrity (any platform)

Each installer ships with a `.sha256` file. Compare yours against it:

```bash
# macOS / Linux / Git Bash on Windows
shasum -a 256 path/to/aitm_0.8.2_<arch>.<ext>
```

```powershell
# Windows PowerShell
(Get-FileHash path\to\aitm_0.8.2_<arch>.<ext> -Algorithm SHA256).Hash.ToLower()
```

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

**Q: Double-clicking `aitm.app` (macOS) says "damaged, can't open"?**
That's a Gatekeeper false alarm because aitm isn't yet code-signed. Run `install-aitm.command` / `install-aitm.sh` per the [install steps](#download).

**Q: Windows shows a "Windows protected your PC" SmartScreen warning?**
Same root cause as the macOS one — aitm isn't code-signed yet. Click **More info → Run anyway**. We're tracking signing certificates for a future release.

**Q: Which platforms are supported?**
macOS Apple Silicon (M1/M2/M3/M4) and Windows on both x86_64 and ARM64 (Surface Pro X, Snapdragon laptops). Intel Mac and Linux are still on the roadmap.

**Q: MSI or NSIS — which one should I use on Windows?**
Either works. **MSI** is friendlier for org / IT deployment (Group Policy, auto-update tooling). **NSIS** (`.exe`) is smaller and uses a familiar wizard UI. For most personal users either is fine.

**Q: How is the API key managed?**
The API key is stored in your local aitm config directory only — never uploaded anywhere. We recommend creating a dedicated, scope-restricted key with a usage cap for aitm, and rotating it per your usual security practice.

**Q: Found a bug or want to chat?**
Reach out via the contact link on the [About page](/about/).

</div>
