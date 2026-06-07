---
layout: default
permalink: /tags/
---
{%- assign lang = page.lang | default: site.active_lang | default: site.default_lang -%}
{%- assign t = site.data.i18n[lang] -%}

<div class="tags-page">
    <h1>{{ t.tags.heading }}</h1>

    <div class="tag-cloud">
        {% assign all_posts = site.posts_all | default: site.posts %}
        {% assign lang_posts = all_posts | where_exp: "p", "p.lang == lang" %}
        {% assign tags_used = "" | split: "" %}
        {% for post in lang_posts %}
            {% for tag in post.tags %}
                {% unless tags_used contains tag %}
                    {% assign tags_used = tags_used | push: tag %}
                {% endunless %}
            {% endfor %}
        {% endfor %}
        {% assign tags_sorted = tags_used | sort %}
        {% for tag in tags_sorted %}
            {% assign tag_posts = lang_posts | where_exp: "p", "p.tags contains tag" %}
            <a href="#{{ tag | slugify }}" class="tag-link" style="font-size: {{ tag_posts.size | times: 4 | plus: 80 }}%">
                {{ tag }} <span>({{ tag_posts.size }})</span>
            </a>
        {% endfor %}
    </div>

    <div class="tag-list">
        {% for tag in tags_sorted %}
        {% assign tag_posts = lang_posts | where_exp: "p", "p.tags contains tag" %}
        {% if tag_posts.size > 0 %}
        <div class="tag-section" id="{{ tag | slugify }}">
            <h2>{{ tag }}</h2>
            <ul>
                {% for post in tag_posts %}
                <li>
                    <span class="post-date">{{ post.date | date: "%Y-%m-%d" }}</span>
                    <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
                </li>
                {% endfor %}
            </ul>
        </div>
        {% endif %}
        {% endfor %}
    </div>
</div>
