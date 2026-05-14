---
layout: default
permalink: /tags/
---
{%- assign lang = page.lang | default: site.active_lang | default: site.default_lang -%}
{%- assign t = site.data.i18n[lang] -%}

<div class="tags-page">
    <h1>{{ t.tags.heading }}</h1>

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
                    {% if post.lang %}<span class="post-lang-badge">{{ post.lang | upcase }}</span>{% endif %}
                </li>
                {% endfor %}
            </ul>
        </div>
        {% endfor %}
    </div>
</div>
