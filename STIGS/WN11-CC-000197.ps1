<#
.SYNOPSIS
    This PowerShell script ensures that Microsoft consumer experiences are turned off.
.

.NOTES
    Author          : Norman Romney
    LinkedIn        : linkedin.com/in/normanromney/
    GitHub          : github.com/normanromney
    Date Created    : 2026-06-16
    Last Modified   : 2026-06-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000197
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000197/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN11-CC-000197.ps1 
#>

Configure "Turn off Microsoft consumer experiences" = Enabled

$Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent'
$Name = 'DisableWindowsConsumerFeatures'
$Value = 1

# Create the key if it does not exist
if (-not (Test-Path $Path)) {
    New-Item -Path $Path -Force | Out-Null
}

# Set the policy value
New-ItemProperty -Path $Path `
    -Name $Name `
    -PropertyType DWord `
    -Value $Value `
    -Force | Out-Null

Write-Host "'Turn off Microsoft consumer experiences' has been set to Enabled."
