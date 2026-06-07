---
layout: default
title: Blog
lang: en
permalink: /blog/
description: Articles on programming, AI tooling, open-source projects, and the occasional rabbit hole.
---

<div class="content-section">
    <h1>Blog</h1>

    <div class="post-list">
        {% assign current_lang = page.lang | default: site.default_lang %}
        {% assign all_posts = site.posts_all | default: site.posts %}
        {% assign filtered_posts = all_posts | where_exp: "p", "p.lang == current_lang" %}
        {% if filtered_posts.size == 0 %}
            {% assign filtered_posts = all_posts | where_exp: "p", "p.lang == nil or p.lang == 'en'" %}
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
                        <a href="/tags/#{{ tag | slugify }}" class="post-tag">{{ tag }}</a>
                        {% endfor %}
                    </span>
                    {% endif %}
                </div>
            </div>
        </div>
        {% endfor %}
    </div>
</div>
