Import-Module C:\path\Microsoft.Graph.Intune.psd1


$upn = Connect-MSgraph


if ($? -eq $false) {
    Write-Host "Error : cannot connect to Graph."
    exit
}

$upn = $upn.upn
Write-host "Connected to Graph as : $upn"



#Write-host "All groups : "

#$groups = get-groups
#$groups = $groups.displayname


#write-host $groups

#foreach ($group in $groups){
#    Write-Host $group
#}

$allDevices = Get-DeviceManagement_ManagedDevices
#Write-Host $allDevices

$count = $allDevices|Measure-Object
$count = $count.Count

$roll = get-random -Minimum 0 -Maximum $count
$deviceToLock = $allDevices[$roll]
$deviceToLockName = $allDevices[$roll].deviceName
$deviceToLockID = $allDevices[$roll].id

Write-Host "
Device $deviceToLockName won ! Rebooting ..."

# Fatalité : 
$deviceToLock | Invoke-DeviceManagement_ManagedDevices_Rebootnow