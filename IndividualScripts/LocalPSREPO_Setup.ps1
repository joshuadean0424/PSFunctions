##Folder Directory Creation

$localPath = D:\Software\LocalPowerShellRepo
New-Item -Path $localPath -ItemType Directory


##SMB Share Creation

$localPath = D:\Software\LocalPowerShellRepo
$smbShare = @{
	Name = 'MALLocalRepo'
	Path = $localPath
	Description = 'MAL Local PS Repository'
	FullAccess = 'Everyone'
}
New-SmbShare $smbShare




##Register Repository

$remotePath = '\\10.37.202.199\Software\LocalPowerShellRepo'
$localPsRepoParam = @{
	Name = 'MALLocalRepo'
	SourceLocation = $remotePath
	PublishLocation = $remotePath
	InstallationPolicy = 'Trusted'
} 
Register-PSRepository @localPsRepoParam

Register-PSRepository -Name MALLocalRepo -SourceLocation '\\10.37.202.199\Software\LocalPowerShellRepo' -PublishLocation '\\10.37.202.199\Software\LocalPowerShellRepo' -InstallationPolicy 'Trusted'

#Create a OSInfo module folder 

New-Item C:\OSInfo -ItemType Directory


#Create a very simple module

$moduleCode = @"
Function Get-OsInfo
{
	Get-CimInstance -ClassName win32_OperatingSystem | Select CSName, Caption, Version, OSArchitecture
}
Set-Alias OSInfo Get-OsInfo
"@ 
$moduleCode | Out-File C:\OSInfo\OSInfo.psm1

#Load and test the OSInfo module

Import-Module -Name C:\OSInfo


#Check whats on MALLocalRepo powershell repository

Find-Module -Repository MALLocalRepo

#Do web request over TLS1.2 and Publish Module on local PSRepository

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Publish-Module -Path D:\Github\PSFunctions -Repository MALLocalRepo -Force


Install-Module -Name ModuleName -Repository Localrepo -Scope CurrentUser


# Publish from the PSGallery to your local Repository
$savePackageSplat = @{
    Name = 'PowerShellGet'
    ProviderName = 'NuGet'
    Source = 'https://www.powershellgallery.com/api/v2'
    Path = 'D:\Software\LocalPowerShellRepo\'
}
Save-Package @savePackageSplat