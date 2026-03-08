# WeChat Sender Script
# Using PowerShell SendKeys to simulate keyboard input
# Version: 1.1.0

param(
    [Parameter(Mandatory=$true)]
    [string]$contact,
    
    [Parameter(Mandatory=$true)]
    [string]$message,
    
    [string]$image,
    
    [string]$file,
    
    [string]$config = "config.yml"
)

# Load Windows Forms for simulating key presses
Add-Type -AssemblyName System.Windows.Forms

# Load configuration if exists
$defaultContact = $null
if (Test-Path $config) {
    try {
        $configContent = Get-Content $config -Raw | ConvertFrom-Yaml -ErrorAction SilentlyContinue
        if ($configContent.default_contact) {
            $defaultContact = $configContent.default_contact
        }
    } catch {
        # Config loading failed, continue without it
    }
}

Write-Host "WeChat Sender v1.1.0" -ForegroundColor Cyan
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

# Send image if provided
if ($image) {
    Write-Host "Sending image: $image" -ForegroundColor Yellow
    
    if (-not (Test-Path $image)) {
        Write-Host "Error: Image file not found: $image" -ForegroundColor Red
        exit 1
    }
    
    # Copy image to clipboard
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    
    try {
        $bitmap = [System.Drawing.Bitmap]::FromFile($image)
        [System.Windows.Forms.Clipboard]::SetImage($bitmap)
        Start-Sleep -Milliseconds 500
        
        # Paste and send (Ctrl+V then Enter)
        [System.Windows.Forms.SendKeys]::SendWait("^v")
        Start-Sleep -Milliseconds 500
        [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
        Start-Sleep -Milliseconds 500
        
        Write-Host "Image sent successfully!" -ForegroundColor Green
    } catch {
        Write-Host "Error sending image: $_" -ForegroundColor Red
    }
}

# Send file if provided
if ($file) {
    Write-Host "Sending file: $file" -ForegroundColor Yellow
    
    if (-not (Test-Path $file)) {
        Write-Host "Error: File not found: $file" -ForegroundColor Red
        exit 1
    }
    
    # Use Ctrl+A to attach file
    [System.Windows.Forms.SendKeys]::SendWait("^a")
    Start-Sleep -Milliseconds 1000
    
    # Wait for file dialog and input path
    # This is a simplified approach - in production you'd use UI Automation
    Write-Host "Please manually select the file in the dialog" -ForegroundColor Yellow
    [System.Windows.Forms.SendKeys]::SendWait($file)
    Start-Sleep -Milliseconds 500
    [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
    Start-Sleep -Milliseconds 1000
    
    Write-Host "File dialog opened" -ForegroundColor Green
}

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
