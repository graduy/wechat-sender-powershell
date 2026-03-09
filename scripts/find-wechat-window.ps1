Add-Type -AssemblyName System.Windows.Forms
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Win32 {
    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    [DllImport("user32.dll")]
    public static extern bool SetForegroundWindow(IntPtr hWnd);
    [DllImport("user32.dll")]
    public static extern bool IsIconic(IntPtr hWnd);
    [DllImport("user32.dll", CharSet = CharSet.Unicode)]
    public static extern int GetWindowText(IntPtr hWnd, System.Text.StringBuilder lpString, int nMaxCount);
    [DllImport("user32.dll")]
    public static extern IntPtr GetWindowThreadProcessId(IntPtr hWnd, out int lpdwProcessId);
}
"@

function Get-WindowTitle {
    param([IntPtr]$hWnd)
    $sb = New-Object System.Text.StringBuilder 256
    [Win32]::GetWindowText($hWnd, $sb, 256) | Out-Null
    return $sb.ToString()
}

Write-Host "Searching all WeChat windows..." -ForegroundColor Cyan
Write-Host "━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan

$allWindows = Get-Process | ForEach-Object {
    $proc = $_
    try {
        if ($proc.MainWindowHandle -ne [IntPtr]::Zero) {
            [PSCustomObject]@{
                Process = $proc.Name
                PID = $proc.Id
                Handle = $proc.MainWindowHandle
                Title = (Get-WindowTitle $proc.MainWindowHandle)
            }
        }
    } catch {}
} | Where-Object {$_.Process -like "*WeChat*" -or $_.Title -like "*微信*" -or $_.Title -like "*WeChat*"}

$allWindows | Format-Table -AutoSize

Write-Host "`nTotal windows found: $($allWindows.Count)" -ForegroundColor Yellow
