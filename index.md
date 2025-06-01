---
layout: default
title: 首页
---

<div class="hero-section">
    <div class="hero-content">
        <h1>👋 你好，我是看见眨眼的熊猫</h1>
        <p>一个热爱技术的开发者，专注于分享编程经验和学习心得</p>
        <div class="hero-links">
            <a href="/about" class="cta-button">了解更多 →</a>
            <a href="https://github.com/kanfu-panda" class="github-link">
                <i class="fab fa-github"></i> GitHub
            </a>
        </div>
    </div>
</div>

<div class="content-section">
    <div class="recent-posts">
        <h2>📝 最新文章</h2>
        <div class="post-grid">
            {% for post in site.posts limit:6 %}
            <div class="post-card">
                <div class="post-content">
                    <h3><a href="{{ post.url }}">{{ post.title }}</a></h3>
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

    <div class="categories-section">
        <h2>🏷️ 文章分类</h2>
        <div class="categories-grid">
            {% assign categories = site.categories | sort %}
            {% for category in categories %}
            <div class="category-card">
                <h3>{{ category[0] }}</h3>
                <p>{{ category[1].size }} 篇文章</p>
                <a href="/tags/#{{ category[0] | slugify }}" class="category-link">浏览全部 →</a>
            </div>
            {% endfor %}
        </div>
    </div>

    <div class="about-section">
        <h2>👨‍💻 关于我</h2>
        <div class="about-grid">
            <div class="about-card">
                <h3>🔭 研究方向</h3>
                <p>Web开发、人工智能、云原生技术</p>
            </div>
            <div class="about-card">
                <h3>🌱 正在学习</h3>
                <p>TypeScript、React、DevOps</p>
            </div>
            <div class="about-card">
                <h3>👯 期待合作</h3>
                <p>开源项目、技术交流、知识分享</p>
            </div>
            <div class="about-card">
                <h3>💬 专业领域</h3>
                <p>Python、JavaScript、微服务架构</p>
            </div>
        </div>
    </div>
</div>
