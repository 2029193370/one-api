# One API 本地后端（Windows）：SQLite 需 CGO；tiktoken 使用本地缓存避免走失效代理
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root

$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
$env:CGO_ENABLED = "1"
$env:PORT = "3000"
$env:TIKTOKEN_CACHE_DIR = Join-Path $root ".tiktoken_cache"

foreach ($k in @("HTTP_PROXY", "HTTPS_PROXY", "ALL_PROXY", "http_proxy", "https_proxy", "all_proxy")) {
    Remove-Item "Env:$k" -ErrorAction SilentlyContinue
}

New-Item -ItemType Directory -Force -Path (Join-Path $root "logs") | Out-Null
go run . --port 3000 --log-dir (Join-Path $root "logs")
