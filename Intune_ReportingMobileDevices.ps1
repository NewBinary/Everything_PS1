#Connect-AzureAD



# To change :

$grp = Get-AzureADGroup -ObjectId "objidgrp"

###

$mem = Get-AzureADGroupMember -ObjectId $grp.ObjectId -All $true | Where {($_.Mail -notmatch "company.onmicrosoft.com")}
$countEnrolled = 0
$countPersonal = 0
$countNodevice = 0

Foreach($member in $mem)
{
   #$res = Get-AzureADUserOwnedDevice -ObjectId $member.ObjectId -All $true | Where {($_.deviceostype -notmatch "Windows") -and ($_.IsManaged -match "True")}
   #if ($res -eq $null){
   #     Write-Host $member.UserPrincipalName "KO" -ForegroundColor Red
   #}
   if((Get-AzureADUserOwnedDevice -ObjectId $member.ObjectId -All $true | Where {($_.deviceostype -notmatch "Windows") -and ($_.IsManaged -match "True")}) -ne $null){
        if (Get-AzureADGroupMember -ObjectId "objid" -All $true| Where {($_.objectid -match $member.ObjectId)}) {
             Write-Host $member.UserPrincipalName "OK - Enrolled device User" -ForegroundColor Green
        }
        else {
             Write-Host $member.UserPrincipalName "KO - Enrolled device User - Wrong group and/or may be personal" -ForegroundColor Red
        }
        $countEnrolled++
   }
   elseif((Get-AzureADUserOwnedDevice -ObjectId $member.ObjectId -All $true | Where {($_.deviceostype -notmatch "Windows") -and ($_.IsManaged -eq $null) -and ($_.devicetrusttype -match "Workplace")}) -ne $null){
        if (Get-AzureADGroupMember -ObjectId "objid" -All $true | Where {($_.objectid -match $member.ObjectId)}) {
             Write-Host $member.UserPrincipalName "OK - Personal device User - Protected" -ForegroundColor Green
        }
        else {
             Write-Host $member.UserPrincipalName "OK - Personal device User - Not protected " -ForegroundColor Red
        } 
        $countPersonal++
   }   
   else{
        Write-host $member.UserPrincipalName " - No device added for this user" -ForegroundColor Gray
        $countNodevice++
   }
}
Write-Host "User enrolled : " $countEnrolled -ForegroundColor Yellow
Write-Host "User personal : " $countPersonal -ForegroundColor Yellow  
Write-Host "User no device : " $countNodevice -ForegroundColor Yellow


#$alldevices = get-azureaddevice -All:$true | Where {($_.deviceostype -notmatch "Windows")}

#echo $alldevices