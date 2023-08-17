####---------------------
####Get-GUIService
#### See Services in GUI and choose which ones to print to txt file
####---------------------
function Get-ServiceTXT {
    Get-Service | Out-GridView -PassThru | Out-File C:\Files\services.txt
}
##-----------------------------------------------------------------------------



##-----------------------------------------------------------------------------
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
##-----------------------------------------------------------------------------


##-----------------------------------------------------------------------------
##Installs Updates when in a PowerShell Remote Session
Get-WUHistory
function Install-MyUpdates {
  # Parameter help description
  param( $computername )

  invoke-WUJob -ComputerName $computername -Script 
  { 
      Install-WindowsUpdate -AcceptAll -SendReport -IgnoreReboot 
  } 
  -Confirm:$false -verbose -RunNow
}
##-----------------------------------------------------------------------------

##-----------------------------------------------------------------------------
##View All Powershell Drives 
Get-PSDrive
##-----------------------------------------------------------------------------


##-----------------------------------------------------------------------------
##Force Install NuGet
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
##-----------------------------------------------------------------------------


# --------------------------------------------
# Function Name: Get-LoggedIn
# Return the current logged-in user of a remote machine
# --------------------------------------------
function Get-LoggedIn {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string[]]$COMPUTERNAME
    )

    foreach ($pc in $COMPUTERNAME){
    $logged_in = (gwmi win32_computersystem -ComputerName $pc).username
    $name = $logged_in.split("\")[1]
    "{0}: {1}" -f $pc, $name
    }
}

##-----------------------------------------------------------------------------