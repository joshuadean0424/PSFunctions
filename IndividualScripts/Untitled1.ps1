##View All Powershell Drives 
Get-PSDrive


##Force Install NuGet
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

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

