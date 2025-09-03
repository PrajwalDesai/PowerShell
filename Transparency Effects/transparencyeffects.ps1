<#
.SYNOPSIS
PowerShell Script to Enable or Disable Transparency Effects in Windows 11

.DESCRIPTION 
This script modifies the registry key responsible for transparency settings and refreshes the user interface to apply changes.

.NOTES
Author: Prajwal Desai
Website: https://www.prajwaldesai.com
Post Link: https://www.prajwaldesai.com/enable-disable-transparency-effects-in-windows-11
#>


param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("Enable", "Disable")]
    [string]$Action
)

# Registry path for Transparency Effects
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
$regName = "EnableTransparency"

try {
    if ($Action -eq "Enable") {
        # Set transparency effects to enabled
        Set-ItemProperty -Path $regPath -Name $regName -Value 1
        Write-Host "Transparency Effects have been enabled." -ForegroundColor Green
    } elseif ($Action -eq "Disable") {
        # Set transparency effects to disabled
        Set-ItemProperty -Path $regPath -Name $regName -Value 0
        Write-Host "Transparency Effects have been disabled." -ForegroundColor Yellow
    }

    # Refresh user interface to apply changes
    rundll32.exe user32.dll, UpdatePerUserSystemParameters
} catch {
    Write-Host "An error occurred while modifying Transparency Effects settings: $_" -ForegroundColor Red

}
