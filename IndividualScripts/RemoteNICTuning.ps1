##-----------------------------------------------------------------------------
####---------------------
####Disconnect-RemoteNIC
####Remotely invoke command to disable Nic Team named network adaptor
####---------------------------------------------------------------------------
function Disconnect-RemoteNIC {
    Param($computername, [System.Management.Automation.PSCredential]
    $Credential = $(Get-Credential))
    
    Invoke-Command -ComputerName $computername -Credential $Credential -ScriptBlock{
      Disable-NetAdapter -Name "Embedded FlexibleLOM 1 Port 4" -Confirm:$false
     ##Change Adapter Name could be NICTeam or NICTeam1 or VEthernet (Virtual Switch)
    }
  }
  
  ##-----------------------------------------------------------------------------
  ####---------------------
  ####Connect-RemoteNIC
  ####Remotely invoke command to enable a network adaptor
  ####---------------------------------------------------------------------------
  function Connect-RemoteNIC{
    Param($computername, [System.Management.Automation.PSCredential]
    $Credential = $(Get-Credential))
  
    Invoke-Command -ComputerName $computername -Credential $Credential -ScriptBlock{
      Enable-NetAdapter -Name "Embedded FlexibleLOM 1 Port 3" -Confirm:$false
      ##Change Adapter Name could be NICTeam or NICTeam1 or VEthernet (Virtual Switch)
    }
  }