# Define paths
$sourcePath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Work Resources (RADC)"
$destPath = "$env:USERPROFILE\Desktop"
$logFile = "$env:TEMP\RemoteAppSync.log"

# Function to check if RemoteApp login is active
function Test-RemoteAppLogin {
    $session = Get-WmiObject -Namespace "root\CIMV2\TerminalServices" -Class Win32_TSPublishedApplication | Where-Object { $_.Name -like "*Work Resources*" }
    return $session -ne $null
}

# Refresh RemoteApps
function Refresh-RemoteApps {
    Write-Output "Refreshing RemoteApps..." | Out-File -Append $logFile
    rundll32 tsworkspace,RefreshWorkspace
    Start-Sleep -Seconds 5
}

# Log start
Write-Output "`n[$(Get-Date)] Running RemoteApp Sync" | Out-File -Append $logFile

# Check RemoteApp login
if (Test-RemoteAppLogin) {
    Write-Output "User is logged into RemoteApps." | Out-File -Append $logFile

    # Ensure source directory exists
    if (Test-Path -Path $sourcePath) {
        # Copy shortcuts to desktop, overwriting existing files
        Copy-Item "$sourcePath\*" -Destination $destPath -Recurse -Force
        Write-Output "RemoteApp shortcuts synced successfully." | Out-File -Append $logFile
    } else {
        Write-Output "RemoteApp shortcuts source path does not exist: $sourcePath" | Out-File -Append $logFile
    }

    # Refresh RemoteApps
    Refresh-RemoteApps

} else {
    Write-Output "User is NOT logged into RemoteApps!" | Out-File -Append $logFile
    # Show alert to the user
    [System.Windows.MessageBox]::Show("Your RemoteApp login has failed. Please check your credentials and try again.", "RemoteApp Sync Error", 0, 16)
}

Write-Output "RemoteApp Sync Completed." | Out-File -Append $logFile
