# --------------------------------------------
# Function Name: p
# Test if a computer is online (quick ping replacement)
# --------------------------------------------
function p{
    param ($COMPUTERNAME)
    return (test-connection $COMPUTERNAME -count 2 -quiet)
    }


# -------------------------------------------
# Function Name: Set-Default
# Set the Execution Policy if not set
# -------------------------------------------
function Set-Default {

  Set-ExecutionPolicy Default -force

}


# -----------------------------------------
# Function Name: Ent-RemSession
# Enters PS Session with computer and credential params
# -----------------------------------------
function Go-PSSess{
    param($ComputerName, [System.Management.Automation.PSCredential]
      $Credential = $(Get-Credential))

    Enter-PSSession -ComputerName $ComputerName -Credential $Credential
    }

# -----------------------------------------
# Function Name: Adm-PSSess
# Enters PS Session with computer parameter and administrator credentials
# -----------------------------------------
   
    function Adm-PSSess{
    param($ComputerName)

    Enter-PSSession -ComputerName $ComputerName -Credential Administrator
    }
   
# -----------------------------------------
# Function Name: MAL-PSSess
# Enters PS Session with computer parameter and malsvradm credentials
# -----------------------------------------
   
    function MAL-PSSess{
    param($ComputerName)

    Enter-PSSession -ComputerName $ComputerName -Credential malsvradm
    }
   

# -------------------------------------
#Function Name: Get-UpTime
# Gets uptime of localhost
# -------------------------------------
  function Get-UpTime{
     (Get-Date) - [Management.ManagementDateTimeConverter]::ToDateTime((Get-WmiObject Win32_OperatingSystem -ComputerName localhost).LastBootUpTime)
     }


     ##---------------------------
##Function Import-MyModules
##This imports all modules from Local PowerShell Repository
##Author: Joshua Dean
##Company: Mobis AL
##---------------------------
function Import-MyModules {
  Import-Module PSFunctions -Verbose -Force
  Import-Module psTrustedHosts -Force
  Import-Module PoshWSUS -Force
  Import-Module PSWindowsUpdate -force
  Import-Module PowerShellGet -force    
} 

function Install-MyModules {
  Install-Module PSFunctions -Verbose -Force
  Install-Module psTrustedHosts -Force
  Install-Module PoshWSUS -Force
  Install-Module PSWindowsUpdate -force
  Install-Module PowerShellGet -force    
} 


