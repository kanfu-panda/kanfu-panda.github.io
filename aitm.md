---
layout: default
title: aitm
permalink: /aitm/
lang: en
description: aitm — a desktop terminal app with AI built in, for macOS and Windows. The AI reads and edits files, runs commands, and drives a built-in browser. Every high-risk action requires your explicit confirmation. Open source under Apache-2.0.
---

<div class="hero-section">
    <div class="hero-content">
        <h1>aitm</h1>
        <p>A desktop terminal app with AI built in — for macOS and Windows.</p>
        <p>Work with AI inside the terminal you already know — the AI reads and edits files, runs commands, and drives a built-in browser. Every high-risk action waits for your explicit OK.</p>
        <p style="opacity: 0.8; font-size: 0.92em;">Open source under Apache-2.0 — code and every installer live on GitHub.</p>
        <div class="hero-links">
            <a href="#download" class="cta-button">Download now →</a>
            <a href="https://github.com/kanfu-panda/aitm" class="github-link">View source on GitHub</a>
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
            <p>The AI doesn't just suggest — it reads files, edits them, runs commands, and drives the browser. Edits show a real diff before they apply, and commands report their actual exit code rather than whatever arrived after a fixed wait. Every high-risk action shows a confirm dialog first.</p>
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
        <div class="about-card">
            <h3>📝 Built-in file editor</h3>
            <p>Open and edit project files inline with a CodeMirror-powered editor — syntax highlighting included, no need to flip to another window.</p>
        </div>
        <div class="about-card">
            <h3>🌐 Built-in browser panel</h3>
            <p>Read docs without leaving the terminal. Tabs — with their zoom level — survive a restart, and one toggle requests a site's mobile version. The AI can open and navigate it too, and only ever drives the tab you can see.</p>
        </div>
        <div class="about-card">
            <h3>🧩 Claude Code skills support</h3>
            <p>Skills under <code>~/.claude/skills/</code>, a project's <code>.claude/skills/</code>, and plugin marketplaces are all discovered automatically. The AI searches and loads them on demand, so hundreds of them cost almost no context.</p>
        </div>
        <div class="about-card">
            <h3>💾 Your session comes back</h3>
            <p>Terminal tabs, split layout, and open files reopen in the directories they were in — no "restore previous session?" dialog on every launch. Switch it off in Settings if you'd rather start clean.</p>
        </div>
        <div class="about-card">
            <h3>⌨️ Command palette</h3>
            <p><code>⌘⇧P</code> searches and runs any keyboard action, each entry showing its current binding — so it doubles as a way to learn the shortcuts. <code>⌘1</code>–<code>⌘9</code> switch tabs within the focused split.</p>
        </div>
        <div class="about-card">
            <h3>🚩 Hallucination flagging</h3>
            <p>If a reply claims it wrote a file or opened a page but no matching tool was actually called that turn, the message gets flagged. Some models assert success without acting; this makes it visible instead of silent.</p>
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

**Current version: v1.4.3**

> macOS binaries are signed and notarized with an Apple Developer ID. Windows binaries aren't code-signed yet — [SignPath Foundation](https://signpath.org) signing (a non-profit supporting open-source code signing) is planned for a future release. See the [Code Signing Policy](https://github.com/kanfu-panda/aitm/blob/main/docs/CODE_SIGNING.md) for details.

<div class="about-grid">
    <div class="about-card">
        <h3>🍎 macOS Apple Silicon</h3>
        <p>dmg · 7.2 MB · aarch64 (M1/M2/M3/M4)</p>
        <p style="margin-top: 1rem;">
            <a href="https://github.com/kanfu-panda/aitm/releases/download/v1.4.3/aitm_1.4.3_aarch64.dmg" class="cta-button">Download .dmg →</a>
        </p>
        <p style="margin-top: 0.5rem; font-size: 0.85em;">
            <a href="https://github.com/kanfu-panda/aitm/releases/tag/v1.4.3">Release page</a>
        </p>
    </div>
    <div class="about-card">
        <h3>🪟 Windows x86_64</h3>
        <p>Intel / AMD 64-bit</p>
        <p style="margin-top: 1rem;">
            <a href="https://github.com/kanfu-panda/aitm/releases/download/v1.4.3/aitm_1.4.3_x64_en-US.msi" class="cta-button">Download .msi · x64 →</a>
        </p>
        <p style="margin-top: 0.5rem; font-size: 0.85em;">
            or <a href="https://github.com/kanfu-panda/aitm/releases/download/v1.4.3/aitm_1.4.3_x64-setup.exe">NSIS .exe</a> ·
            <a href="https://github.com/kanfu-panda/aitm/releases/tag/v1.4.3">Release page</a>
        </p>
    </div>
    <div class="about-card">
        <h3>🪟 Windows ARM64</h3>
        <p>Surface Pro X / Snapdragon</p>
        <p style="margin-top: 1rem;">
            <a href="https://github.com/kanfu-panda/aitm/releases/download/v1.4.3/aitm_1.4.3_arm64_en-US.msi" class="cta-button">Download .msi · ARM64 →</a>
        </p>
        <p style="margin-top: 0.5rem; font-size: 0.85em;">
            or <a href="https://github.com/kanfu-panda/aitm/releases/download/v1.4.3/aitm_1.4.3_arm64-setup.exe">NSIS .exe</a> ·
            <a href="https://github.com/kanfu-panda/aitm/releases/tag/v1.4.3">Release page</a>
        </p>
    </div>
</div>

### Install steps — macOS

aitm is signed with an Apple Developer ID and notarized — Gatekeeper will let it through automatically.

1. Download and open the dmg above
2. Drag `aitm.app` to the `Applications` folder
3. Launch via Launchpad or Spotlight: search "aitm"

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

Want to make sure your download wasn't corrupted in transit? Compute its SHA-256 hash:

```bash
# macOS / Linux / Git Bash on Windows
shasum -a 256 path/to/aitm_1.4.3_<arch>.<ext>
```

```powershell
# Windows PowerShell
(Get-FileHash path\to\aitm_1.4.3_<arch>.<ext> -Algorithm SHA256).Hash.ToLower()
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
aitm is signed and notarized with an Apple Developer ID — Gatekeeper should let it through automatically. If you see this error, make sure you downloaded the dmg from the [official release page](https://github.com/kanfu-panda/aitm/releases/tag/v1.4.3) and that the file wasn't corrupted in transit (verify the SHA256 checksum).

**Q: Windows shows a "Windows protected your PC" SmartScreen warning?**
aitm for Windows isn't code-signed yet. Click **More info → Run anyway**. We're tracking signing certificates for a future release.

**Q: Which platforms are supported?**
macOS Apple Silicon (M1/M2/M3/M4) and Windows on both x86_64 and ARM64 (Surface Pro X, Snapdragon laptops). Intel Mac and Linux are still on the roadmap.

**Q: MSI or NSIS — which one should I use on Windows?**
Either works. **MSI** is friendlier for org / IT deployment (Group Policy, auto-update tooling). **NSIS** (`.exe`) is smaller and uses a familiar wizard UI. For most personal users either is fine.

**Q: How is the API key managed?**
The API key is stored in your local aitm config directory only — never uploaded anywhere. We recommend creating a dedicated, scope-restricted key with a usage cap for aitm, and rotating it per your usual security practice.

**Q: Is aitm open source?**
Yes — **Apache-2.0**. Source, issues, and installers for every platform live at [github.com/kanfu-panda/aitm](https://github.com/kanfu-panda/aitm).

**Q: How do I get new versions?**
On macOS the app updates itself: check on demand under Settings → About, and it checks in the background every six hours — then downloads, verifies the signature, installs and restarts, so there's no dragging a `.dmg` over the old app. Windows still gets a notice and a link to the installer for your platform. Note that v1.3.0 and earlier shipped without the updater, so those need one manual install first.

**Q: Found a bug or want to chat?**
Reach out via the contact link on the [About page](/about/).

</div>
