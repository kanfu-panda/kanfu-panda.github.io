---
layout: default
title: About
permalink: /about/
lang: en
---

# About

## Hi there

I'm **Kungfu Panda** — only without the actual kungfu. A developer who's been writing code for a while, and occasionally building small tools on the side.

Programming is both my work and my hobby. I have a soft spot for turning "kind of works" into "actually pleasant to use", which is why I tend to ship apps alongside the tools that help me ship them.

This blog is where I collect technical notes, learning logs, and the occasional rabbit hole.

## What I'm working on

### 🪟 [aitm](/aitm/) — AI in the terminal

A macOS desktop terminal app that puts AI capabilities directly into your terminal workflow. Multi-tab PTY terminal + AI sidebar + AI tool-calling loop: the AI can read files, search command history, and propose commands — but every high-risk action requires your explicit confirmation.

Stack: Tauri 2 + Rust + React 19 + TypeScript. Full details on the [aitm product page](/aitm/).

### 📝 This blog

A pure static site built with Jekyll, hosted on GitHub Pages. The [repo is public](https://github.com/kanfu-panda/kanfu-panda.github.io) — theme, CI, security posture, and content are all there to reference.

## Tech stack

- **Primary languages**: Python, TypeScript / JavaScript, Rust
- **Frontend**: React, Tailwind, the xterm.js ecosystem
- **Desktop / systems**: Tauri 2, PTY and terminal protocols, IPC design
- **AI engineering**: Working daily with multiple LLM APIs, tool calling, agent loops
- **Infra**: Git, Docker, GitHub Actions, Jekyll, static-site engineering

Daily tools: VS Code mostly, occasionally IntelliJ; zsh on the command line; and the terminal — well, that's aitm, dogfooding while iterating.

## Currently learning

- Making AI tool-calling reliable: from "kinda works in demo" to "actually useful day-to-day"
- Rust async ecosystem, Tauri internals
- The terminal protocol family (ANSI / OSC / PTY)
- Smoother content workflows and publishing pipelines

## What you'll find on this blog

- **Tech notes** — learning logs on languages, frameworks, tools
- **How-tos** — debugging approaches, best practices, lessons learned
- **Project retrospectives** — the real path from idea to ship
- **The occasional essay** — not strictly technical

Posting cadence is irregular, but I try to make every piece useful to read.

## Interests

Outside of code:
- Reading (technical and otherwise)
- Tinkering with terminals, command lines, toolchains
- Following and occasionally contributing to open source

## Let's talk

If you're working on any of these — I'd love to hear from you:

- Desktop / terminal tool development
- AI engineering, especially turning flashy demos into actually-useful workflows
- Rust + Tauri projects
- Static sites and personal publishing setups

## Contact

- GitHub: [kanfu-panda](https://github.com/kanfu-panda)
- Email: <a id="contact-link" href="#" rel="nofollow">Contact me</a>

<script>
// Email is assembled client-side to avoid appearing as a continuous string in HTML source
(function () {
    var el = document.getElementById('contact-link');
    if (!el) return;
    var user = ['s', 'l', 'b', 'l', 'u', 'e', 'f', 'o', 'x'].join('');
    var host = ['g', 'm', 'a', 'i', 'l', '.', 'c', 'o', 'm'].join('');
    el.addEventListener('click', function (e) {
        e.preventDefault();
        window.location.href = 'mailto:' + user + '@' + host;
    });
})();
</script>
