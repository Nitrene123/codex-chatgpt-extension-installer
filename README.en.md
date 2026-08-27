# Codex ChatGPT Browser Extension Installer

[简体中文](README.md) | [繁體中文](README.zh-TW.md) | [English](README.en.md) | [日本語](README.ja.md) | [한국어](README.ko.md)

Installs the ChatGPT browser extension ("Control your browser with ChatGPT") for Codex in regions where the Chrome Web Store listing is unavailable, restoring Codex's Computer use / Chrome browser control.

## Background

Codex's browser control relies on a browser extension called "ChatGPT", which talks to Codex over native messaging. In some regions (e.g. mainland China), this extension is hidden from the Chrome Web Store (the page shows "This item cannot be purchased or downloaded"), which causes Codex to report that it cannot detect the Chrome browser extension.

If another browser on the machine (such as Microsoft Edge) already has the extension installed, you can extract its files locally and load them into Chrome via "Load unpacked", bypassing the store entirely.

## Features

- Automatically scans Edge / Chrome and locates the installed ChatGPT browser extension
- Extracts the latest version and removes the store signature metadata (`_metadata`)
- Keeps the `key` field in the manifest so the extension ID stays consistent with Codex's native messaging host
- Produces a loadable directory and prints clear loading instructions
- Does not bundle or redistribute any extension binaries

## Usage

1. Make sure some browser on the machine already has the ChatGPT browser extension installed (e.g. Microsoft Edge).
2. Run the script:

~~~powershell
.\install.ps1
~~~

To use a custom output directory:

~~~powershell
.\install.ps1 -Destination "D:\codex-chatgpt-extension"
~~~

3. Follow the printed instructions to load it in Chrome:

- Open Chrome → enter `chrome://extensions` in the address bar
- Turn on "Developer mode" (top-right)
- Click "Load unpacked" (top-left) and select the output directory (default `C:\Users\<username>\codex-chatgpt-extension`)

4. Go back to Codex → Settings → Computer use → Chrome browser extension and confirm it is detected.

## How it works

1. Enumerates the `User Data` directory and all profiles of Edge / Chrome.
2. Matches the ChatGPT browser extension by extension ID and picks the latest version.
3. Copies the extension files to the destination and removes the `_metadata` store signature.
4. Verifies that `manifest.json` contains the `key` field (keeps the extension ID unchanged).
5. Prints instructions for "Load unpacked" in Chrome.

## Limitations

- Only extracts the extension the user already has installed and is entitled to use; it does not provide or redistribute any extension binaries.
- The extension is copyright OpenAI; this project only automates "extract from a browser you already installed it in" and does not constitute redistribution.
- Does not bypass account login, paywalls, or other access controls.
- Comply with the Chrome Web Store, OpenAI, and local laws and regulations.

## Repository structure

~~~text
codex-chatgpt-extension-installer/
├── install.ps1              # One-click extraction script (Windows)
├── README.md                # 简体中文说明
├── README.zh-TW.md          # 繁體中文說明
├── README.en.md             # English documentation
├── README.ja.md             # 日本語ドキュメント
├── README.ko.md             # 한국어 문서
└── .gitignore               # Ignores the extracted extension directory
~~~

## Responsibility

This project documents an "extract and install locally" workflow. It does not change the ownership of the extension and does not constitute redistribution or re-publication. Users should confirm their right to use the extension and comply with applicable terms and regulations.
