# 从 .env.local 文件加载环境变量
Get-Content .env.local | ForEach-Object {
    if ($_ -match '^([^#][^=]+)=(.*)$') {
        $name = $matches[1].Trim()
        $value = $matches[2].Trim()
        [Environment]::SetEnvironmentVariable($name, $value, 'Process')
        Write-Host "Setting $name"
    }
}

# 设置 Jekyll 环境为生产环境（使环境变量生效）
$env:JEKYLL_ENV = "production"

# 启动 Jekyll 服务
Write-Host "Starting Jekyll server..."
bundle exec jekyll serve --livereload
