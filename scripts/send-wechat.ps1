# WeChat Sender Script v1.6.0
# Minimal approach: Search → Enter → Type → Send

param(
    [Parameter(Mandatory=$true)]
    [string]$contact,
    
    [Parameter(Mandatory=$true)]
    [string]$message
)

Add-Type -AssemblyName System.Windows.Forms

Write-Host "WeChat Sender v1.6.0" -ForegroundColor Cyan
Write-Host "━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan

# Find any WeChat process
Write-Host "`nFinding WeChat..." -ForegroundColor Yellow
$wechat = Get-Process | Where-Object {$_.ProcessName -eq "WeChatAppEx"} | Select-Object -First 1

if (-not $wechat) {
    Write-Host "Error: WeChat not running!" -ForegroundColor Red
    exit 1
}

Write-Host "WeChat found (PID: $($wechat.Id))" -ForegroundColor Green

# Bring WeChat to front
Write-Host "Activating WeChat..." -ForegroundColor Yellow
$w = [System.Diagnostics.Process]::GetProcessById($wechat.Id)
Start-Sleep -Milliseconds 1000

# Step 1: Open search
Write-Host "Opening search (Ctrl+F)..." -ForegroundColor Yellow
[System.Windows.Forms.SendKeys]::SendWait("^f")
Start-Sleep -Milliseconds 800

# Step 2: Type contact name
Write-Host "Typing: $contact" -ForegroundColor Yellow
[System.Windows.Forms.SendKeys]::SendWait($contact)
Start-Sleep -Milliseconds 1500

# Step 3: Press Enter to select and open chat
Write-Host "Selecting contact (Enter)..." -ForegroundColor Green
[System.Windows.Forms.SendKeys]::SendWait("~")
Start-Sleep -Milliseconds 1500

# Step 4: Type message directly (input box should be focused now)
Write-Host "Typing message: $message" -ForegroundColor Yellow
[System.Windows.Forms.SendKeys]::SendWait($message)
Start-Sleep -Milliseconds 500

# Step 5: Send
Write-Host "Sending (Enter)..." -ForegroundColor Yellow
[System.Windows.Forms.SendKeys]::SendWait("~")
Start-Sleep -Milliseconds 500

Write-Host "`n✅ Done!" -ForegroundColor Green
Write-Host "━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
