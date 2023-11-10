<#

.SYNOPSIS

Install Fonts on users devices

.DESCRIPTION

Below script will Install all fonts copied inside Fonts directory to a target device

.NOTES

PowerShell Script for Font Installation on Windows Devices

.AUTHOR

Prajwal Desai

.DATE CREATED

15-November-2023

Blog : https://www.prajwaldesai.com

#>

#Define the Font Directory (This is a shared folder where you have placed the fonts for installation)

$FontDir = "\\corpcm\Sources\scripts\Fonts"

#Create a folder and copy fonts

New-Item -ItemType "directory" -Path $FontDir -Force
Copy-Item -Path ".\Fonts\*" -Destination $FontDir -Recurse

#Get all fonts from the font directory (.TTF and .OTF)

$GetFonts = Get-ChildItem -Path "$FontDir\*.ttf"
$GetFonts += Get-ChildItem -Path "$FontDir\*.otf"

#Register the fonts from the Font Directory

foreach($FontFile in $GetFonts){
    
        Copy-Item -Path "$FontDir\$($FontFile.Name)" -Destination "$env:windir\Fonts" -Force
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" -Name $FontFile.Name -PropertyType String -Value $FontFile.Name -Force
    }
    Write-Host "Fonts installed successfully!"


# Restart the Windows Explorer process to apply font changes
Stop-Process -Name explorer -Force
Start-Process explorer

