#add server to trusted hosts
Get-ChildItem WSMan:\localhost\Client\TrustedHosts
winrm s winrm/config/client '@{TrustedHosts="673448-RAXDC01"}'
winrm s winrm/config/client '@{TrustedHosts="579188-HYP1"}'
##Single Server
winrm set winrm/config/client ‘@{TrustedHosts="machineA"}’

#domain to domain (http)
New-PSSession -ComputerName Test-Join -Credential domain\user
$domainToDomainHTTP = New-PSSession -ComputerName RemoteDeviceName -Credential domain\account

#domain to domain (requires https listener and certificates pre-configured)
New-PSSession -ComputerName Test-Join -Credential domain\user -UseSSL
$domainToDomainHTTPS = New-PSSession -ComputerName PDC2 -Credential domain\account -UseSSL

#by IP self-signed cert
$so = New-PSSessionOption -SkipCNCheck -SkipCACheck -SkipRevocationCheck
$test = New-PSSession -ComputerName 10.0.3.27 -Credential $cred -UseSSL -SessionOption $so

#change port WinRM listens on
winrm/config/Listener?Address=*+Transport=HTTP '@{Port="8888"}'

#check WinRM settings
Get-WSManInstance -ResourceURI winrm/config/service/Auth
Get-WSManInstance -ResourceURI winrm/config/client/Auth
Get-WSManInstance -ResourceURI winrm/config/client
winrm get winrm/config/service
winrm get winrm/config/client


#Test Connection 
Test-NetConnection -ComputerName 10.37.202.201 -Port 5985
Test-WSMan 10.37.201.21 -Authentication Negotiate -Credential $cred
Get-NetTCPConnection -LocalPort 5985


#Basic PS Sessions
## To enter a direct session with a remote computer
Enter-PSSession -ComputerName RemoteDeviceName -Credential domain\user

## To attach a session to a variable for invoke command use
$cred = get-credential
$session = New-PSSession -ComputerName 10.37.202.202 -Credential $cred
$2devices = Get-Content -Path 'C:\Users\Mobis Alabama\Documents\Dean Powershell Repository\serversTest.txt' 
$multisession = New-PSSession -ComputerName $2devices -Credential $cred



## Invoke Command to get Memory Usage from Remote Session
Invoke-Command -Session $Session -ScriptBlock 
{
    $CompObject =  Get-WmiObject -Class WIN32_OperatingSystem
    $Memory = ((($CompObject.TotalVisibleMemorySize - $CompObject.FreePhysicalMemory)*100)/ $CompObject.TotalVisibleMemorySize)
    Write-Host "Memory usage in Percentage:" $Memory
}



##Get Memory Usage as a Percentage
{
    $CompObject =  Get-WmiObject -Class WIN32_OperatingSystem
    $Memory = ((($CompObject.TotalVisibleMemorySize - $CompObject.FreePhysicalMemory)*100)/ $CompObject.TotalVisibleMemorySize)
 
    Write-Host "Memory usage in Percentage:" $Memory
}


$session = New-PSSession -ComputerName 10.37.202.202 -Credential $cred
Invoke-Command -Session $session -ScriptBlock {Get-PSrepository}