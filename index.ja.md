---
layout: default
title: ホーム
lang: ja
permalink: /
description: テクノロジー好き開発者の個人ブログ —— コーディングのメモ、使ったツール、いじり続けているプロジェクトを記録しています。
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

    <div class="featured-projects">
        <h2>🚀 プロジェクト</h2>
        <div class="about-grid">
            <div class="about-card">
                <h3><a href="/ja/aitm/">aitm</a></h3>
                <p>macOS と Windows に対応した AI ネイティブなデスクトップターミナル —— 複数 tab の PTY、ファイルの読み書きができる AI サイドバー、内蔵ブラウザ。Tauri 2 + React 19 + Rust、Apache-2.0。</p>
                <p style="margin-top: 0.5rem; font-size: 0.85em;">
                    <a href="/ja/aitm/">製品ページ</a> · <a href="https://github.com/kanfu-panda/aitm">GitHub</a> · <a href="https://github.com/kanfu-panda/aitm/releases/latest">最新リリース ↓</a>
                </p>
            </div>
            <div class="about-card">
                <h3><a href="/ja/pdlc/">PDLC</a></h3>
                <p>Claude Code プラグイン —— 38 個の標準化された開発ライフサイクルのステージをスラッシュコマンドとして公開。ハードな契約、状態マシン、テストファースト。</p>
                <p style="margin-top: 0.5rem; font-size: 0.85em;">
                    <a href="/ja/pdlc/">製品ページ</a> · <a href="https://github.com/kanfu-panda/pdlc-skills">GitHub</a>
                </p>
            </div>
        </div>
        <p style="margin-top: 1rem;"><a href="/ja/projects/">すべてのプロジェクト →</a></p>
    </div>
</div>
