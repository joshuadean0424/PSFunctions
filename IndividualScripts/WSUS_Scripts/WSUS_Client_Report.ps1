###Author: Joshua Dean
### Date Created: 1/2/2024
### Script to Force Client to Report to WSUS Server and get more updates



if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) 
{
if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000)
    {Start-Process Powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    Exit;
    }
}

# Find Updates and report to the WSUS Server
$updateSession = new-object -com "Microsoft.Update.Session"; $updates=$updateSession.CreateupdateSearcher().Search($criteria).Updates
Start-sleep -seconds 10
wuauclt /detectnow
wuauclt /reportnow
c:\windows\system32\UsoClient.exe startscan


Read-Host "Hit Enter to Exit"