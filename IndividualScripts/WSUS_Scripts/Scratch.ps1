##Scratch editor for new scripts and modules for the WSUS Repository

##Restart in 4 hrs
shutdown /t 14400 /r




Get-PSWSUSUPdateperclient -ComputerName "MALSWREPO01" -UpdateScope
 (New-PSWSUSUpdateScope -ExcludeOptionalUpdates -ApprovedStates "NotApproved")
 
##-----------------------------------------------------------------------------

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

