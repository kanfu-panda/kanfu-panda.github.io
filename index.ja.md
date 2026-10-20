---
layout: default
title: ホーム
lang: ja
wide: true
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

    <div class="about-section">
        <h2>👨‍💻 自己紹介</h2>
        <p class="about-intro">カンフー・パンダです。長年コードを書いてきた開発者で、最近はもっぱら AI コーディングに取り組んでいます。AI にコードを書かせ、自分が使いやすいツールを作り（上の aitm と PDLC）、そのやり方やつまずいた点を記事にしています。</p>
        <div class="about-grid">
            <div class="about-card">
                <h3>✍️ 連載中の特集</h3>
                <ul>
                    {%- for topic in site.data.topics %}
                    <li><a href="/ja/topics/#{{ topic.id }}">{{ topic.ja.title }}</a></li>
                    {%- endfor %}
                </ul>
                <p class="about-card-more"><a href="/ja/topics/">特集は第 1 回から読むのがおすすめです →</a></p>
            </div>
            <div class="about-card">
                <h3>🌱 最近考えていること</h3>
                <ul>
                    <li>AI のツール呼び出しを、「動いているように見える」から「本当に使える」へ</li>
                    <li>AI コーディングをより安く、より速く、人が疲れないように</li>
                    <li>Rust の非同期エコシステムと Tauri の内部</li>
                    <li>ターミナルプロトコル：ANSI、OSC、PTY</li>
                </ul>
            </div>
            <div class="about-card">
                <h3>💬 技術スタック</h3>
                <ul>
                    <li><strong>言語</strong>：Python、TypeScript / JavaScript、Rust</li>
                    <li><strong>フロントエンド</strong>：React、Tailwind、xterm.js</li>
                    <li><strong>デスクトップ</strong>：Tauri 2、PTY、IPC 設計</li>
                    <li><strong>AI</strong>：各社の LLM API、ツール呼び出しとエージェントの設計</li>
                </ul>
            </div>
            <div class="about-card">
                <h3>📮 どこで読めるか</h3>
                <ul>
                    <li>日本語の記事は <a href="https://zenn.dev/kanfupanda">Zenn</a>、英語は <a href="https://dev.to/kanfu-panda">dev.to</a></li>
                    <li>中国語の原文は WeChat 公式アカウント「码上驰骋」で先に公開</li>
                    <li>コードは <a href="https://github.com/kanfu-panda">GitHub</a> に</li>
                </ul>
                <p class="about-card-more"><a href="/ja/follow/">フォローできる場所の一覧 →</a></p>
            </div>
        </div>
        <p class="about-outro">デスクトップやターミナルのツール、AI の実務への組み込み、Rust + Tauri のプロジェクトに取り組んでいる方、ぜひ気軽に声をかけてください。 <a href="/ja/about/">もっと詳しく →</a></p>
    </div>
</div>
