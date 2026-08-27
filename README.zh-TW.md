# Codex ChatGPT 瀏覽器擴充功能安裝助手

[简体中文](README.md) | [繁體中文](README.zh-TW.md) | [English](README.en.md) | [日本語](README.ja.md) | [한국어](README.ko.md)

用於在 Chrome 線上應用程式商店受地區限制時，為 Codex 安裝 ChatGPT 瀏覽器擴充功能（「Control your browser with ChatGPT」），恢復 Codex 的 Computer use／Chrome 瀏覽器控制功能。

## 背景

Codex 的瀏覽器控制依賴名為「ChatGPT」的瀏覽器擴充功能，透過 native messaging 與 Codex 通訊。在部分地區，該擴充功能可能不會顯示於 Chrome 線上應用程式商店，導致 Codex 顯示找不到 Chrome 瀏覽器擴充功能。

如果本機其他瀏覽器（例如 Microsoft Edge）已安裝此擴充功能，可以先從本機提取檔案，再使用 Chrome 的「載入未封裝項目」方式安裝。

## 主要功能

- 自動掃描本機 Edge／Chrome 等瀏覽器，尋找已安裝的 ChatGPT 瀏覽器擴充功能
- 提取最新版本的擴充功能目錄，並移除商店簽章中繼資料（`_metadata`）
- 保留 manifest 中的 `key` 欄位，確保擴充功能 ID 與 Codex 的 native messaging host 一致
- 產生可載入的目錄，並輸出清楚的安裝指引
- 不內建、不分發任何擴充功能二進位檔案

## 使用方式

1. 確認本機已有瀏覽器安裝 ChatGPT 瀏覽器擴充功能，例如 Microsoft Edge。
2. 執行腳本：

~~~powershell
.\install.ps1
~~~

如需指定輸出目錄：

~~~powershell
.\install.ps1 -Destination "D:\codex-chatgpt-extension"
~~~

3. 依照腳本指示在 Chrome 中載入：開啟 `chrome://extensions`、啟用「開發人員模式」、點擊「載入未封裝項目」，並選取腳本輸出的目錄。
4. 回到 Codex → 設定 → Computer use → Chrome 瀏覽器擴充功能，確認已偵測到。

## 使用限制

- 僅提取使用者已安裝且有權使用的擴充功能，不提供或分發擴充功能本體。
- 擴充功能版權歸 OpenAI 所有；本專案只提供本機提取與安裝流程。
- 不繞過登入、付費牆或其他存取控制。
- 請遵守 Chrome 線上應用程式商店、OpenAI 及所在地的法律與規範。

## 倉庫結構

~~~text
codex-chatgpt-extension-installer/
├── install.ps1              # Windows 一鍵提取腳本
├── README.md                # 簡體中文說明
├── README.zh-TW.md          # 繁體中文說明
├── README.en.md             # English documentation
├── README.ja.md             # 日本語ドキュメント
├── README.ko.md             # 한국어 문서
└── .gitignore               # 忽略提取出的擴充功能目錄
~~~

## 內容責任

本專案提供擴充功能的本機提取與安裝流程說明，不改變擴充功能的版權歸屬，也不構成重新發布授權。使用者應自行確認使用權限並遵守相關條款與法規。
