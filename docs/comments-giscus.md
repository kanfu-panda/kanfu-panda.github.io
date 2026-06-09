# 评论系统：Giscus 接入与启用

博客评论基于 [Giscus](https://giscus.app)——把 GitHub Discussions 当评论后端。
代码已接好（`_layouts/post.html` 渲染评论框、`_layouts/default.html` 做主题/CSP、
`_config.yml` 存配置）。**只差 4 个公开标识符**，按下面三步填进 `_config.yml` 即可启用。

> 为什么不用 Gitalk：Gitalk 需要 OAuth App 的 `clientSecret`，会被写进客户端 JS / 仓库，
> 违反"秘钥不进仓库"原则。Giscus 的 `repo_id` / `category_id` 是**公开标识符不是密钥**，可安全入仓。

## 启用步骤（一次性，约 5 分钟）

### 1. 仓库开启 Discussions
`github.com/kanfu-panda/kanfu-panda.github.io` → **Settings** → **General** →
往下找 **Features** → 勾选 **Discussions**。

进入新出现的 **Discussions** 标签 → 建一个分类（Category）专门放评论，
建议名为 `Announcements`、类型选 **Announcement**（只有维护者能开新串，访客只能在已有串里回复——
适合"一篇文章一条串"的评论场景）。

### 2. 安装 giscus App
打开 <https://github.com/apps/giscus> → **Install** → 选择本仓库授权。

### 3. 生成 4 个值
打开 <https://giscus.app>，在页面表单里：
- **Repository** 填 `kanfu-panda/kanfu-panda.github.io`（绿勾表示三项前提都满足）
- **Mapping** 选 `pathname`（默认；含义见下方"三语评论"）
- **Discussion Category** 选第 1 步建的 `Announcements`

往下滚动到 **Enable giscus** 区域，生成的 `<script>` 里有 4 个值，复制到 `_config.yml`：

```yaml
giscus:
  enable: true
  repo: "kanfu-panda/kanfu-panda.github.io"
  repo_id: "R_xxxxxxxx"            # ← data-repo-id
  category: "Announcements"
  category_id: "DIC_xxxxxxxx"      # ← data-category-id
  mapping: "pathname"
  reactions_enabled: "1"
  input_position: "bottom"
```

填好提交即生效（`repo_id` 为空时评论框不渲染，所以配好前不会报错或露半成品）。

## 三语评论：独立还是共享

`mapping: "pathname"`（当前默认）→ 按 URL 建讨论串。同一篇文章的中/英/日 URL 不同，
所以**三语评论各自独立**（日文读者在日文串里聊）。多数三语博客这样最自然。

若想**三语共享一条评论串**：把 `mapping` 改成 `"og:title"` 或 `"specific"`，
但需保证三语版本有相同的映射键，较麻烦，一般不必。

## 维护说明

- 删评论 / 封人：去仓库 Discussions 对应讨论串操作（你是 admin）。
- 主题联动：访客切换博客明暗主题时，评论框通过 `postMessage` 同步明暗
  （逻辑在 `default.html` 的 `syncGiscusTheme`）。
- 语言：评论框 UI 语言跟随文章语言（`post.html` 里按 `ui_lang` 映射 en/zh-CN/ja）。
- CSP：`default.html` 的 CSP 已放行 `https://giscus.app`（`script-src` + `frame-src`）。
  升级 giscus 或换域名时记得同步改。
