---
layout: default
title: 首页
lang: zh
wide: true
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
                {% if post.image %}
                <a class="post-thumb" href="{{ post.url }}" tabindex="-1" aria-hidden="true"><img src="{{ post.image | relative_url }}" alt="" loading="lazy"></a>
                {% endif %}
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

    <div class="about-section">
        <h2>👨‍💻 关于我</h2>
        <p class="about-intro">我是功夫熊猫，一个写了很多年代码的开发者。最近主要在折腾 AI 编程：用 AI 写代码，给自己做顺手的工具（就是上面的 aitm 和 PDLC），再把做法和踩过的坑写成文章。</p>
        <div class="about-grid">
            <div class="about-card">
                <h3>✍️ 在写的专题</h3>
                <ul>
                    {%- for topic in site.data.topics %}
                    <li><a href="/zh/topics/#{{ topic.id }}">{{ topic.zh.title }}</a></li>
                    {%- endfor %}
                </ul>
                <p class="about-card-more"><a href="/zh/topics/">按专题从第一篇读起更顺 →</a></p>
            </div>
            <div class="about-card">
                <h3>🌱 最近在琢磨</h3>
                <ul>
                    <li>让 AI 的工具调用更可靠，从“看起来能用”到“真的好用”</li>
                    <li>AI 编程怎么更省 token、跑得更快、人也不那么累</li>
                    <li>Rust 异步生态和 Tauri 的内部机制</li>
                    <li>终端协议：ANSI、OSC、PTY</li>
                </ul>
            </div>
            <div class="about-card">
                <h3>💬 技术栈</h3>
                <ul>
                    <li><strong>语言</strong>：Python、TypeScript / JavaScript、Rust</li>
                    <li><strong>前端</strong>：React、Tailwind、xterm.js</li>
                    <li><strong>桌面</strong>：Tauri 2、PTY、IPC 设计</li>
                    <li><strong>AI</strong>：多家大模型 API、工具调用与 Agent 流程</li>
                </ul>
            </div>
            <div class="about-card">
                <h3>📮 在哪儿找到我</h3>
                <ul>
                    <li>长文首发在公众号「码上驰骋」，短视频在同名视频号</li>
                    <li>掘金、知乎同步中文版，dev.to 和 Zenn 有英文版、日文版</li>
                    <li>代码都在 <a href="https://github.com/kanfu-panda">GitHub</a></li>
                </ul>
                <p class="about-card-more"><a href="/zh/follow/">全部关注方式 →</a></p>
            </div>
        </div>
        <p class="about-outro">如果你也在做桌面 / 终端工具、AI 工程落地，或者 Rust + Tauri 项目，欢迎找我聊。 <a href="/zh/about/">更多关于我 →</a></p>
    </div>
</div>
