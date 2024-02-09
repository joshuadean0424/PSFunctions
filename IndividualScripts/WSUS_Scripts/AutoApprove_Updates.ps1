###Author: Joshua Dean
### Date Created: 2/09/2024
### Script to approve updates for WSUS clients


$wsusserver = "MALWSUS01" 
$log = "D:\WSUS\Log\Approved_Updates_{0:MMddyyyy_HHmm}.log" -f (Get-Date) #Log file name
$switch = "EDLP"
#Creating log file
new-item -path $log -type file -force 
