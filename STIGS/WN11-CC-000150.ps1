<#
.SYNOPSIS
    This PowerShell script ensures that the user must be prompted for a password on resume from sleep (plugged in).
.

.NOTES
    Author          : Norman Romney
    LinkedIn        : linkedin.com/in/normanromney/
    GitHub          : github.com/normanromney
    Date Created    : 2026-06-17
    Last Modified   : 2026-06-17
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000150 
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000150/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000150.ps1 
#>

# Require a password when a computer wakes (plugged in)
$RegPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51'

# Create the registry key if it does not exist
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Enable the policy
New-ItemProperty `
    -Path $RegPath `
    -Name 'ACSettingIndex' `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null

Write-Host "Require a password when a computer wakes (plugged in) has been enabled."
