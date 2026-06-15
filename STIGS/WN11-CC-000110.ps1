<#
.SYNOPSIS
    This PowerShell script prevents printing over HTTP.

.NOTES
    Author          : Norman Romney
    LinkedIn        : linkedin.com/in/normanromney/
    GitHub          : github.com/normanromney
    Date Created    : 2026-06-15
    Last Modified   : 2026-06-15
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000110
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000110/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000110.ps1 
#>


$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers'
$ValueName = 'DisableHTTPPrinting'
$ValueData = 1

# Create the registry key if it does not exist
if (-not (Test-Path -Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Configure the policy
New-ItemProperty `
    -Path $RegistryPath `
    -Name $ValueName `
    -Value $ValueData `
    -PropertyType DWord `
    -Force | Out-Null

Write-Output 'Turn off printing over HTTP has been enabled.'
