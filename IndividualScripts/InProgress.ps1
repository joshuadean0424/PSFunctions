#### Create-HVM
#### Creates Basic Hyper-V VM
#### Author: Joshua Dean
#### Company: Mobis AL
#### Date last updated: 8/21/2023
function Register-HyVM {
  param($computername, 
  [System.Management.Automation.PSCredential]$Credential = $(Get-Credential))
  
  Invoke-Command -ComputerName $computername -Credential $Credential -ScriptBlock {

    New-VM -Name  -MemoryStartupBytes 512MB -Path "D:\Hyper-V\VMs\"
    New-VHD
  }
}


#### Create-HVM
#### Creates Basic Hyper-V VM
#### Author: Joshua Dean
#### Company: Mobis AL
#### Date last updated: 8/21/2023
function Remove-HyperVM {
param ($VMname)


}















####---------------------
####Get-GUIService
#### See Services in GUI and choose which ones to print to txt file
####---------------------
function Get-ServiceTXT {
  Get-Service | Out-GridView -PassThru | Out-File C:\Files\services.txt
}
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
$RestartTime = 


##Trusted Hosts all servers array
$array1 = @(10.37.201.22, 10.37.201.52, 10.37.0201.118, 10.37.202.23, 10.37.202.62, 10.37.202.100, 10.37.202.105, 10.37.202.199, 10.37.202.202, 10.37.202.229, 10.37.202.232, 10.37.202.233, 10.37.202.240, 10.37.203.24, 10.37.203.98, 10.37.203.250)

Add-TrustedHost 10.37.201.22, 10.37.201.52, 10.37.201.118, 10.37.202.23, 10.37.202.62, 10.37.202.100, 10.37.202.105, 10.37.202.199, 10.37.202.202, 10.37.202.229, 10.37.202.232, 10.37.202.233, 10.37.202.240, 10.37.203.24, 10.37.203.98, 10.37.203.250, 10.37.201.117