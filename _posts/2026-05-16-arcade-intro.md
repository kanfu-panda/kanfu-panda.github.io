---
layout: post
title: "arcade: a browser-based arcade emulator on this blog"
date: 2026-05-16
lang: en
categories: [blog]
tags: [arcade, emulator, EmulatorJS, WebAssembly]
excerpt: "There's a browser-based arcade emulator at /arcade/. Supports MAME and dozens of consoles. Drag in your own local game files and play — everything runs inside the browser, nothing uploaded."
---

## What it is

The blog now has an [arcade product page](/arcade/) — a browser-based arcade emulator,
powered by EmulatorJS (a WebAssembly port of RetroArch).

Supported systems include MAME arcade, NES / SNES, GB / GBC / GBA, N64, Sega Genesis, NDS, PCE, and dozens more.

## What it can do

- Drag in a local game file → auto-detect the right emulator core → play
- **Save states persist** across sessions, pick up where you left off
- **Gamepad plug & play**, F2 to remap controls
- Fullscreen
- For arcade ZIPs you can **toggle between MAME ↔ FBNeo** with one click (for romset compatibility)

## How to use

1. Open the [arcade launcher](/arcade/play/){:target="_blank" rel="noopener"}
2. Drag your **local game files** onto the page (NES, SNES, GB, arcade ZIPs, etc.)
3. Some games (Neo-Geo, etc.) need their BIOS dragged in too — same entry point
4. Click "Start" on the game card

## On local & privacy

Files you drag in stay **in your own browser's storage** the whole time, never uploaded to any server.
That's just how the browser's File API + IndexedDB work — nothing to do with me.
GitHub Pages can only serve static files anyway; it can't receive uploads.

## Note

⚠️ For personal entertainment, lawful use only. Please only use game files you legally own.

## Try it

[→ launch arcade](/arcade/play/){:target="_blank" rel="noopener"}

Have fun.
