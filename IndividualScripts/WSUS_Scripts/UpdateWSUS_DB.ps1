###Author: Joshua Dean
### Date Created: 2/9/2024
### Script to Remove all Declined Updates from WSUS Database that were declined from the "DeclineSupersededUpdates" script



$file = "D:\WSUS\Log\WSUS_CleanUp_Wiz_{0:MMddyyyy_HHmm}.txt" -f (Get-Date)
Start-Transcript -Path $file
$wsusserver = "MALWSUS01"
[reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration")` | out-null
$wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer($wsusserver, $False,8530);
$cleanupScope = new-object Microsoft.UpdateServices.Administration.CleanupScope;
$cleanupScope.DeclineSupersededUpdates    = $true
$cleanupScope.DeclineExpiredUpdates       = $true
$cleanupScope.CleanupObsoleteUpdates      = $true
$cleanupScope.CompressUpdates             = $false
$cleanupScope.CleanupObsoleteComputers    = $true
$cleanupScope.CleanupUnneededContentFiles = $true
$cleanupManager = $wsus.GetCleanupManager();
$cleanupManager.PerformCleanup($cleanupScope);
Stop-Transcript