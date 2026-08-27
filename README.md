# Codex ChatGPT 浏览器扩展安装助手

[简体中文](README.md) | [繁體中文](README.zh-TW.md) | [English](README.en.md) | [日本語](README.ja.md) | [한국어](README.ko.md)

用于在 Chrome 应用商店受地区限制的环境中，为 Codex 安装 ChatGPT 浏览器扩展（"Control your browser with ChatGPT"），让 Codex 的 Computer use / Chrome 浏览器控制功能恢复正常。

## 背景

Codex 的浏览器控制依赖一个名为「ChatGPT」的浏览器扩展，通过 native messaging 与 Codex 通信。在部分地区（例如中国大陆），该扩展在 Chrome 网上应用店中被隐藏（页面提示「此商品无法购买或下载」），导致 Codex 提示「检测不到 Chrome 浏览器扩展」。

如果本机已有其他浏览器（如 Microsoft Edge）安装了这个扩展，就可以把扩展文件从本地提取出来，再用 Chrome 的「加载已解压的扩展程序」方式安装，完全绕开应用店。

## 主要功能

- 自动扫描本机 Edge / Chrome 等浏览器，定位已安装的 ChatGPT 浏览器扩展
- 提取最新版本的扩展目录，并移除商店签名元数据（`_metadata`）
- 保留 manifest 中的 `key` 字段，确保扩展 ID 与 Codex 的 native messaging host 一致
- 一键生成可加载目录，并输出清晰的加载指引
- 不内置、不分发任何扩展二进制文件

## 使用方式

1. 确认本机已有某个浏览器安装了 ChatGPT 浏览器扩展（例如 Microsoft Edge）。
2. 运行脚本：

~~~powershell
.\install.ps1
~~~

如需指定输出目录：

~~~powershell
.\install.ps1 -Destination "D:\codex-chatgpt-extension"
~~~

3. 脚本会打印扩展所在位置，并按提示在 Chrome 中加载：

- 打开 Chrome → 地址栏输入 `chrome://extensions` 并回车
- 打开右上角「开发者模式」
- 点击左上角「加载已解压的扩展程序」，选择脚本输出的目录（默认 `C:\Users\<用户名>\codex-chatgpt-extension`）

4. 回到 Codex → 设置 → Computer use → Chrome 浏览器扩展，确认已检测到。

## 处理流程

1. 枚举本机 Edge / Chrome 的用户数据目录（`User Data`）及所有 Profile。
2. 按扩展 ID 匹配 ChatGPT 浏览器扩展，并取最新版本目录。
3. 将扩展文件复制到目标目录，移除 `_metadata` 商店签名元数据。
4. 校验 `manifest.json` 是否含 `key` 字段（用于保持扩展 ID 不变）。
5. 输出 Chrome「加载已解压的扩展程序」的加载指引。

## 使用限制

- 仅提取本机已安装、且用户有权使用的扩展，不提供、不分发任何扩展二进制文件。
- 扩展版权归 OpenAI 所有；本项目只提供「从你自己已安装的浏览器中提取」的自动化流程，不构成对扩展的再分发。
- 不绕过账号登录、付费墙或其他访问控制。
- 请遵守 Chrome 应用商店、OpenAI 及所在地法律法规。

## 仓库结构

~~~text
codex-chatgpt-extension-installer/
├── install.ps1              # Windows 一键提取脚本
├── README.md                # 简体中文说明
├── README.zh-TW.md          # 繁體中文說明
├── README.en.md             # English documentation
├── README.ja.md             # 日本語ドキュメント
├── README.ko.md             # 한국어 문서
└── .gitignore               # 忽略提取出的扩展目录
~~~

## 内容责任

本项目提供扩展的「本地提取与安装」流程说明，不改变扩展的版权归属，也不构成对扩展的转载或再分发授权。使用者应自行确认对扩展的使用权限，并遵守相关条款与法规。
