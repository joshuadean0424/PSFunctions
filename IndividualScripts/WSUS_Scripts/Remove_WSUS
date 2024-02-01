if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) 
{
if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000)
    {Start-Process Powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    Exit;
    }
}

Stop-Service -Name wuauserv
Write-Host "Windows Update Service Stopped"
Remove-Item HKLM: \Software\Policies\Microsoft\Windows\WindowsUpdate -Recurse
Write-Host "Removed WSUS Registry Key"
Read-Host "Hit Enter to Exit"