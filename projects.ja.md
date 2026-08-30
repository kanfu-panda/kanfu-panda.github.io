---
layout: default
title: プロジェクト
permalink: /projects/
lang: ja
description: 個人プロジェクトとオープンソース貢献 —— aitm デスクトップターミナル、PDLC Claude Code プラグイン、ブラウザ用アーケードエミュレータ、そしてこのブログ本体。
---

# プロジェクト

個人プロジェクトとオープンソース貢献の一部です。それぞれが進行中の探求の一部です。

## aitm
- **技術スタック**：Tauri 2 + React 19 + Rust + TypeScript、Apache-2.0 ライセンス
- **概要**：AI 機能をターミナルに直接統合したデスクトップアプリ。macOS と Windows に対応 —— 複数 tab の PTY + AI サイドバー + 内蔵ブラウザ。AI はファイルの読み書き、コマンド実行、ブラウザ操作が可能で、ファイル変更前には diff を表示。高リスクな操作には必ずユーザーの明示的な確認が必要です。
- **詳細**：[aitm 製品ページ](/ja/aitm/) · [GitHub](https://github.com/kanfu-panda/aitm)

## PDLC
- **技術スタック**：Claude Code プラグイン（Bash + Markdown テンプレート）、MIT ライセンス
- **概要**：AI による開発を「ソフトな慣習」から「ハードな契約」へ格上げする Claude Code プラグイン。38 個の標準化ステージがスラッシュコマンドとして公開、成果物は `docs/` 配下に保存、機能ごとに状態マシン、テストファースト（TDD レッドライトゲート）、自動修復は 1 回のみ。
- **詳細**：[PDLC 製品ページ](/ja/pdlc/) · [GitHub](https://github.com/kanfu-panda/pdlc-skills)

## arcade
- **技術スタック**：React + Vite + EmulatorJS（WASM）
- **概要**：ブラウザで動くアーケードエミュレータ。ローカルファイルをご自身で読み込む方式で、すべてブラウザの WASM サンドボックス内で実行されます — サーバーへは何もアップロードされません。⚠️ 個人的な娯楽、合法な用途に限ります。
- **詳細**：[arcade 製品ページ](/ja/arcade/)

## このブログ
- **技術スタック**：Jekyll、GitHub Pages
- **概要**：このサイトです。Jekyll で構築した純静的サイト、GitHub Pages でホスト。英語 / 中国語 / 日本語の 3 言語対応、CSP + SRI のセキュリティベースライン付き。
- **ソース**：[GitHub](https://github.com/kanfu-panda/kanfu-panda.github.io)

## さらに開発中...

これらのプロジェクトに興味があれば、お気軽にご連絡ください。
