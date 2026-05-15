---
layout: default
title: PDLC
permalink: /pdlc/
lang: en
description: PDLC — a Claude Code plugin that turns the soft conventions of product development into hard contracts. 31 slash commands, persisted artifacts, mandatory tests-first, state machine per feature. MIT-licensed and open source.
---

<div class="hero-section">
    <div class="hero-content">
        <h1>PDLC</h1>
        <p>A <strong>Claude Code plugin</strong> that gives Claude a complete Product Development Life Cycle workflow.</p>
        <p>31 standardized stages exposed as slash commands. Every artifact lands on disk, every stage updates a state machine, tests must exist before code. Soft conventions become hard contracts.</p>
        <div class="hero-links">
            <a href="https://github.com/kanfu-panda/pdlc-skills" class="cta-button">View on GitHub →</a>
            <a href="#install" class="github-link">Install</a>
        </div>
    </div>
</div>

<div class="content-section" markdown="1">

<div class="about-section">
    <h2>✨ Why PDLC</h2>
    <div class="about-grid">
        <div class="about-card">
            <h3>📝 Artifacts on disk</h3>
            <p>Every stage produces real files under <code>docs/</code>. No more "PRDs that only live in the chat transcript." You can <code>git diff</code> exactly what the AI did.</p>
        </div>
        <div class="about-card">
            <h3>📊 State machine per feature</h3>
            <p><code>docs/.pdlc-state/&lt;feature-id&gt;.json</code> records every stage transition. <code>/pdlc-status</code> always knows where each feature stands.</p>
        </div>
        <div class="about-card">
            <h3>🚦 Tests before code</h3>
            <p>A hard TDD red-light gate. Implementation is blocked until failing tests exist. No more retroactive "let me also write some tests."</p>
        </div>
        <div class="about-card">
            <h3>🔍 Self-check at every handoff</h3>
            <p>Each stage runs a self-audit before transitioning. Drift is caught at the stage boundary, not weeks later in review.</p>
        </div>
        <div class="about-card">
            <h3>🛠️ One-shot auto-repair</h3>
            <p>Auto-fix loops run at most once. Stubborn failures are surfaced to humans rather than spiraling in "fix → check → fix" forever.</p>
        </div>
        <div class="about-card">
            <h3>🧭 Explicit next_step</h3>
            <p>Every stage declares its successor. Multi-stage flows are command-driven, not memorized by you or the AI.</p>
        </div>
    </div>
</div>

<div class="recent-posts">
    <h2>🎯 What it does for you</h2>
    <div class="post-grid">
        <div class="post-card">
            <div class="post-content">
                <h3>Ship a feature end-to-end</h3>
                <p class="post-excerpt"><code>/pdlc-feature add phone-number verification to login</code> — PDLC walks through PRD → Design → TDD → Implement → Review → Ship, persisting every artifact along the way.</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>Fix a bug with audit trail</h3>
                <p class="post-excerpt"><code>/pdlc-fix the pagination crash on empty lists</code> — locate, reproduce, fix, test, document. The defect file in <code>docs/04_testing/defects/</code> outlives the chat session.</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>See where every feature stands</h3>
                <p class="post-excerpt"><code>/pdlc-status</code> reads every state machine file and shows you at a glance which features are in PRD, which are in TDD red light, which are ready to ship.</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>Adopt a legacy project</h3>
                <p class="post-excerpt"><code>/pdlc-adopt</code> surveys an existing codebase, fills in missing standards and design docs, and bootstraps the PDLC layout — without rewriting your code.</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>Run a retrospective with trends</h3>
                <p class="post-excerpt"><code>/pdlc-retro</code> compares the current iteration against past data captured in state machines — surfacing trends like "review pass rate dropped" or "TDD red-light skipped this sprint."</p>
            </div>
        </div>
    </div>
</div>

<div class="about-section">
    <h2>📦 The 31 commands, three layers</h2>
    <div class="about-grid">
        <div class="about-card">
            <h3>Layer 1 · Entry points (3)</h3>
            <p><code>/pdlc-feature</code> · <code>/pdlc-fix</code> · <code>/pdlc-status</code></p>
            <p style="opacity: 0.75; font-size: 0.9em;">One-sentence prompts drive the whole chain.</p>
        </div>
        <div class="about-card">
            <h3>Layer 2 · Stages (11)</h3>
            <p><code>prd</code> · <code>design</code> · <code>tdd</code> · <code>implement</code> · <code>review</code> · <code>e2e</code> · <code>refactor</code> · <code>ship</code> · <code>deploy</code> · <code>retro</code> · <code>task</code></p>
            <p style="opacity: 0.75; font-size: 0.9em;">Fine-grained control over individual stages.</p>
        </div>
        <div class="about-card">
            <h3>Layer 3 · Tools (17)</h3>
            <p>UI / DB / architecture / security / perf / code-gen / scaffolding / i18n / migration / changelog / bootstrap / adopt / onboard / etc.</p>
            <p style="opacity: 0.75; font-size: 0.9em;">Specialized stages you can invoke explicitly.</p>
        </div>
        <div class="about-card">
            <h3>Distribution</h3>
            <p>Shipped as a standard <strong>Claude Code plugin</strong>. <code>~/.claude/plugins/pdlc/</code> after install.</p>
            <p style="opacity: 0.75; font-size: 0.9em;">MIT license · open source on GitHub.</p>
        </div>
    </div>
</div>

<h2 id="install">⬇️ Install</h2>

<div class="about-grid">
    <div class="about-card">
        <h3>One-liner (global)</h3>
        <p>Installs to <code>~/.claude/plugins/pdlc/</code>. No clone needed.</p>
        <pre><code>curl -fsSL https://raw.githubusercontent.com/kanfu-panda/pdlc-skills/main/install.sh \
  | bash -s -- --global</code></pre>
    </div>
    <div class="about-card">
        <h3>Project-scoped</h3>
        <p>Installs into a specific project's <code>.claude/plugins/pdlc/</code>.</p>
        <pre><code>curl -fsSL https://raw.githubusercontent.com/kanfu-panda/pdlc-skills/main/install.sh \
  | bash -s -- --project /path/to/my-project</code></pre>
    </div>
</div>

### Equivalent native commands

If you'd rather use Claude Code's plugin CLI directly:

```bash
claude plugin marketplace add kanfu-panda/pdlc-skills
claude plugin install pdlc@pdlc-skills
```

### Verify the install

```bash
claude plugin list | grep pdlc
# expected: pdlc@pdlc-skills  Version: 1.0.0  Status: ✔ enabled
```

After restarting your Claude Code session, type `/` and start typing `pdlc-` — autocomplete will show all 31 sub-commands.

## 🧪 Quick start (3 steps)

```bash
# 1. Install
curl -fsSL https://raw.githubusercontent.com/kanfu-panda/pdlc-skills/main/install.sh \
  | bash -s -- --global

# 2. Ship a feature (in Claude Code)
/pdlc-feature add a captcha to login

# 3. Fix a bug
/pdlc-fix the pagination crash on empty lists
```

Check progress any time with `/pdlc-status`.

## 🛡️ The Iron Law

Every Layer 1 / Layer 2 stage that **produces artifacts** enforces five invariants. Read-only stages (such as `/pdlc-status`) are exempt.

1. **Persist to disk** — every artifact is a real file, not just chat output
2. **Update the state machine** — every completed stage writes `docs/.pdlc-state/<feature-id>.json`
3. **Tests first** — code cannot be implemented until a failing test exists (TDD red light)
4. **Self-check** — every stage runs a self-audit before handing off
5. **One-shot repair** — auto-fix loops run at most once; stubborn failures get flagged for humans

## 📁 Target-project contract

When a stage runs, it reads and writes these paths in your project:

```
docs/00_standards/coding/                          # coding standards (read-only)
docs/01_requirements/prd/                          # PRDs
docs/02_design/{api,database,architecture,ui-ux}/  # technical design
docs/03_development/                               # developer manuals
docs/04_testing/{unit-tests,e2e-tests,defects,...} # tests & defects
docs/05_deployment/                                # deployment docs
docs/06_tasks/                                     # in-stage task tracking
docs/07_reviews/{doc,code,design,retro}/           # review records
docs/.pdlc-state/<feature-id>.json                 # per-feature state machine
```

## 📄 License

MIT. Use it, fork it, ship it. Source code, issue tracker, and full documentation: **[github.com/kanfu-panda/pdlc-skills](https://github.com/kanfu-panda/pdlc-skills)**.

## ❓ FAQ

**Q: Does it work without Claude Code?**
No — PDLC is a Claude Code plugin that uses Claude Code's plugin / slash-command infrastructure. Currently Claude Code is the only target.

**Q: Will it modify my code without asking?**
Stages that produce artifacts do write files (under `docs/` and your code base when implementing). Each stage runs a self-check and surfaces a handoff before continuing to the next. Your normal Claude Code permission prompts still apply.

**Q: How do I customize templates?**
Clone the repo, edit `references/templates/*.md` or `skills/pdlc-*/SKILL.md`, then run `bash install.sh --global` from the clone to install your customized version. See [CONTRIBUTING.md](https://github.com/kanfu-panda/pdlc-skills/blob/main/CONTRIBUTING.md).

**Q: Found a bug or want to discuss?**
Use [GitHub Discussions](https://github.com/kanfu-panda/pdlc-skills/discussions) for design/usage questions, [Issues](https://github.com/kanfu-panda/pdlc-skills/issues) for confirmed bugs. For private security concerns, see the project's [SECURITY.md](https://github.com/kanfu-panda/pdlc-skills/blob/main/SECURITY.md).

</div>
