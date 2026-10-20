---
layout: default
title: Home
lang: en
wide: true
permalink: /
description: A developer who loves technology — notes on coding, tools, and the projects I keep tinkering on.
---

<div class="hero-section">
    <div class="hero-content">
        <h1>👋 Hi, I'm Kungfu Panda — only without the kungfu.</h1>
        <p>A developer who loves technology. I write about programming, tools, and the rabbit holes in between.</p>
        <div class="hero-links">
            <a href="/about/" class="cta-button">Learn more →</a>
            <a href="https://github.com/kanfu-panda" class="github-link">
                <i class="fab fa-github"></i> GitHub
            </a>
        </div>
    </div>
</div>

<div class="content-section">
    <div class="recent-posts">
        <h2>📝 Recent Posts</h2>
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
                            <a href="/tags/#{{ tag | slugify }}" class="tag">{{ tag }}</a>
                            {% endfor %}
                        </span>
                        {% endif %}
                    </div>
                </div>
            </div>
            {% endfor %}
        </div>
    </div>

</div>

<div class="content-section">
    <div class="featured-projects">
        <h2>🚀 Projects</h2>
        <div class="about-grid">
            <div class="about-card">
                <h3><a href="/aitm/">aitm</a></h3>
                <p>AI-native desktop terminal for macOS and Windows — multi-tab PTY, an AI sidebar that reads and edits files, and a built-in browser. Tauri 2 + React 19 + Rust, Apache-2.0.</p>
                <p style="margin-top: 0.5rem; font-size: 0.85em;">
                    <a href="/aitm/">Product page</a> · <a href="https://github.com/kanfu-panda/aitm">GitHub</a> · <a href="https://github.com/kanfu-panda/aitm/releases/latest">Latest release ↓</a>
                </p>
            </div>
            <div class="about-card">
                <h3><a href="/pdlc/">PDLC</a></h3>
                <p>Claude Code plugin — 38 standardized dev lifecycle stages as slash commands. Hard contracts, state machine, TDD-first.</p>
                <p style="margin-top: 0.5rem; font-size: 0.85em;">
                    <a href="/pdlc/">Product page</a> · <a href="https://github.com/kanfu-panda/pdlc-skills">GitHub</a>
                </p>
            </div>
        </div>
        <p style="margin-top: 1rem;"><a href="/projects/">All projects →</a></p>
    </div>

    <div class="about-section">
        <h2>👨‍💻 About me</h2>
        <p class="about-intro">I'm Kungfu Panda, a developer who has been writing code for a long time. These days most of my tinkering is around AI-assisted coding: using AI to write code, building the tools I wish I had (aitm and PDLC above), and writing up what worked and what bit me.</p>
        <div class="about-grid">
            <div class="about-card">
                <h3>✍️ Series I'm writing</h3>
                <ul>
                    {%- for topic in site.data.topics %}
                    <li><a href="/topics/#{{ topic.id }}">{{ topic.en.title }}</a></li>
                    {%- endfor %}
                </ul>
                <p class="about-card-more"><a href="/topics/">Each series reads best from part one →</a></p>
            </div>
            <div class="about-card">
                <h3>🌱 On my mind lately</h3>
                <ul>
                    <li>Making AI tool calls reliable — from "looks like it works" to "actually works"</li>
                    <li>Making AI coding cheaper, faster and less draining</li>
                    <li>Rust's async ecosystem and Tauri internals</li>
                    <li>Terminal protocols: ANSI, OSC, PTY</li>
                </ul>
            </div>
            <div class="about-card">
                <h3>💬 Tech stack</h3>
                <ul>
                    <li><strong>Languages</strong>: Python, TypeScript / JavaScript, Rust</li>
                    <li><strong>Frontend</strong>: React, Tailwind, xterm.js</li>
                    <li><strong>Desktop</strong>: Tauri 2, PTY, IPC design</li>
                    <li><strong>AI</strong>: LLM APIs from several vendors, tool calling and agent flows</li>
                </ul>
            </div>
            <div class="about-card">
                <h3>📮 Where to find me</h3>
                <ul>
                    <li>English write-ups on <a href="https://dev.to/kanfu-panda">dev.to</a>, Japanese on <a href="https://zenn.dev/kanfupanda">Zenn</a></li>
                    <li>The Chinese originals go out first on WeChat (码上驰骋)</li>
                    <li>Code lives on <a href="https://github.com/kanfu-panda">GitHub</a></li>
                </ul>
                <p class="about-card-more"><a href="/follow/">All the places to follow →</a></p>
            </div>
        </div>
        <p class="about-outro">If you're working on desktop or terminal tools, shipping AI in real products, or building with Rust + Tauri, I'd love to compare notes. <a href="/about/">More about me →</a></p>
    </div>
</div>
