# WeChat Sender Script
# Using PowerShell SendKeys to simulate keyboard input
# Version: 1.0.0

param(
    [Parameter(Mandatory=$true)]
    [string]$contact,
    
    [Parameter(Mandatory=$true)]
    [string]$message
)

# Load Windows Forms for simulating key presses
Add-Type -AssemblyName System.Windows.Forms

Write-Host "WeChat Sender v1.0.0" -ForegroundColor Cyan
Write-Host "━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan

# Check if WeChat is running
Write-Host "`nChecking WeChat status..." -ForegroundColor Yellow
$wechatWindow = Get-Process | Where-Object {$_.ProcessName -eq "WeChatAppEx"} | Select-Object -First 1

if (-not $wechatWindow) {
    Write-Host "Error: WeChat is not running!" -ForegroundColor Red
    Write-Host "Please make sure WeChat PC version is logged in" -ForegroundColor Yellow
    exit 1
}

Write-Host "WeChat is running (PID: $($wechatWindow.Id))" -ForegroundColor Green

# Activate WeChat window
Write-Host "`nActivating WeChat window..." -ForegroundColor Yellow
[System.Windows.Forms.SendKeys]::SendWait("%{TAB}")  # Alt+Tab to switch window
Start-Sleep -Milliseconds 500

# Activate search box (Ctrl+F)
Write-Host "Opening search box..." -ForegroundColor Yellow
[System.Windows.Forms.SendKeys]::SendWait("^f")
Start-Sleep -Milliseconds 500

# Input contact name
Write-Host "Searching contact: $contact" -ForegroundColor Yellow
[System.Windows.Forms.SendKeys]::SendWait($contact)
Start-Sleep -Milliseconds 1000

# Press Enter to select first search result
Write-Host "Selecting contact..." -ForegroundColor Green
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
Start-Sleep -Milliseconds 500

# Input message
Write-Host "Inputting message..." -ForegroundColor Yellow
[System.Windows.Forms.SendKeys]::SendWait($message)
Start-Sleep -Milliseconds 500

# Send message (Enter)
Write-Host "Sending message..." -ForegroundColor Yellow
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
Start-Sleep -Milliseconds 500

Write-Host "`nMessage sent successfully!" -ForegroundColor Green
Write-Host "━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
