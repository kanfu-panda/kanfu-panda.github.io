---
layout: default
permalink: /search/
title_key: search.heading
---
{%- assign lang = page.lang | default: site.active_lang | default: site.default_lang -%}
{%- assign t = site.data.i18n[lang] -%}

<div class="search-page">
    <h1>{{ t.search.heading }}</h1>

    <div class="search-container">
        <input type="text" id="search-input" placeholder="{{ t.search.placeholder }}">
        <div id="search-results"></div>
    </div>
</div>

<script>
// 当前页面语言（Jekyll 注入）
var PAGE_LANG = {{ lang | jsonify }};

// 直接用 fetch 拿 search.json，按语言过滤后渲染
(function() {
    var input = document.getElementById('search-input');
    var results = document.getElementById('search-results');
    var allPosts = [];
    var noResults = {{ t.search.no_results | jsonify }};

    fetch('/search.json')
        .then(function(r) { return r.json(); })
        .then(function(data) {
            allPosts = data.filter(function(p) { return p.lang === PAGE_LANG; });
        });

    function escapeHtml(str) {
        return String(str).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
    }

    function renderResults(query) {
        if (!query) { results.innerHTML = ''; return; }
        var q = query.toLowerCase();
        var matched = allPosts.filter(function(p) {
            return (p.title + ' ' + p.tags + ' ' + p.excerpt).toLowerCase().indexOf(q) !== -1;
        });
        if (matched.length === 0) {
            results.innerHTML = '<p class="no-results">' + escapeHtml(noResults) + '</p>';
            return;
        }
        results.innerHTML = matched.slice(0, 10).map(function(p) {
            return '<div class="search-result"><a href="' + escapeHtml(p.url) + '"><h3>' + escapeHtml(p.title) + '</h3></a><p class="post-date">' + escapeHtml(p.date) + '</p><p>' + escapeHtml(p.excerpt.substring(0, 120)) + '…</p></div>';
        }).join('');
    }

    input.addEventListener('input', function() { renderResults(this.value.trim()); });
})();
</script>

