<#
.SYNOPSIS
    This PowerShell script ensures the built-in guest account is renamed..

.NOTES
    Author          : NormanRomney
    LinkedIn        : linkedin.com/in/normanromney/
    GitHub          : github.com/normanromney
    Date Created    : 2026-06-16
    Last Modified   : 2026-06-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-SO-000025
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-SO-000025/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-SO-000025.ps1 
#>

# Run as Administrator

$NewGuestName = "DisabledGuest"

# Get the built-in Guest account by SID ending in -501
$GuestAccount = Get-LocalUser |
    Where-Object {
        $_.SID.Value -match '-501$'
    }

if (-not $GuestAccount) {
    throw "Built-in Guest account not found."
}

# Rename the account if necessary
if ($GuestAccount.Name -ne $NewGuestName) {
    Rename-LocalUser -Name $GuestAccount.Name -NewName $NewGuestName
    Write-Host "Guest account renamed to '$NewGuestName'."
}
else {
    Write-Host "Guest account is already named '$NewGuestName'."
}
