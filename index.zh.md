---
layout: default
title: 首页
lang: zh
permalink: /
description: 一个热爱技术的开发者的个人博客 —— 记录写代码的心得、用过的工具、和我一直在折腾的项目。
---

<div class="hero-section">
    <div class="hero-content">
        <h1>👋 你好，我是不太会武功的功夫熊猫</h1>
        <p>一个热爱技术的开发者，专注于分享编程经验和学习心得</p>
        <div class="hero-links">
            <a href="/zh/about/" class="cta-button">了解更多 →</a>
            <a href="https://github.com/kanfu-panda" class="github-link">
                <i class="fab fa-github"></i> GitHub
            </a>
        </div>
    </div>
</div>

<div class="content-section">
    <div class="recent-posts">
        <h2>📝 最新文章</h2>
        <div class="post-grid">
            {% assign current_lang = page.lang | default: site.default_lang %}
            {% assign all_posts = site.posts_all | default: site.posts %}
            {% assign filtered_posts = all_posts | where_exp: "p", "p.lang == current_lang" %}
            {% for post in filtered_posts limit:6 %}
            <div class="post-card">
                <div class="post-content">
                    <h3><a href="{{ post.url }}">{{ post.title }}</a>{% if post.lang and post.lang != page.lang %}<span class="post-lang-badge">{{ post.lang | upcase }}</span>{% endif %}</h3>
                    <p class="post-excerpt">{{ post.excerpt | strip_html | truncate: 100 }}</p>
                    <div class="post-meta">
                        <span class="post-date">{{ post.date | date: "%Y-%m-%d" }}</span>
                        {% if post.tags %}
                        <span class="post-tags">
                            {% for tag in post.tags limit:2 %}
                            <a href="/zh/tags/#{{ tag | slugify }}" class="tag">{{ tag }}</a>
                            {% endfor %}
                        </span>
                        {% endif %}
                    </div>
                </div>
            </div>
            {% endfor %}
        </div>
    </div>

    <div class="about-section">
        <h2>👨‍💻 关于我</h2>
        <div class="about-grid">
            <div class="about-card">
                <h3>🔭 研究方向</h3>
                <p>Web 开发、AI 工程、云原生工具链。</p>
            </div>
            <div class="about-card">
                <h3>🌱 正在学习</h3>
                <p>Rust + Tauri 内部机制、终端协议、可靠的 AI 工具调用。</p>
            </div>
            <div class="about-card">
                <h3>👯 期待合作</h3>
                <p>开源项目、终端 / AI 工具、技术写作。</p>
            </div>
            <div class="about-card">
                <h3>💬 技术栈</h3>
                <p>Python、TypeScript / JavaScript、Rust、React、Tauri 2。</p>
            </div>
        </div>
    </div>

    <div class="featured-projects">
        <h2>🚀 项目</h2>
        <div class="about-grid">
            <div class="about-card">
                <h3><a href="/zh/aitm/">aitm</a></h3>
                <p>AI 原生桌面终端，支持 macOS 与 Windows —— 多 tab 终端、能读写文件的 AI 侧栏、内置浏览器。Tauri 2 + React 19 + Rust，Apache-2.0 开源。</p>
                <p style="margin-top: 0.5rem; font-size: 0.85em;">
                    <a href="/zh/aitm/">产品页</a> · <a href="https://github.com/kanfu-panda/aitm">GitHub</a> · <a href="https://github.com/kanfu-panda/aitm/releases/latest">最新版本 ↓</a>
                </p>
            </div>
            <div class="about-card">
                <h3><a href="/zh/pdlc/">PDLC</a></h3>
                <p>Claude Code 插件 —— 38 个标准化开发生命周期阶段，全部以斜杠命令暴露。硬契约、状态机、测试先行。</p>
                <p style="margin-top: 0.5rem; font-size: 0.85em;">
                    <a href="/zh/pdlc/">产品页</a> · <a href="https://github.com/kanfu-panda/pdlc-skills">GitHub</a>
                </p>
            </div>
        </div>
        <p style="margin-top: 1rem;"><a href="/zh/projects/">全部项目 →</a></p>
    </div>
</div>
