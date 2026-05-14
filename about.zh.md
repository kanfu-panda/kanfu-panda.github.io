---
layout: default
title: 关于我
permalink: /about/
lang: zh
---

# 关于我

## 你好

我是不太会武功的**功夫熊猫** —— 一个长期写代码、偶尔琢磨工具的开发者。

写程序对我来说既是工作也是兴趣。喜欢把"差不多能用"做成"用起来挺顺"，所以这几年常常一边写应用，一边顺手做小工具。

这个博客是我整理技术心得、记录学习历程、分享踩坑经验的地方。

## 现在在做的事

### 🪟 [aitm](/aitm/) — 让 AI 进入终端

一个把 AI 能力做进 macOS 终端的桌面应用。多 tab 终端 + AI 侧栏 + AI 工具调用闭环：AI 可以读文件、查命令历史、按需执行命令，所有高危动作都要用户点头确认。

技术栈：Tauri 2 + Rust + React 19 + TypeScript。完整介绍在 [aitm 产品页](/aitm/)。

### 📝 这个博客

基于 Jekyll 的纯静态站点，托管在 GitHub Pages。仓库 [在 GitHub 公开](https://github.com/kanfu-panda/kanfu-panda.github.io)，从主题、CI、安全策略到内容都可以参考。

## 技术栈

- **主力语言**：Python、TypeScript / JavaScript、Rust
- **前端**：React、Tailwind、xterm.js 这类生态
- **桌面 / 系统层**：Tauri 2、PTY 与终端协议、IPC 设计
- **AI 工程**：与多家 LLM API 打交道、工具调用 / Agent 流程
- **基础设施**：Git、Docker、GitHub Actions、Jekyll、静态站点工程化

日常工具：VS Code 主力、偶尔 IntelliJ；命令行用 zsh；终端 —— 当然是 aitm（边吃自己的狗粮边迭代）。

## 最近在琢磨

- 让 AI 工具调用更可靠：从"看起来能用"到"真的好用"
- Rust 异步生态、Tauri 内部机制
- 终端协议家族（ANSI / OSC / PTY）
- 怎么把内容工作流和发布流程做得舒服一些

## 这个博客你能看到什么

- **技术探索**：编程语言、框架、工具的学习笔记
- **解决方案**：问题排查思路、最佳实践、踩坑实录
- **项目复盘**：从想法到上线的真实过程
- **偶尔随笔**：不限技术

更新频率不一定，但争取写的每一篇都对读者有点用。

## 兴趣

代码之外：
- 阅读（技术 & 非技术都有）
- 折腾终端、命令行、工具链
- 关注与偶尔参与开源协作

## 一起聊聊

如果你也在做以下方向之一，欢迎找我交流：

- 桌面 / 终端工具开发
- AI 工程落地，特别是怎么把"看起来很 AI"做成"真的好用"
- Rust + Tauri 项目
- 静态站点 / 个人内容平台折腾

## 联系方式

- GitHub: [kanfu-panda](https://github.com/kanfu-panda)
- 邮箱：<a id="contact-link" href="#" rel="nofollow">联系我</a>

<script>
// 邮箱通过 JS 在客户端拼装，避免在 HTML 源码中以连续字符串出现，降低被自动爬取的概率
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
