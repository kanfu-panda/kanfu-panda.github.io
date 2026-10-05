// 产品页版本自动同步（只在 front matter 带 `release:` 的页面加载）
//
// 页面 HTML 里写死的是构建时的版本（front matter `release.version`），作为兜底：
// 搜索引擎、禁用 JS、GitHub API 不可用时都显示它。页面打开后，这里向 GitHub 查最新 release，
// 若比兜底版本新，就把正文里的版本号、下载链接、安装包大小换成最新的。
// 只升不降：API 返回的版本不比兜底新时什么都不做。
(function () {
    'use strict';

    var script = document.currentScript;
    if (!script || !window.fetch) return;
    var repo = script.getAttribute('data-repo');
    var current = script.getAttribute('data-version');
    if (!repo || !current) return;

    var CACHE_KEY = 'release-sync:' + repo;
    var CACHE_MS = 60 * 60 * 1000; // 1 小时：未登录的 GitHub API 每个 IP 每小时只有 60 次额度

    function readCache() {
        try {
            var raw = sessionStorage.getItem(CACHE_KEY);
            if (!raw) return null;
            var cached = JSON.parse(raw);
            return Date.now() - cached.at < CACHE_MS ? cached.release : null;
        } catch (e) {
            return null;
        }
    }

    function writeCache(release) {
        try {
            sessionStorage.setItem(CACHE_KEY, JSON.stringify({ at: Date.now(), release: release }));
        } catch (e) { /* 隐私模式等场景写不进去，不影响功能 */ }
    }

    // 只保留用得到的字段，缓存体积小
    function fetchLatest() {
        return fetch('https://api.github.com/repos/' + repo + '/releases/latest', {
            headers: { Accept: 'application/vnd.github+json' }
        }).then(function (res) {
            if (!res.ok) throw new Error('GitHub API ' + res.status);
            return res.json();
        }).then(function (data) {
            return {
                tag: data.tag_name,
                url: data.html_url,
                assets: (data.assets || []).map(function (a) {
                    return { name: a.name, url: a.browser_download_url, size: a.size };
                })
            };
        });
    }

    // 语义化版本比较：a 比 b 新返回 true
    function isNewer(a, b) {
        var pa = a.split('.').map(Number), pb = b.split('.').map(Number);
        for (var i = 0; i < Math.max(pa.length, pb.length); i++) {
            var x = pa[i] || 0, y = pb[i] || 0;
            if (x !== y) return x > y;
        }
        return false;
    }

    function apply(release) {
        var latest = String(release.tag || '').replace(/^v/, '');
        if (!/^\d+(\.\d+)*$/.test(latest) || !isNewer(latest, current)) return;

        var main = document.querySelector('main');
        if (!main) return;
        // 版本号前后不能紧挨数字或点，避免把 1.6.10 里的 1.6.1 也换掉
        var pattern = new RegExp('(^|[^\\d.])' + current.replace(/\./g, '\\.') + '(?![\\d])', 'g');
        var replaceVersion = function (s) { return s.replace(pattern, '$1' + latest); };

        // 1. 正文文字（含代码块里的命令）
        var walker = document.createTreeWalker(main, NodeFilter.SHOW_TEXT);
        var node;
        while ((node = walker.nextNode())) {
            if (node.nodeValue.indexOf(current) !== -1) node.nodeValue = replaceVersion(node.nodeValue);
        }

        // 2. 链接：下载链接必须真的存在于最新 release 的文件列表里，否则退回 release 页面，绝不给出 404 链接
        var assetUrls = {};
        release.assets.forEach(function (a) { assetUrls[a.url] = true; });
        Array.prototype.forEach.call(main.querySelectorAll('a[href]'), function (a) {
            var href = a.getAttribute('href');
            if (href.indexOf(current) === -1) return;
            var next = replaceVersion(href);
            if (next.indexOf('/releases/download/') !== -1 && !assetUrls[next]) next = release.url;
            a.setAttribute('href', next);
        });

        // 3. 安装包大小
        Array.prototype.forEach.call(main.querySelectorAll('[data-release-size]'), function (el) {
            var suffix = el.getAttribute('data-release-size');
            var asset = release.assets.filter(function (a) { return a.name.slice(-suffix.length) === suffix; })[0];
            if (asset && asset.size) el.textContent = (asset.size / 1024 / 1024).toFixed(1) + ' MB';
        });

        document.documentElement.setAttribute('data-release-synced', latest);
    }

    var cached = readCache();
    if (cached) {
        apply(cached);
        return;
    }
    fetchLatest().then(function (release) {
        writeCache(release);
        apply(release);
    }).catch(function () { /* API 不可用：保持页面上的兜底版本 */ });
})();
