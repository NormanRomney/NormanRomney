<#
.SYNOPSIS
    This PowerShell script ensures that the Windows Installer feature "Always install with elevated privileges" is disabled..

.NOTES
    Author          : Norman Romney
    LinkedIn        : linkedin.com/in/normanromney/
    GitHub          : github.com/normanromney
    Date Created    : 2026-06-17
    Last Modified   : 2026-06-17
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000315
    Documentation   : hhttps://stigaview.com/products/win11/v2r7/WN11-CC-000315/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000315.ps1 
#>

# Configure "Always install with elevated privileges" to Disabled

$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer'
$ValueName = 'AlwaysInstallElevated'
$ValueData = 0

# Create the registry path if it does not exist
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Set the policy value
New-ItemProperty `
    -Path $RegistryPath `
    -Name $ValueName `
    -PropertyType DWord `
    -Value $ValueData `
    -Force | Out-Null

Write-Host "'Always install with elevated privileges' has been configured to Disabled."
