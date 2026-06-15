<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Syestem event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Norman Romney
    LinkedIn        : linkedin.com/in/normanromney/
    GitHub          : github.com/normanromney
    Date Created    : 2026-06-14
    Last Modified   : 2026-06-14
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000510
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-AU-000510/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-AU-000510.ps1 
#>

# Ensure the policy registry path exists
$Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\System'

if (-not (Test-Path $Path)) {
    New-Item -Path $Path -Force | Out-Null
}

# Set maximum log size to 32,768 KB (32 MB)
New-ItemProperty `
    -Path $Path `
    -Name 'MaxSize' `
    -PropertyType DWord `
    -Value 32768 `
    -Force | Out-Null
