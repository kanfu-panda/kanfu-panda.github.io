source "https://rubygems.org"

gem "jekyll"
gem "minima"
gem "webrick"

# 多语言（中 / 英 / 日）
gem "jekyll-polyglot"

# 注意：本站**刻意不用** jekyll-sitemap / jekyll-seo-tag / jekyll-feed。
# 三者都不认识 polyglot 的多语言 URL——分别会产出只含默认语言的 sitemap、
# 指向默认语言的 canonical、以及混语言的 feed。对应功能已手写：
# SEO 头在 _layouts/default.html，sitemap.xml / feed.xml / search.json 在仓库根。
# 装回来会静默覆盖手写版本，导致 2/3 内容再次对搜索引擎消失。
