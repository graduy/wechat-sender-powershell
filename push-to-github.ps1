# Push to GitHub Script
# Usage: .\push-to-github.ps1 -RepoUrl "https://github.com/your-username/wechat-sender-powershell"

param(
    [string]$RepoUrl = "",
    [string]$CommitMessage = "Initial commit: WeChat Sender PowerShell v1.0.0"
)

Write-Host "Preparing to push to GitHub..." -ForegroundColor Cyan

# Check if git is installed
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Error: Git is not installed!" -ForegroundColor Red
    exit 1
}

# Initialize git repo if not already initialized
if (-not (Test-Path ".git")) {
    Write-Host "Initializing git repository..." -ForegroundColor Yellow
    git init
}

# Add all files
Write-Host "Adding files..." -ForegroundColor Yellow
git add .

# Commit
Write-Host "Committing changes..." -ForegroundColor Yellow
git commit -m $CommitMessage

# Add remote if URL provided
if ($RepoUrl) {
    Write-Host "Adding remote repository..." -ForegroundColor Yellow
    git remote add origin $RepoUrl
}

# Push
Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
git branch -M main
git push -u origin main

Write-Host "`nDone!" -ForegroundColor Green
