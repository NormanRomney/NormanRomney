<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Norman Romney
    LinkedIn        : https://www.linkedin.com/in/normanromney/
    GitHub          : github.com/normanromney
    Date Created    : 2026-06-14
    Last Modified   : 2026-06-14
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000500
    Documentation   : https://stigaview.com/products/win11/v1r5/WN11-AU-000500/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-AU-000500.ps1 
#>


$Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application'

# Create the key if it does not exist
New-Item -Path $Path -Force | Out-Null

# Set MaxSize to 0x8000 (32768 decimal)
New-ItemProperty `
    -Path $Path `
    -Name 'MaxSize' `
    -Value 0x8000 `
    -PropertyType DWord `
    -Force | Out-Null
