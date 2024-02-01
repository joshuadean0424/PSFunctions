###Author: Joshua Dean
### Date Created: 11/25/2023
### Script to Add Registry settings to client for the WSUS Server (10.37.202.201)



if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) 
{
if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000)
    {Start-Process Powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    Exit;
    }
}


# Variables
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
$name1 = "WUServer"
$value1 = "http://10.37.202.201:8530"
$name2 = "WUStatusServer"
$value2 = "http://10.37.202.201:8530"
$name3 = "DoNotConnectToWindowsUpdateInternetLocations"
$value3 = "1"
$name4 = "TargetGroupEnabled"
$value4 = "1"
$registryPathAU = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
$nameAU1 = "AUOptions"
$valueAU1 = "4"
$nameAU2 = "UseWUServer"
$valueAU2 = "1"
$nameAU3 = "AUPowerManagement"
$valueAU3 = "1"
$nameAU4 = "AutoInstalledMinorUpdates"
$valueAU4 = "1"
$nameAU5 = "DetectionFrequency"
$valueAU5 = "a"
$nameAU6 = "DetectionFrequencyEnabled"
$valueAU6 = "1"
$nameAU7 = "IncludeRecommendedUpdates"
$valueAU7 = "1"
$nameAU8 = "NoAUAsDefaultShutdownOption"
$valueAU8 = "1"
$nameAU9 = "NoAutoRebootWithLoggedOnUsers"
$valueAU9 = "1"
$nameAU10 = "NoAutoUpdate"
$valueAU10 = "0"
$nameAU11 = "RebootRelaunchTimeout"
$valueAU11 = "a"
$nameAU12 = "RebootRelaunchTimeoutEnabled"
$valueAU12 = "1"
$nameAU13 = "RescheduleWaitTime"
$valueAU13 = "a"
$nameAU14 = "RescheduleWaitTimeEnabled"
$valueAU14 = "1"
$nameAU15 = "ScheduledInstallDay"
$valueAU15 = "0"
$nameAU16 = "ScheduledInstallTime"
$valueAU16 = "0"









# Stop Windows Update Service
Stop-Service -Name wuauserv
Write-Host "Windows Update Service Successfully Stopped."



# Inject registry
IF(!(Test-Path $registryPath))
{
    New-Item -Path $registryPath -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name1 -Value $value1 -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name2 -Value $value2 -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name3 -Value $value3 -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name4 -Value $value4 -PropertyType DWORD -Force | Out-Null
}
ELSE
{
    New-ItemProperty -Path $registryPath -Name $name1 -Value $value1 -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name2 -Value $value2 -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name3 -Value $value3 -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name4 -Value $value4 -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path $registryPath -Name $name5 -Value $value5 -PropertyType DWORD -Force | Out-Null
}
IF(!(Test-Path $registryPathAU))
{
    New-Item -Path $registryPathAU -Force | Out-Null
    New-ItemProperty -Path $registryPathAU -Name $nameAU1 -Value $valueAU1 -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path $registryPathAU -Name $nameAU2 -Value $valueAU2 -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path $registryPathAU -Name $nameAU3 -Value $valueAU3 -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path $registryPathAU -Name $nameAU4 -Value $valueAU4 -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path $registryPathAU -Name $nameAU5 -Value $valueAU5 -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path $registryPathAU -Name $nameAU6 -Value $valueAU6 -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path $registryPathAU -Name $nameAU7 -Value $valueAU7 -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path $registryPathAU -Name $nameAU8 -Value $valueAU8 -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path $registryPathAU -Name $nameAU9 -Value $valueAU9 -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path $registryPathAU -Name $nameAU10 -Value $valueAU10 -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path $registryPathAU -Name $nameAU11 -Value $valueAU11 -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path $registryPathAU -Name $nameAU12 -Value $valueAU12 -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path $registryPathAU -Name $nameAU13 -Value $valueAU13 -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path $registryPathAU -Name $nameAU14 -Value $valueAU14 -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path $registryPathAU -Name $nameAU15 -Value $valueAU15 -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path $registryPathAU -Name $nameAU16 -Value $valueAU16 -PropertyType DWORD -Force | Out-Null
    }
ELSE
{
    New-ItemProperty -Path $registryPathAU -Name $nameAU1 -Value $valueAU1 -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path $registryPathAU -Name $nameAU2 -Value $valueAU2 -PropertyType DWORD -Force | Out-Null
}


# Restart Windows Update
Read-Host "Hit Enter to Restart Windows Update Service"
Start-Service -Name wuauserv
Write-Host "Windows Update Service Successfuly Restarted."

# Find Updates and report to the WSUS Server
$updateSession = new-object -com "Microsoft.Update.Session"; $updates=$updateSession.CreateupdateSearcher().Search($criteria).Updates
Start-sleep -seconds 10
wuauclt /detectnow
wuauclt /reportnow



Read-Host "Hit Enter to Exit"