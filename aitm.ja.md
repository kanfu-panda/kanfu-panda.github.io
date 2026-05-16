---
layout: default
title: aitm
permalink: /aitm/
lang: ja
description: aitm — AI を組み込んだ macOS デスクトップ向けターミナルアプリ。AI がファイル読み込み、コマンド履歴検索、コマンド実行を行えます。すべての高リスク操作には明示的な確認が必要です。
---

<div class="hero-section">
    <div class="hero-content">
        <h1>aitm</h1>
        <p>AI を組み込んだ macOS デスクトップ向けターミナルアプリ。</p>
        <p>慣れ親しんだターミナル内で AI と直接協働 —— AI はファイルを読み、コマンド履歴を検索し、必要に応じてコマンドを実行できます。高リスクな操作はすべて、あなたの明示的な許可が必要です。</p>
        <div class="hero-links">
            <a href="#download" class="cta-button">今すぐダウンロード →</a>
            <a href="#first-use" class="github-link">クイックスタート</a>
        </div>
    </div>
</div>

<div class="content-section" markdown="1">

<div class="about-section">
    <h2>✨ 主な機能</h2>
    <div class="about-grid">
        <div class="about-card">
            <h3>🪟 マルチ tab ネイティブターミナル</h3>
            <p>各 tab は独立した PTY プロセス。xterm.js + WebGL レンダリングで即応する入力体験。</p>
        </div>
        <div class="about-card">
            <h3>🤖 AI サイドバー</h3>
            <p>右側ドロワー型 AI チャット。ストリーミング応答、Markdown レンダリング、ターミナル作業を中断せずいつでも呼び出し可能。</p>
        </div>
        <div class="about-card">
            <h3>🔧 AI ツール呼び出しループ</h3>
            <p>AI は提案だけにとどまらず、ファイル読み込み、コマンド履歴検索、コマンド実行を行えます。高リスクな操作は実行前に必ず確認ダイアログが出ます。</p>
        </div>
        <div class="about-card">
            <h3>🔔 システム通知</h3>
            <p>長いタスクの完了、AI の承認待ちなどを macOS のシステム通知 + Dock のステータスドットで知らせます。<code>⌘⇧U</code> で直近の未読に直接ジャンプ。</p>
        </div>
        <div class="about-card">
            <h3>📋 Tab メタ情報</h3>
            <p>各 tab に現在の git ブランチ / dirty 状態 / リッスン中ポートを表示。複数 tab を切り替えても迷わない。</p>
        </div>
        <div class="about-card">
            <h3>🧭 AI は今の状況を把握</h3>
            <p>AI がターミナル履歴ツールを呼ぶとき、現在の git ブランチ / 作業ディレクトリ / 占有ポートが自動的にコンテキストとして渡されます。毎回「今の状況」を説明する必要がありません。</p>
        </div>
        <div class="about-card">
            <h3>🎨 柔軟なレイアウト</h3>
            <p>AI サイドバーとファイルツリーの左右位置を切り替え可能。お使いの画面構成に合わせられます。</p>
        </div>
    </div>
</div>

<div class="recent-posts">
    <h2>🎯 こんなときに役立ちます</h2>
    <div class="post-grid">
        <div class="post-card">
            <div class="post-content">
                <h3>AI にプロジェクト構造をざっと見てもらう</h3>
                <p class="post-excerpt">「プロジェクトのルートに何があるか教えて」と尋ねるだけ。AI はファイルブラウズと読み込みツールを呼び出し、構造のサマリを返してくれます。<code>ls -R</code> やファイル開きの手間を省けます。</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>実行を AI に委ねる（決定権はあなた）</h3>
                <p class="post-excerpt">AI がコマンドを提案して実行をリクエスト → 確認ダイアログで「実行するコマンド：xxx」を表示 → あなたが OK したらターミナルで実行。AI は出力を見て次のステップを判断。</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>さっき打ったコマンドを振り返る</h3>
                <p class="post-excerpt">「さっき走らせた build コマンドって何だっけ？」 — AI が現在 tab のコマンド履歴を直接検索。スクロールや Ctrl+R より速い。</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>長いタスクは裏で走らせ、完了時に通知</h3>
                <p class="post-excerpt">ビルド / テスト / デプロイの完了時にシステム通知が表示されます。AI が一巡終わるか承認待ちになると、tab バーのステータスリングが色で知らせます。</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>用途に応じてモデルを切り替え</h3>
                <p class="post-excerpt">国内外 6 社の LLM から選択可能。デバッグ用、文章用、コード変換用と用途別に最適なモデルを使い分けられ、特定の 1 社に縛られません。</p>
            </div>
        </div>
    </div>
</div>

<div class="about-section">
    <h2>🧠 対応 AI プロバイダ</h2>
    <div class="about-grid">
        <div class="about-card">
            <h3>中国系</h3>
            <p>DeepSeek · Qwen (DashScope) · Zhipu GLM · Moonshot Kimi</p>
        </div>
        <div class="about-card">
            <h3>海外</h3>
            <p>OpenAI · Anthropic Claude</p>
        </div>
        <div class="about-card">
            <h3>設定方法</h3>
            <p>設定パネル → AI Provider → モデル選択 + API Key を入力 → 保存。再起動は不要です。</p>
        </div>
        <div class="about-card">
            <h3>切り替えコスト</h3>
            <p>OpenAI 互換プロトコルで統一抽象化。プロバイダを変えても会話履歴やツール呼び出しの振る舞いは変わりません。</p>
        </div>
    </div>
</div>

<h2 id="download">⬇️ ダウンロード</h2>

<div class="about-grid">
    <div class="about-card">
        <h3>現在のバージョン</h3>
        <p><strong>v0.6.0</strong> · macOS Apple Silicon (aarch64) · 6.4 MB</p>
        <p style="margin-top: 1rem;">
            <a href="/assets/downloads/aitm_0.6.0_aarch64.dmg" class="cta-button" download>dmg をダウンロード →</a>
        </p>
    </div>
    <div class="about-card">
        <h3>整合性の検証（推奨）</h3>
        <p>ダウンロード後、SHA256 を確認してください：</p>
        <pre><code>shasum -a 256 ~/Downloads/aitm_0.6.0_aarch64.dmg</code></pre>
        <p>結果は <a href="/assets/downloads/aitm_0.6.0_aarch64.dmg.sha256">公式チェックサム</a> と完全に一致するはずです。</p>
    </div>
</div>

### インストール手順

> ⚠️ aitm は現時点で Apple Developer 署名を持っていません。macOS はブラウザでダウンロードした未署名の .app に自動的に quarantine 属性を付与するため、ダブルクリック起動で **「aitm は壊れているため開けません」** と表示されます。これは Gatekeeper の誤解を招く文言で、ファイル自体は問題ありません。dmg にはこの処理を行う一括インストールスクリプトが同梱されています。

1. 上記の dmg をダウンロードして開くと、Finder に 3 つのアイコンが表示されます：
   - `aitm.app`
   - `Applications`（/Applications へのシンボリックリンク）
   - `install-aitm.command`
2. **`install-aitm.command` をダブルクリック**（macOS が自動的に Terminal で実行）
   - `aitm.app` を `/Applications/` にコピー
   - quarantine 属性をクリア
3. `✅ インストール完了` と表示されたら、任意のキーで Terminal を閉じます
4. Launchpad または Spotlight で「aitm」を検索して起動

dmg 内の `install-aitm.command` が動かない場合、フォールバックとして <a href="/assets/downloads/install-aitm.sh">install-aitm.sh</a> を単独でダウンロードできます：

```bash
bash ~/Downloads/install-aitm.sh
```

このスクリプトは `sudo` を必要とせず、`/Applications/aitm.app` と指定された dmg のみを操作します。

<h2 id="first-use">🚀 初めて使うとき</h2>

1. **アプリ起動**：Launchpad または Spotlight で「aitm」を検索
2. **AI Provider を設定**：右上の設定アイコン → AI Provider → 1 つ選択 → 対応するプラットフォームで取得した API Key を入力 → 保存
3. **（任意）プロジェクトスコープを初期化**：任意のターミナル tab でプロジェクトルートに `cd` してから実行
   ```bash
   aitm init
   # またはパスと名前を明示
   aitm init /path/to/project --name my-app
   ```
   AI のファイル読み込みツールはこのディレクトリ境界に制限されます。
4. **AI サイドバーを開く**：右レールのアイコン、またはキーボードショートカット
5. **初対話**：例えば *「プロジェクトルートに何があるか見せて」* のように尋ねるだけ。AI が必要に応じてツールを呼び出します。コマンド実行が伴う場合は確認ダイアログが出ます。

## 🛡️ セキュリティ設計

- **ローカルファースト保存**：ターミナルセッションとコマンド履歴はあなたのマシンに保存されます。aitm 自身はこれらのデータをいかなるバックエンドにもアップロードしません。AI 会話内容は、あなたが能動的に送信したときのみ、選択した Provider のプロトコルでモデル側に送られます。
- **AI ツール範囲の制御**：`aitm init` で設定したプロジェクト境界により、AI のファイル読み取りはその範囲を越えません。
- **高リスクコマンドのブラックリスト**：`rm -rf /` / `dd of=/dev/...` / fork bomb などの典型的な危険パターンは AI が呼び出せません。
- **実行には確認が必要**：AI がコマンドを実行する前に、必ず完全なコマンド内容を確認ダイアログで表示します。あなたが承認しない限り何も実行されません。
- **ツールループの上限**：1 回の対話内で自動ツール呼び出しの回数に上限を設けており、暴走を防ぎます。

## ❓ よくある質問

**Q: `aitm.app` をダブルクリックすると「壊れているため開けません」と出ます。**
Gatekeeper の誤検出です。[インストール手順](#download) の `install-aitm.command` / `install-aitm.sh` を実行してください。

**Q: 当面は macOS Apple Silicon のみですか？**
はい。現バージョンは Apple Silicon（M1/M2/M3/M4 シリーズ）向けにのみビルドされています。Intel Mac と Linux 対応は今後検討します。

**Q: API Key の管理は？**
API Key はあなたのマシン上の aitm ユーザー設定ディレクトリにのみ保存され、外部サーバーには一切アップロードされません。aitm 専用に権限を最小化し利用上限を設けた Key を用意し、通常のセキュリティ運用に沿って定期的にローテーションすることをお勧めします。

**Q: バグ報告やフィードバックは？**
[プロフィールページ](/ja/about/) の連絡先からお気軽にどうぞ。

</div>
