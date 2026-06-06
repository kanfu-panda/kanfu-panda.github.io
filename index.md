---
layout: default
title: Home
lang: en
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

    <div class="about-section">
        <h2>👨‍💻 About me</h2>
        <div class="about-grid">
            <div class="about-card">
                <h3>🔭 Focus</h3>
                <p>Web development, AI engineering, cloud-native tooling.</p>
            </div>
            <div class="about-card">
                <h3>🌱 Currently learning</h3>
                <p>Rust + Tauri internals, terminal protocols, reliable AI tool-calling.</p>
            </div>
            <div class="about-card">
                <h3>👯 Open to collaborate on</h3>
                <p>Open-source projects, terminal/AI tooling, technical writing.</p>
            </div>
            <div class="about-card">
                <h3>💬 Tech stack</h3>
                <p>Python, TypeScript / JavaScript, Rust, React, Tauri 2.</p>
            </div>
        </div>
    </div>
</div>

<div class="content-section">
    <div class="featured-projects">
        <h2>🚀 Projects</h2>
        <div class="about-grid">
            <div class="about-card">
                <h3><a href="/aitm/">aitm</a></h3>
                <p>AI-native desktop terminal — multi-tab PTY + AI sidebar + tool-calling. Tauri 2 + React 19 + Rust. 5.3 MB, 3-5ms cold start.</p>
                <p style="margin-top: 0.5rem; font-size: 0.85em;">
                    <a href="/aitm/">Product page</a> · <a href="https://github.com/kanfu-panda/aitm">GitHub</a> · <a href="https://github.com/kanfu-panda/aitm/releases/tag/v1.0.0">v1.0.0 ↓</a>
                </p>
            </div>
            <div class="about-card">
                <h3><a href="/pdlc/">PDLC</a></h3>
                <p>Claude Code plugin — 33 standardized dev lifecycle stages as slash commands. Hard contracts, state machine, TDD-first.</p>
                <p style="margin-top: 0.5rem; font-size: 0.85em;">
                    <a href="/pdlc/">Product page</a> · <a href="https://github.com/kanfu-panda/pdlc-skills">GitHub</a>
                </p>
            </div>
        </div>
        <p style="margin-top: 1rem;"><a href="/projects/">All projects →</a></p>
    </div>
</div>
