###Author: Joshua Dean
### Date Created: 2/8/2024
### Script to Weekly Synchronize WSUS instead of daily



if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) 
{
if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000)
    {Start-Process Powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    Exit;
    }
}


$wsusserver = 10.37.202.201
[reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration") | out-null
$wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer($wsusserver, $False,8530);
$wsus.GetSubscription().StartSynchronization();

