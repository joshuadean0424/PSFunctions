if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

##---------------------------
##Function Install-MyModules
##This imports all modules from Local PowerShell Repository
##Author: Joshua Dean
##Company: Mobis AL
##---------------------------

Get-PSRepository

function Install-MyModules {
    Install-Module PSFunctions -Verbose -Force
    Install-Module psTrustedHosts -Force
    Install-Module PoshWSUS -Force
    Install-Module PSWindowsUpdate -force
    Install-Module PowerShellGet -force    
} 
##---------------------------
##Function Import-MyModules
##This imports all modules from Local PowerShell Repository
##Author: Joshua Dean
##Company: Mobis AL
##---------------------------
function Import-MyModules {
    Import-Module PSFunctions -Verbose -Force
    Import-Module psTrustedHosts -Force
    Import-Module PoshWSUS -Force
    Import-Module PSWindowsUpdate -force
    Import-Module PowerShellGet -force    
} 