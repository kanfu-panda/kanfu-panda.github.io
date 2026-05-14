---
layout: default
title: Home
lang: en
permalink: /
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
            {% assign all_posts = site.posts_all | default: site.posts %}
            {% for post in all_posts limit:6 %}
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
