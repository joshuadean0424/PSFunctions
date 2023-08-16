##Steps to use to setup Powershell Modules
## Joshua Dean
## Mobis AL

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
$remotePath = '\\10.37.202.199\Software\LocalPowerShellRepo'
$localparam = @{
	Name = 'MALLocalRepo'
	SourceLocation = $remotePath
	PublishLocation = $remotePath
	InstallationPolicy = 'Trusted'
} 
Unregister-PSRepository PSGallery
Register-PSRepository @localparam

Set-ExecutionPolicy Bypass
##If Execution Policy is set to "Machine Policy AllSigned" via Group Policy go to GPedit and change via
## Computer Configuration -> Administrative Templates -> Windows Components -> Windows PowerShell
Import-Module PowerShellGet
Get-PSRepository
Install-Module -Name PSFunctions -RequiredVersion "4.0"

Install-MyModules
Import-MyModules
Set-Default
Clear-Host
Write-Host "All Modules Installed and Imported."

Set-ExectionPolicy -Scope LocalMachine -ExecutionPolicy RemoteSigned
Set-ExectionPolicy -Scope LocalMachine, CurrentUser -ExecutionPolicy RemoteSigned