---
layout: post
title: "arcade：博客里挂了个浏览器街机模拟器"
date: 2026-05-16
lang: zh
categories: [blog]
tags: [arcade, 街机模拟器, EmulatorJS, WebAssembly]
excerpt: "博客 /arcade/ 下挂了一个浏览器街机模拟器。支持 MAME 和数十种主机，你拖入自己本地的游戏文件就能玩，全程在浏览器里完成，零上传。"
---

## 这是什么

博客新增了一个 [arcade 产品页](/arcade/)——一个跑在浏览器里的街机模拟器，
基于 EmulatorJS（WebAssembly 移植的 RetroArch）。

支持的系统包括：MAME 街机、NES / SNES、GB / GBC / GBA、N64、Sega Genesis、NDS、PCE 等几十种。

## 能做什么

- 拖入本地游戏文件 → 自动识别对应模拟器核心 → 开玩
- **存档跨会话**保留，下次打开继续玩
- **手柄即插即用**，F2 进入按键设置
- 全屏模式
- 街机 ZIP 可在 **MAME ↔ FBNeo** 两个核心间一键切换（应对不同 romset 兼容性）

## 怎么用

1. 打开 [arcade 启动页](/arcade/play/){:target="_blank" rel="noopener"}
2. 把你**本地的游戏文件**拖进页面（NES、SNES、GB、街机 ZIP 等）
3. 部分游戏（Neo-Geo 等）需要拖入对应 BIOS 文件，同入口
4. 点游戏卡片上的「开始游戏」

## 关于本地与隐私

你拖入的文件**全程保存在你浏览器自己的存储里**，不会上传到任何服务器。
这是浏览器 File API + IndexedDB 的标准行为，跟我无关——
GitHub Pages 也只能吐静态文件，根本接收不了上传。

## 注意

⚠️ 本工具仅供个人娱乐，合法用途。请使用您自己合法拥有的游戏文件。

## 试玩

[→ 启动 arcade](/arcade/play/){:target="_blank" rel="noopener"}

玩开心。
