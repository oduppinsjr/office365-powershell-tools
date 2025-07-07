$workspace = "$($env:LOCALAPPDATA)\Sabre Red Workspace\sabrered.exe"
$uninstaller = "$($env:LOCALAPPDATA)\Sabre Red Workspace\Uninstall Sabre Red Workspace.exe"
$360 = "$($env:LOCALAPPDATA)\Sabre Red 360\sabrered.exe"

if (Test-Path $workspace) {
    Write-Host "Sabre Red Workspace (legacy) is Installed"
    Write-Host 'Deleting desktop shortcut...' -ForegroundColor Green
    $DesktopPath = [Environment]::GetFolderPath("Desktop")
    if (Test-Path "$DesktopPath\Sabre Red Workspace.lnk"){
        Remove-Item "$DesktopPath\Sabre Red Workspace.lnk" -Force -Verbose
    } 
    else { 
        $WScript = New-Object -ComObject WScript.Shell
        $ShortcutsToDelete = Get-ChildItem -Path $DesktopPath -Filter "*.lnk" -Recurse | 
            ForEach-Object { 
                $WScript.CreateShortcut($_.FullName) | 
                    Where-Object TargetPath -eq $workspace
            }
        $ShortcutsToDelete | ForEach-Object {
            Remove-Item -Path $_.FullName
        }
    }
    # kill sabrered process
    $sabrered = Get-Process sabrered
    if ($sabrered) {
        # try gracefully first
        $sabrered.CloseMainWindow() | Out-Null
        # kill after five seconds
        Sleep 5
        if (!$sabrered.HasExited) {
        $sabrered | Stop-Process -Force
        }
    }
    Remove-Variable sabrered
    Write-Host "Uninstalling Sabre Red Workspace (legacy app)"
    Start-Process -Wait -FilePath $uninstaller -ArgumentList "/S /D=$($env:LOCALAPPDATA)\Sabre Red Workspace\" -PassThru
}
if (Test-Path $360) {
Write-Host "Sabre Red 360 is installed"
    exit 0
}
else {
    Write-Host "Sabre Red 360 is not installed"
    exit 1
}