---
layout: default
title: aitm
permalink: /aitm/
lang: ja
description: aitm — AI を組み込んだデスクトップ向けターミナルアプリ。macOS と Windows に対応。AI がファイル読み込み、コマンド履歴検索、コマンド実行を行えます。すべての高リスク操作には明示的な確認が必要です。
---

<div class="hero-section">
    <div class="hero-content">
        <h1>aitm</h1>
        <p>AI を組み込んだデスクトップ向けターミナルアプリ —— macOS と Windows に対応。</p>
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
        <div class="about-card">
            <h3>📝 ファイルエディタ内蔵</h3>
            <p>aitm 内でプロジェクトファイルを直接編集できます。CodeMirror ベースでシンタックスハイライト対応、別エディタへの切り替えは不要です。</p>
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

**現在のバージョン：v1.0.0**

<div class="about-grid">
    <div class="about-card">
        <h3>🍎 macOS Apple Silicon</h3>
        <p>dmg · 6.5 MB · aarch64（M1/M2/M3/M4）</p>
        <p style="margin-top: 1rem;">
            <a href="https://github.com/kanfu-panda/aitm/releases/download/v1.0.0/aitm_1.0.0_aarch64.dmg" class="cta-button">.dmg をダウンロード →</a>
        </p>
        <p style="margin-top: 0.5rem; font-size: 0.85em;">
            <a href="https://github.com/kanfu-panda/aitm/releases/tag/v1.0.0">リリースページ</a>
        </p>
    </div>
    <div class="about-card">
        <h3>🪟 Windows x86_64</h3>
        <p>Intel / AMD 64ビット</p>
        <p style="margin-top: 1rem;">
            <a href="https://github.com/kanfu-panda/aitm/releases/download/v1.0.0/aitm_1.0.0_x64_en-US.msi" class="cta-button">ダウンロード .msi · x64 →</a>
        </p>
        <p style="margin-top: 0.5rem; font-size: 0.85em;">
            または <a href="https://github.com/kanfu-panda/aitm/releases/download/v1.0.0/aitm_1.0.0_x64-setup.exe">NSIS .exe</a> ·
            <a href="https://github.com/kanfu-panda/aitm/releases/tag/v1.0.0">リリースページ</a>
        </p>
    </div>
    <div class="about-card">
        <h3>🪟 Windows ARM64</h3>
        <p>Surface Pro X / Snapdragon ノート</p>
        <p style="margin-top: 1rem;">
            <a href="https://github.com/kanfu-panda/aitm/releases/download/v1.0.0/aitm_1.0.0_arm64_en-US.msi" class="cta-button">ダウンロード .msi · ARM64 →</a>
        </p>
        <p style="margin-top: 0.5rem; font-size: 0.85em;">
            または <a href="https://github.com/kanfu-panda/aitm/releases/download/v1.0.0/aitm_1.0.0_arm64-setup.exe">NSIS .exe</a> ·
            <a href="https://github.com/kanfu-panda/aitm/releases/tag/v1.0.0">リリースページ</a>
        </p>
    </div>
</div>

### インストール手順 — macOS

aitm は Apple Developer ID で署名・公証済みです。Gatekeeper が自動的に許可します。

1. 上記の dmg をダウンロードして開く
2. aitm.app を Applications フォルダにドラッグ
3. Launchpad または Spotlight で起動（"aitm" で検索）

### インストール手順 — Windows

> ⚠️ aitm の Windows インストーラーは現時点でコード署名されていないため、初回実行時に SmartScreen / Defender が「Windows によって PC が保護されました」を表示することがあります。**詳細情報 → 実行** をクリックしてください。ファイル自体は問題ありません。

**MSI インストーラー（推奨）：**

1. ダウンロードした `.msi` をダブルクリック
2. ウィザードに従って進めてください — デフォルトでユーザー領域にインストールされ、管理者権限は不要です
3. スタートメニューで「aitm」を検索して起動

**NSIS `.exe` インストーラー（小さめの代替）：**

1. ダウンロードした `-setup.exe` をダブルクリック
2. インストール先を選択 → 次へ → インストール
3. スタートメニューで「aitm」を検索して起動

企業 / IT 配布の場合は MSI 推奨（Group Policy などとの相性が良い）。個人利用ならどちらでも OK、NSIS のほうがサイズは小さいです。

### 整合性の検証（全プラットフォーム共通）

各インストーラーには対応する `.sha256` ファイルが付属しています。検証コマンド：

```bash
# macOS / Linux / Windows 上の Git Bash
shasum -a 256 path/to/aitm_1.0.0_<arch>.<ext>
```

```powershell
# Windows PowerShell
(Get-FileHash path\to\aitm_1.0.0_<arch>.<ext> -Algorithm SHA256).Hash.ToLower()
```

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

**Q: macOS で `aitm.app` をダブルクリックすると「壊れているため開けません」と出ます。**
aitm v1.0.0 は Apple Developer ID で署名・公証済みのため、通常のダウンロードとインストールではこの警告は表示されません。古いバージョンをお使いの場合は v1.0.0 にアップデートしてください。

**Q: Windows で「Windows によって PC が保護されました」SmartScreen 警告が出ます。**
macOS と同根：aitm v1.0.0 の Windows インストーラーは現時点で未署名です。**詳細情報 → 実行** をクリックしてください。署名証明書は今後の対応予定です。

**Q: 対応プラットフォームは？**
macOS Apple Silicon（M1/M2/M3/M4）と Windows の両アーキテクチャ（x86_64 と ARM64、Surface Pro X や Snapdragon ノートも対応）。Intel Mac と Linux はロードマップ上の課題です。

**Q: Windows で MSI と NSIS、どちらを選べばいい？**
どちらでも OK です。**MSI** は企業 / IT 配布向き（Group Policy・自動更新ツールとの相性）。**NSIS** (`.exe`) はサイズが小さく、馴染みのあるウィザード UI です。個人利用ならどちらでも問題ありません。

**Q: API Key の管理は？**
API Key はあなたのマシン上の aitm ユーザー設定ディレクトリにのみ保存され、外部サーバーには一切アップロードされません。aitm 専用に権限を最小化し利用上限を設けた Key を用意し、通常のセキュリティ運用に沿って定期的にローテーションすることをお勧めします。

**Q: バグ報告やフィードバックは？**
[プロフィールページ](/ja/about/) の連絡先からお気軽にどうぞ。

</div>
