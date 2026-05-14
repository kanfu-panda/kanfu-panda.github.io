---
layout: default
title: ホーム
lang: ja
permalink: /
---

<div class="hero-section">
    <div class="hero-content">
        <h1>👋 こんにちは、カンフーは使えないカンフー・パンダです。</h1>
        <p>テクノロジー好きの開発者です。プログラミング、ツール、そしてその過程で出会う面白い話題について書いています。</p>
        <div class="hero-links">
            <a href="/ja/about/" class="cta-button">もっと知る →</a>
            <a href="https://github.com/kanfu-panda" class="github-link">
                <i class="fab fa-github"></i> GitHub
            </a>
        </div>
    </div>
</div>

<div class="content-section">
    <div class="recent-posts">
        <h2>📝 最新の記事</h2>
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
                            <a href="/ja/tags/#{{ tag | slugify }}" class="tag">{{ tag }}</a>
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
        <h2>👨‍💻 自己紹介</h2>
        <div class="about-grid">
            <div class="about-card">
                <h3>🔭 興味分野</h3>
                <p>Web 開発、AI エンジニアリング、クラウドネイティブツール。</p>
            </div>
            <div class="about-card">
                <h3>🌱 学習中</h3>
                <p>Rust と Tauri の内部、ターミナルプロトコル、信頼性の高い AI ツール呼び出し。</p>
            </div>
            <div class="about-card">
                <h3>👯 一緒にやりたいこと</h3>
                <p>オープンソースプロジェクト、ターミナル / AI ツール、技術文書執筆。</p>
            </div>
            <div class="about-card">
                <h3>💬 技術スタック</h3>
                <p>Python、TypeScript / JavaScript、Rust、React、Tauri 2。</p>
            </div>
        </div>
    </div>
</div>
