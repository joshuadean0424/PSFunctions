##Install/Import Powershell Modules
## Joshua Dean IT Infra
## Mobis AL
## Date Creatd: 2/7/2024



if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
$repo = 'PowerShell Repo'

#Install all Neccessary Modules
Install-Module -Name PowerShellGet -Repository $repo -Force
Install-Module -Name PSWindowsUpdate -Repository $repo -Force
Install-Module -Name psTrustedHosts -Repository $repo -Force
Install-Module -Name PoshWSUS -Repository $repo -Force
Install-Module -Name PendingReboot -Repository $repo -Force
#Import all Modules
Import-Module -Name PowerShellGet 
Import-Module -Name PSWindowsUpdate 
Import-Module -Name psTrustedHosts 
Import-Module -Name PoshWSUS 
Import-Module -Name PendingReboot 

Read-Host "All Modules Imported. Hit Enter to Exit"