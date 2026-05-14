---
layout: default
permalink: /search/
title_key: search.heading
---
{%- assign lang = page.lang | default: site.active_lang | default: site.default_lang -%}
{%- assign t = site.data.i18n[lang] -%}
{%- comment -%} search.json 是跨语言聚合（不参与本地化路径），3 套 search 页都指向同一份 {%- endcomment -%}
{%- assign search_json_path = '/search.json' -%}

<div class="search-page">
    <h1>{{ t.search.heading }}</h1>

    <div class="search-container">
        <input type="text" id="search-input" placeholder="{{ t.search.placeholder }}">
        <div id="search-results"></div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/simple-jekyll-search@1.10.0/dest/simple-jekyll-search.min.js"
        integrity="sha384-UN+lyciv8Ta643YxZ9sY2tdTSmk3KE61Qq84ZIXG9NRTbD9+NFXy38m9h6Exxx3n"
        crossorigin="anonymous"></script>
<script>
SimpleJekyllSearch({
    searchInput: document.getElementById('search-input'),
    resultsContainer: document.getElementById('search-results'),
    json: '{{ search_json_path }}',
    searchResultTemplate: '<div class="search-result"><a href="{url}"><h3>{title}</h3></a><p>{date}</p><p>{excerpt}</p></div>',
    noResultsText: '{{ t.search.no_results }}',
    limit: 10,
    fuzzy: false
});
</script>
