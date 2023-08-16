####---------------------
####Get-GUIService
#### See Services in GUI and choose which ones to print to txt file
####---------------------
function Get-ServiceTXT {
    Get-Service | Out-GridView -PassThru | Out-File C:\Files\services.txt
}




function Remove-OldModules
{
  <#
<#
    Author: Luke Murray (Luke.Geek.NZ)
    Version: 0.1
    Purpose: Basic function to remove old PowerShell modules which are installed
#>

  #>
  $Latest = Get-InstalledModule 
  foreach ($module in $Latest) { 
    
    Write-Verbose -Message "Uninstalling old versions of $($module.Name) [latest is $( $module.Version)]" -Verbose
    Get-InstalledModule -Name $module.Name -AllVersions | Where-Object {$_.Version -ne $module.Version} | Uninstall-Module -Verbose 
  }
}

Remove-OldModules