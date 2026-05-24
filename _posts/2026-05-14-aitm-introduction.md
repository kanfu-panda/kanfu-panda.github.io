---
layout: post
title: "aitm launch: AI inside the terminal"
date: 2026-05-14
lang: en
categories: [blog]
tags: [aitm, terminal, AI, macOS, Windows, tool]
excerpt: "A desktop terminal app with AI built in, for macOS and Windows. The AI can read files, search command history, and run commands on demand — every high-risk action waits for your explicit OK. Latest version: v0.10.6."
---

## What it is

[aitm](/aitm/) is a desktop terminal app that bakes AI capabilities right into the terminal experience.

- **Regular terminal**: you type a command, watch the output, figure out the next move yourself.
- **aitm**: you can talk to the AI directly; it can read files, search command history, and propose commands to run — but every actual execution waits for your **explicit approval**.

In short: **let the AI join your workflow without taking it over**.

## Why I built this

The usual loop — open terminal, then open a browser, copy-paste a question to an AI, paste the answer back — has too much context-switching. Existing "AI terminals" tend to fall into one of two extremes: a chat window glued onto a terminal but no tool execution, or a fully AI-driven agent where you can't see what's happening.

aitm aims at the middle:

> The AI can see your environment (files / command history / terminal output) and can act on it (run commands, read files), but you stay in charge. The AI proposes; you click the button.

## What this release brings

### 1. Closed AI tool-calling loop

The AI doesn't just suggest things — it calls a controlled set of tools directly:

- Browse directories, read files
- Read terminal command history, search by keyword
- Propose commands to run and wait for your green light

Every execution shows a confirm dialog with the full command first.

### 2. AI knows "where you are"

When the AI calls a tool like "read terminal history", aitm automatically prepends the current git branch, working directory, and listening ports as context. The AI knows what project you're in, whether the working tree is dirty, what services are up — without you re-explaining.

### 3. Tab-level metadata at a glance

Each tab now shows current git branch, dirty state, unpushed commits, and listening ports on the right. With multiple tabs running, you can tell each project's status at a glance.

### 4. System notifications

Long task finished, AI waiting for your approval, AI completed its current turn — aitm sends a macOS / Windows system notification proactively so you don't have to watch the window.

Each tab has a status ring (amber pulsing = approval pending / pink = error / blue = running / green = done). <kbd>⌘</kbd> + <kbd>⇧</kbd> + <kbd>U</kbd> globally jumps to the tab with the most recent unread and opens the AI sidebar.

### 5. Compatible with standard terminal notification protocols

The backend parses OSC 9 / OSC 99 / OSC 777 and similar protocols — most CLI tools that emit "I'm done" notifications work out of the box in aitm.

### 6. Flexible layout

Move the AI sidebar and file tree to whichever side suits your screen setup.

## Download

- Get the latest from the [aitm product page](/aitm/)
- Platforms: macOS Apple Silicon, Windows x86_64, Windows ARM64
- Install steps, first-use, security model, FAQ — all on the product page

If you think AI should sit next to you in the terminal, not in another tab, give it a try.

For feedback or to chat, the contact link is on the [about page](/about/).
