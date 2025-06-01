---
layout: default
title: 标签
permalink: /tags/
---

<div class="tags-page">
    <h1>标签云</h1>
    
    <div class="tag-cloud">
        {% assign tags = site.tags | sort %}
        {% for tag in tags %}
            <a href="#{{ tag[0] | slugify }}" class="tag-link" style="font-size: {{ tag[1].size | times: 4 | plus: 80 }}%">
                {{ tag[0] }} <span>({{ tag[1].size }})</span>
            </a>
        {% endfor %}
    </div>

    <div class="tag-list">
        {% for tag in tags %}
        <div class="tag-section" id="{{ tag[0] | slugify }}">
            <h2>{{ tag[0] }}</h2>
            <ul>
                {% for post in tag[1] %}
                <li>
                    <span class="post-date">{{ post.date | date: "%Y-%m-%d" }}</span>
                    <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
                </li>
                {% endfor %}
            </ul>
        </div>
        {% endfor %}
    </div>
</div>
