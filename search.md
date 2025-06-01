---
layout: default
title: 搜索
permalink: /search/
---

<div class="search-page">
    <h1>搜索文章</h1>
    
    <div class="search-container">
        <input type="text" id="search-input" placeholder="输入关键词搜索...">
        <div id="search-results"></div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/simple-jekyll-search@latest/dest/simple-jekyll-search.min.js"></script>
<script>
SimpleJekyllSearch({
    searchInput: document.getElementById('search-input'),
    resultsContainer: document.getElementById('search-results'),
    json: '/search.json',
    searchResultTemplate: '<div class="search-result"><a href="{url}"><h3>{title}</h3></a><p>{date}</p><p>{excerpt}</p></div>',
    noResultsText: '没有找到相关文章',
    limit: 10,
    fuzzy: false
});
</script>
