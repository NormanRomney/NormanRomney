<#
.SYNOPSIS
    This PowerShell script configures Windows Game Recording and Broadcasting to disabled.

.NOTES
    Author          : Norman Romney
    LinkedIn        : linkedin.com/in/normanroney/
    GitHub          : github.com/normanromney
    Date Created    : 2026-06-14
    Last Modified   : 2026-06-14
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000252
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000252/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN11-CC-000252.ps1 
#>

# Ensure the policy registry path exists
$Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR'

if (-not (Test-Path $Path)) {
    New-Item -Path $Path -Force | Out-Null
}

# Disable Windows Game Recording and Broadcasting
New-ItemProperty `
    -Path $Path `
    -Name 'AllowGameDVR' `
    -PropertyType DWord `
    -Value 0 `
    -Force | Out-Null
