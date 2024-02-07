if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

Import-Module PSFunctions -Verbose -Force
Import-Module psTrustedHosts -Force
Import-Module PoshWSUS -Force
Import-Module PSWindowsUpdate -Force
Import-Module PowerShellGet -Force
Import-Module PendingReboot -Force


Start-Transcript "D:\GitHub\transcript\transcript0.txt" -Append
cd C:\
cls