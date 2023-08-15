if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

Import-Module psTrustedHosts -Force
Import-Module PoshWSUS -Force
Import-Module PSWindowsUpdate -force
Import-Module PowerShellGet -force

Import-Module Y:\PSModules\JDean.psm1 -Verbose

Start-Transcript "D:\Powershell\transcript\transcript0.txt" -Append
cd C:\
cls