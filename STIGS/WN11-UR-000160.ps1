<#
.SYNOPSIS
    This PowerShell script ensures the "Restore files and directories" user right are only assigned to the Administrators group..

.NOTES
    Author          : Norman Romney
    LinkedIn        : linkedin.com/in/normanromney/
    GitHub          : github.com/normanromney
    Date Created    : 2026-06-16
    Last Modified   : 2026-06-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-UR-000160
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-UR-000160/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-UR-000160.ps1 
#>

# Ensure the script is running elevated
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator))
{
    throw "This script must be run as Administrator."
}

$tempInf = Join-Path $env:TEMP "UserRights.inf"
$tempDb  = Join-Path $env:TEMP "UserRights.sdb"

try {
    # Export current security policy
    secedit /export /cfg $tempInf | Out-Null

    # Read configuration
    $content = Get-Content $tempInf

    # Replace or add SeRestorePrivilege assignment
    $settingFound = $false

    $content = $content | ForEach-Object {
        if ($_ -match '^SeRestorePrivilege\s*=') {
            $settingFound = $true
            'SeRestorePrivilege = *S-1-5-32-544'
        }
        else {
            $_
        }
    }

    if (-not $settingFound) {
        $privilegeIndex = $content.IndexOf('[Privilege Rights]')

        if ($privilegeIndex -ge 0) {
            $before = $content[0..$privilegeIndex]
            $after  = $content[($privilegeIndex + 1)..($content.Count - 1)]

            $content = @(
                $before
                'SeRestorePrivilege = *S-1-5-32-544'
                $after
            )
        }
        else {
            throw "Unable to locate [Privilege Rights] section."
        }
    }

    # Save modified configuration
    Set-Content -Path $tempInf -Value $content -Encoding Unicode

    # Apply configuration
    secedit /configure /db $tempDb /cfg $tempInf /areas USER_RIGHTS | Out-Null

    # Refresh policy
    gpupdate /target:computer /force | Out-Null

    Write-Host "Successfully configured 'Restore files and directories' to Administrators only."
}
finally {
    Remove-Item $tempInf -ErrorAction SilentlyContinue
    Remove-Item $tempDb  -ErrorAction SilentlyContinue
}
