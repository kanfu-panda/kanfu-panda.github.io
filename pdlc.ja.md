---
layout: default
title: PDLC
permalink: /pdlc/
lang: ja
description: PDLC — Claude Code に「製品開発ライフサイクル」ワークフローを追加するオープンソースプラグイン。31 個の標準化されたステージ、状態マシン、テストファースト強制、ステージ自己チェック、自動修復は1回まで。「ソフトな慣習」を「ハードな契約」へ。MIT ライセンス。
---

<div class="hero-section">
    <div class="hero-content">
        <h1>PDLC</h1>
        <p><strong>Claude Code</strong> に「製品開発ライフサイクル」ワークフローを追加するオープンソースプラグイン。</p>
        <p>31 個の標準化されたステージがすべてスラッシュコマンドとして公開。すべての成果物がディスクに保存され、すべてのステージが状態マシンを更新し、実装前に失敗するテストが必要。「ソフトな慣習」を「ハードな契約」へ。</p>
        <div class="hero-links">
            <a href="https://github.com/kanfu-panda/pdlc-skills" class="cta-button">GitHub で見る →</a>
            <a href="#install" class="github-link">インストール</a>
        </div>
    </div>
</div>

<div class="content-section" markdown="1">

<div class="about-section">
    <h2>✨ なぜ PDLC が必要か</h2>
    <div class="about-grid">
        <div class="about-card">
            <h3>📝 成果物がディスクに保存</h3>
            <p>各ステージが <code>docs/</code> 配下に実ファイルを生成。「PRD が会話の中だけに存在する」状態を排除。<code>git diff</code> で AI の実際の作業を確認できます。</p>
        </div>
        <div class="about-card">
            <h3>📊 機能ごとの状態マシン</h3>
            <p><code>docs/.pdlc-state/&lt;feature-id&gt;.json</code> がすべてのステージ遷移を記録。<code>/pdlc-status</code> で各機能の現状が即座に分かります。</p>
        </div>
        <div class="about-card">
            <h3>🚦 テストファースト</h3>
            <p>厳格な TDD レッドライトゲート。失敗するテストが存在しない限り実装は進めません。「あとでテスト追加する」を許しません。</p>
        </div>
        <div class="about-card">
            <h3>🔍 ハンドオフ前のセルフチェック</h3>
            <p>各ステージは次へ進む前に自己監査を実行。ズレはステージ境界で検出され、レビューまで持ち越されません。</p>
        </div>
        <div class="about-card">
            <h3>🛠️ 自動修復は 1 回のみ</h3>
            <p>自動修復ループは最大 1 回のみ実行。解決しない問題は人間にエスカレートし、「修正 → 確認 → 修正」の無限ループを防ぎます。</p>
        </div>
        <div class="about-card">
            <h3>🧭 明示的な next_step</h3>
            <p>各ステージが次のステップを宣言。マルチステージのフローはコマンド駆動で、暗黙の記憶に頼りません。</p>
        </div>
    </div>
</div>

<div class="recent-posts">
    <h2>🎯 こんなときに役立ちます</h2>
    <div class="post-grid">
        <div class="post-card">
            <div class="post-content">
                <h3>機能をエンドツーエンドで実装</h3>
                <p class="post-excerpt"><code>/pdlc-feature ログインに電話番号認証を追加</code> — PDLC が PRD → 設計 → TDD → 実装 → レビュー → リリースまでをつなぎ、各ステージで成果物を保存します。</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>監査可能なバグ修正</h3>
                <p class="post-excerpt"><code>/pdlc-fix 空リストでのページネーションクラッシュ</code> — 特定、再現、修正、テスト、ドキュメント化。<code>docs/04_testing/defects/</code> 配下の欠陥記録は会話より長く残ります。</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>機能ごとの進捗を一目で把握</h3>
                <p class="post-excerpt"><code>/pdlc-status</code> がすべての状態マシンファイルを読み、PRD 段階・TDD レッドライト・リリース可能、といった状態を一画面で表示します。</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>レガシープロジェクトを取り込む</h3>
                <p class="post-excerpt"><code>/pdlc-adopt</code> が既存コードベースを調査、欠けている標準と設計ドキュメントを補完、PDLC のディレクトリ構造をブートストラップ — コードは書き換えません。</p>
            </div>
        </div>
        <div class="post-card">
            <div class="post-content">
                <h3>トレンド付きの振り返り</h3>
                <p class="post-excerpt"><code>/pdlc-retro</code> が今期と過去の状態マシンデータを比較 — 「レビュー通過率の低下」「今期は TDD レッドライトがスキップされた」などのトレンドが浮き彫りに。</p>
            </div>
        </div>
    </div>
</div>

<div class="about-section">
    <h2>📦 31 個のコマンド、3 層構成</h2>
    <div class="about-grid">
        <div class="about-card">
            <h3>第 1 層 · エントリポイント（3）</h3>
            <p><code>/pdlc-feature</code> · <code>/pdlc-fix</code> · <code>/pdlc-status</code></p>
            <p style="opacity: 0.75; font-size: 0.9em;">一文のプロンプトがチェーン全体を駆動。</p>
        </div>
        <div class="about-card">
            <h3>第 2 層 · ステージ（11）</h3>
            <p><code>prd</code> · <code>design</code> · <code>tdd</code> · <code>implement</code> · <code>review</code> · <code>e2e</code> · <code>refactor</code> · <code>ship</code> · <code>deploy</code> · <code>retro</code> · <code>task</code></p>
            <p style="opacity: 0.75; font-size: 0.9em;">個別ステージを細かく制御。</p>
        </div>
        <div class="about-card">
            <h3>第 3 層 · ツール（17）</h3>
            <p>UI 設計 / DB 設計 / アーキ / セキュリティ / 性能 / コード生成 / サービス追加 / アプリ追加 / i18n / マイグレーション / changelog / bootstrap / adopt / onboard / 等</p>
            <p style="opacity: 0.75; font-size: 0.9em;">必要に応じて明示的に呼び出す専門ステージ。</p>
        </div>
        <div class="about-card">
            <h3>配布形式</h3>
            <p>標準的な <strong>Claude Code プラグイン</strong> として配布。インストール後は <code>~/.claude/plugins/pdlc/</code>。</p>
            <p style="opacity: 0.75; font-size: 0.9em;">MIT ライセンス、GitHub 公開。</p>
        </div>
    </div>
</div>

<h2 id="install">⬇️ インストール</h2>

<div class="about-grid">
    <div class="about-card">
        <h3>ワンライナー（グローバル）</h3>
        <p><code>~/.claude/plugins/pdlc/</code> にインストール。clone 不要。</p>
        <pre><code>curl -fsSL https://raw.githubusercontent.com/kanfu-panda/pdlc-skills/main/install.sh \
  | bash -s -- --global</code></pre>
    </div>
    <div class="about-card">
        <h3>プロジェクト単位</h3>
        <p>特定プロジェクトの <code>.claude/plugins/pdlc/</code> にインストール。</p>
        <pre><code>curl -fsSL https://raw.githubusercontent.com/kanfu-panda/pdlc-skills/main/install.sh \
  | bash -s -- --project /path/to/my-project</code></pre>
    </div>
</div>

### Claude Code ネイティブコマンドの場合

Claude Code の plugin CLI を直接使う場合：

```bash
claude plugin marketplace add kanfu-panda/pdlc-skills
claude plugin install pdlc@pdlc-skills
```

### インストール確認

```bash
claude plugin list | grep pdlc
# 期待値: pdlc@pdlc-skills  Version: 1.0.0  Status: ✔ enabled
```

Claude Code セッションを再起動後、入力欄で `/` を入力し `pdlc-` と打ち始めれば、autocomplete に 31 個のサブコマンドすべてが表示されます。

## 🧪 3 ステップで始める

```bash
# 1. インストール
curl -fsSL https://raw.githubusercontent.com/kanfu-panda/pdlc-skills/main/install.sh \
  | bash -s -- --global

# 2. 機能を実装（Claude Code 内）
/pdlc-feature ログインに画像認証を追加

# 3. バグを修正
/pdlc-fix 空リストでのページネーションクラッシュ
```

進捗確認はいつでも `/pdlc-status`。

## 🛡️ Iron Law（鉄則）

成果物を生成する第 1 層 / 第 2 層のすべてのステージは、5 つの不変条件を満たす必要があります。読み取り専用ステージ（`/pdlc-status` など）は例外。

1. **ディスクに保存** — すべての成果物は実ファイル、チャット出力だけではない
2. **状態マシンを更新** — 完了したステージは必ず `docs/.pdlc-state/<feature-id>.json` を書く
3. **テストファースト** — 失敗するテストが存在しない限り実装できない（TDD レッドライト）
4. **セルフチェック** — 各ステージはハンドオフ前に自己監査を実行
5. **自動修復は 1 回のみ** — 自動修正ループは最大 1 回まで、解決しない問題は人間に委ねる

## 📁 ターゲットプロジェクトの契約

ステージ実行時、プロジェクト内の以下のパスを読み書きします：

```
docs/00_standards/coding/                          # コーディング規約（読み取り専用）
docs/01_requirements/prd/                          # PRD
docs/02_design/{api,database,architecture,ui-ux}/  # 技術設計
docs/03_development/                               # 開発者マニュアル
docs/04_testing/{unit-tests,e2e-tests,defects,...} # テスト & 欠陥
docs/05_deployment/                                # デプロイドキュメント
docs/06_tasks/                                     # ステージ内タスク追跡
docs/07_reviews/{doc,code,design,retro}/           # レビュー記録
docs/.pdlc-state/<feature-id>.json                 # 機能ごとの状態マシン
```

## 📄 ライセンス

MIT。使用、フォーク、リリース、すべて自由。ソースコード、Issue、完全なドキュメント：**[github.com/kanfu-panda/pdlc-skills](https://github.com/kanfu-panda/pdlc-skills)**。

## ❓ よくある質問

**Q: Claude Code 以外でも使えますか？**
いいえ — PDLC は Claude Code のプラグインで、Claude Code のプラグイン / スラッシュコマンド基盤に依存します。現時点では Claude Code のみ対応。

**Q: 確認なしにコードを変更しますか？**
成果物を生成するステージは確かにファイルを書き込みます（`docs/` 配下と実装時はコードベース）。各ステージはセルフチェックを実行し、次に進む前に明示的にハンドオフを通知します。Claude Code 自体の権限確認プロンプトも通常通り機能します。

**Q: テンプレートをカスタマイズするには？**
リポジトリを clone → `references/templates/*.md` または `skills/pdlc-*/SKILL.md` を編集 → clone ディレクトリで `bash install.sh --global` を実行してカスタマイズ版をインストール。詳細は [CONTRIBUTING.md](https://github.com/kanfu-panda/pdlc-skills/blob/main/CONTRIBUTING.md)。

**Q: バグ報告 / ディスカッション？**
使い方・設計の議論は [GitHub Discussions](https://github.com/kanfu-panda/pdlc-skills/discussions)、確認済みのバグは [Issues](https://github.com/kanfu-panda/pdlc-skills/issues) へ。プライベートなセキュリティ報告は、リポジトリの [SECURITY.md](https://github.com/kanfu-panda/pdlc-skills/blob/main/SECURITY.md) を参照。

</div>
