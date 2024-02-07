##Steps to use to setup Powershell Modules
## Joshua Dean IT Infra
## Mobis AL
## Date Creatd: 2/7/2024


if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

#Variables & Functions
$DirectPath = 'C:\Users\Administrator\Documents'
$localPath = 'C:\Users\Administrator\Documents\Powershell Repo'
$localparam = @{
	Name = 'PowerShell Repo'
	SourceLocation = $localPath
	PublishLocation = $localPath
	InstallationPolicy = 'Trusted'
} 





#Create Folder Directory for Powershell Modules stored locally
New-Item -Path $DirectPath -Name "Powershell Repo" -ItemType "directory"




# Unregister all Previous PS Repos and Registering the new one via @localparam function
Get-PSRepository | Unregister-PSRepository
Register-PSRepository @localparam
Get-PSRepository

Read-Host "PowerShell Repo Created. Hit Enter to Exit"
