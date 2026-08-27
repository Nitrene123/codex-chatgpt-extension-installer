# Codex ChatGPT ブラウザ拡張機能インストーラー

[简体中文](README.md) | [繁體中文](README.zh-TW.md) | [English](README.en.md) | [日本語](README.ja.md) | [한국어](README.ko.md)

Chrome ウェブストアの地域制限により拡張機能を取得できない環境で、Codex 用の ChatGPT ブラウザ拡張機能（「Control your browser with ChatGPT」）をローカルに読み込むための Windows スクリプトです。

## 背景

Codex のブラウザ操作は、「ChatGPT」ブラウザ拡張機能と native messaging を通じて通信します。地域によっては Chrome ウェブストアで拡張機能が表示されず、Codex が Chrome 拡張機能を検出できないことがあります。

別のブラウザ（Microsoft Edge など）に拡張機能がインストール済みなら、そのローカルファイルを抽出し、Chrome の「パッケージ化されていない拡張機能を読み込む」で利用できます。

## 主な機能

- Edge／Chrome のプロファイルを自動スキャンし、ChatGPT 拡張機能を検索
- 最新バージョンの拡張機能を抽出し、ストア署名メタデータ（`_metadata`）を削除
- manifest の `key` を保持し、Codex の native messaging host と拡張機能 ID の整合性を維持
- Chrome に読み込めるディレクトリと手順を出力
- 拡張機能本体の同梱・再配布は行わない

## 使い方

1. Microsoft Edge などに ChatGPT ブラウザ拡張機能がインストールされていることを確認します。
2. PowerShell で実行します。

~~~powershell
.\install.ps1
~~~

出力先を指定する場合：

~~~powershell
.\install.ps1 -Destination "D:\codex-chatgpt-extension"
~~~

3. `chrome://extensions` を開き、「デベロッパーモード」を有効にして「パッケージ化されていない拡張機能を読み込む」を選択し、出力先を指定します。
4. Codex → Settings → Computer use → Chrome browser extension に戻り、検出されたことを確認します。

## 制限事項

- ユーザーがすでにインストールし、使用権限を持つ拡張機能だけを抽出します。
- 拡張機能の著作権は OpenAI に帰属します。本プロジェクトはローカル抽出・インストール手順のみを提供します。
- ログイン、ペイウォール、その他のアクセス制御を回避しません。
- Chrome ウェブストア、OpenAI、および所在地の法令を遵守してください。

## リポジトリ構成

~~~text
codex-chatgpt-extension-installer/
├── install.ps1              # Windows 用抽出スクリプト
├── README.md                # 简体中文说明
├── README.zh-TW.md          # 繁體中文說明
├── README.en.md             # English documentation
├── README.ja.md             # 日本語ドキュメント
├── README.ko.md             # 한국어 문서
└── .gitignore               # 抽出した拡張機能ディレクトリを除外
~~~

## 免責事項

本プロジェクトは拡張機能のローカル抽出・インストール手順を説明するものです。拡張機能の権利帰属や再配布許可を変更するものではありません。利用者は自分の利用権限と適用される規約を確認してください。
