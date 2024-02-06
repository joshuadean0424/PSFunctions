###Author: Joshua Dean
### Date Created: 02/06/2024
### Script to Add Registry settings to client for the NTP Server (10.37.202.199)



if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) 
{
if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000)
    {Start-Process Powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    Exit;
    }
}


## GPEdit.msc 
## Computer Configuration -> Administrative Templates -> System -> Windows Time Service -> Time Providers
##  Configure Windows Client 
    ## NtpServer: 10.37.202.199,0x8
    ## Type: NTP
    ## CrossSiteSync Flags: 0
    ## ResolvePeerBackOffMinutes: 1
    ## ResolvePeerBackOff Max Times: 7
    ## SpecialPollInterval: 1024
    ## EventLogFlags: 3
## Enable Windows NTP CLient

## w32tm.exe /config /update
## w32tm.exe /resync /rediscover
## w32tm.exe /unregister
## w32tm.exe /register

## Variables
$registryPath1 = "HKLM:SYSTEM\CurrentControlSet\Services\w32time\Parameters"
$registryPath2 = "HKLM:System\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient"
$registryPath3 = "HKLM:SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\VMICTimeProvider"
$ParamName1 = "Type"
$ParamName2 = "NtpServer"
$name1 = "SpecialPollInterval"
$name2 = "MaxPosPhaseCorrection"
$name3 = "MaxNegPhaseCorrection"
$name4 = "EventLogFlags"
$name5 = "CrossSiteSyncFlags"
$value = "600"
$value2 = "0"
$value3 = "3"
$ParamValue1 = "NTP"
$ParamValue2 = "10.37.202.199,0x8"
$VMICName = "Enabled"



net Stop w32time 

## Virtual Machine Registry Injection (Verfies it pulls Time from NTP not Host Server)
Set-ItemProperty -Path $registryPath3 -Name $VMICName -Value $value2 -Force | Out-Null

## NTP Client Registry Injection
Set-ItemProperty -Path $registryPath1 -Name $ParamName1 -Value $ParamValue1 -Force | Out-Null
Set-ItemProperty -Path $registryPath1 -Name $ParamName2 -Value $ParamValue2 -Force | Out-Null
Set-ItemProperty -Path $registryPath2 -Name $name1 -Value $value -Force | Out-Null
Set-ItemProperty -Path $registryPath2 -Name $name2 -Value $value -Force | Out-Null
Set-ItemProperty -Path $registryPath2 -Name $name3 -Value $value -Force | Out-Null
Set-ItemProperty -Path $registryPath2 -Name $name4 -Value $value3 -Force | Out-Null
Set-ItemProperty -Path $registryPath2 -Name $name5 -Value $value2 -Force | Out-Null
Write-Host "Registry Files Added."
Net Start w32time
Read-Host "Hit Enter to Check New NTP Client Config"


w32tm.exe /query /peers
w32tm.exe /query /source
w32tm.exe /query /status
Read-Host "Hit Enter to Exit"