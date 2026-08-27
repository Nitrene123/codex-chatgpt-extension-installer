<#
  Codex ChatGPT 浏览器扩展 — 一键提取脚本 (Windows)
  --------------------------------------------------
  从本机已安装该扩展的浏览器（Edge / Chrome 等）中提取 ChatGPT 浏览器扩展，
  生成可直接在 Chrome「加载已解压的扩展程序」中使用的目录。

  用途：当 Chrome 网上应用店因地区限制无法安装该扩展时，用它从本机其他
  浏览器中提取扩展文件，绕开应用店安装。

  用法：
    .\install.ps1
    .\install.ps1 -Destination "D:\codex-chatgpt-extension"
#>

[CmdletBinding()]
param(
    # 输出目录。默认在用户主目录下。
    [string]$Destination = "$env:USERPROFILE\codex-chatgpt-extension",

    # 保留 _metadata 目录（默认移除，加载 unpacked 扩展不需要它）。
    [switch]$KeepMetadata
)

$ErrorActionPreference = 'Stop'

# Codex native messaging host (com.openai.codexextension) 允许的两个扩展 ID
$ExtensionIds = @(
    'hehggadaopoacecdllhhajmbjkdcmajg'   # Chrome Web Store 版本
    'odlomjlbamekndcpllcnffbgeohgkmjh'   # Edge Add-ons 版本
)

function Get-BrowserUserDataRoots {
    $local = $env:LOCALAPPDATA
    if (-not $local) { return @() }

    $roots = @()
    $candidates = @(
        "$local\Microsoft\Edge\User Data",
        "$local\Google\Chrome\User Data",
        "$local\BraveSoftware\Brave-Browser\User Data"
    )
    foreach ($c in $candidates) {
        if (Test-Path $c) { $roots += $c }
    }
    return $roots
}

function Find-Extension {
    param([string[]]$Roots, [string[]]$Ids)

    foreach ($root in $Roots) {
        $profiles = Get-ChildItem $root -Directory -ErrorAction SilentlyContinue |
            Where-Object { Test-Path (Join-Path $_.FullName 'Extensions') }

        foreach ($profile in $profiles) {
            $extRoot = Join-Path $profile.FullName 'Extensions'
            foreach ($id in $Ids) {
                $idDir = Join-Path $extRoot $id
                if (Test-Path $idDir) {
                    # 取最新版本目录（按最后写入时间降序，通常是当前启用的版本）
                    $verDir = Get-ChildItem $idDir -Directory -ErrorAction SilentlyContinue |
                        Sort-Object LastWriteTime -Descending |
                        Select-Object -First 1
                    if ($verDir) {
                        return [PSCustomObject]@{
                            Source  = $verDir.FullName
                            Id      = $id
                            Version = $verDir.Name
                            Browser = Split-Path (Split-Path $root -Parent) -Leaf
                            Profile = $profile.Name
                        }
                    }
                }
            }
        }
    }
    return $null
}

Write-Host '==> 正在本机浏览器中查找 ChatGPT 浏览器扩展 ...' -ForegroundColor Cyan

$roots  = Get-BrowserUserDataRoots
$found  = Find-Extension -Roots $roots -Ids $ExtensionIds

if (-not $found) {
    Write-Host ''
    Write-Host '[!] 未找到 ChatGPT 浏览器扩展。' -ForegroundColor Red
    Write-Host '    请先在 Edge 或 Chrome 中安装「ChatGPT」浏览器扩展（Control your browser with ChatGPT）。' -ForegroundColor Yellow
    Write-Host '    如果确定已安装，请检查扩展 ID 是否在受支持列表中，并反馈给作者。' -ForegroundColor Yellow
    exit 1
}

Write-Host "    找到扩展：ID=$($found.Id)  版本=$($found.Version)"
Write-Host "    来源：$($found.Browser) / Profile = $($found.Profile)"
Write-Host ''

if (Test-Path $Destination) {
    Write-Host "==> 目标目录已存在，正在覆盖：$Destination" -ForegroundColor Yellow
    Remove-Item $Destination -Recurse -Force
}

New-Item -ItemType Directory -Force $Destination | Out-Null
Copy-Item -Path (Join-Path $found.Source '*') -Destination $Destination -Recurse -Force

if (-not $KeepMetadata) {
    $meta = Join-Path $Destination '_metadata'
    if (Test-Path $meta) {
        Remove-Item $meta -Recurse -Force
        Write-Host '    已移除 _metadata 商店签名目录' -ForegroundColor DarkGray
    }
}

$manifestPath = Join-Path $Destination 'manifest.json'
if (-not (Test-Path $manifestPath)) {
    Write-Host '[!] 提取失败：manifest.json 不存在。' -ForegroundColor Red
    exit 1
}

$manifest = Get-Content $manifestPath -Raw | ConvertFrom-Json
if (-not $manifest.key) {
    Write-Host '[!] 警告：manifest 缺少 key 字段，扩展 ID 可能与 Codex 期望的不一致。' -ForegroundColor Yellow
}

Write-Host ''
Write-Host '==> 完成！扩展已提取到：' -ForegroundColor Green
Write-Host "    $Destination"
Write-Host ''
Write-Host '接下来请在 Chrome 中手动完成最后一步（需 GUI 操作）：' -ForegroundColor Cyan
Write-Host '  1. 打开 Chrome，地址栏输入 chrome://extensions 并回车'
Write-Host '  2. 打开右上角「开发者模式」开关'
Write-Host '  3. 点击左上角「加载已解压的扩展程序」'
Write-Host "  4. 选择目录：$Destination"
Write-Host ''
Write-Host '  然后回到 Codex → 设置 → Computer use → Chrome 浏览器扩展，确认已检测到。' -ForegroundColor Cyan
