---
layout: default
title: 博客
lang: zh
permalink: /blog/
description: 关于编程、AI 工具、开源项目的文章记录。
---

<div class="content-section">
    <h1>博客</h1>

    <div class="post-list">
        {% assign current_lang = page.lang | default: site.default_lang %}
        {% assign all_posts = site.posts_all | default: site.posts %}
        {% assign filtered_posts = all_posts | where_exp: "p", "p.lang == current_lang" %}
        {% if filtered_posts.size == 0 %}
            {% assign filtered_posts = all_posts | where_exp: "p", "p.lang == nil or p.lang == 'zh'" %}
        {% endif %}
        {% for post in filtered_posts %}
        <div class="post-card">
            <div class="post-content">
                <h3><a href="{{ post.url }}">{{ post.title }}</a></h3>
                {% if post.excerpt %}
                <p class="post-excerpt">{{ post.excerpt | strip_html | truncate: 160 }}</p>
                {% endif %}
                <div class="post-meta">
                    <span class="post-date">{{ post.date | date: "%Y-%m-%d" }}</span>
                    {% if post.tags %}
                    <span class="post-tags">
                        {% for tag in post.tags limit:3 %}
                        <a href="/zh/tags/#{{ tag | slugify }}" class="post-tag">{{ tag }}</a>
                        {% endfor %}
                    </span>
                    {% endif %}
                </div>
            </div>
        </div>
        {% endfor %}
    </div>
</div>
