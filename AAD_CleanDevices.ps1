#import-module -name azuread
#connect-azuread


# Nombre de jours d'inactivité max

$deletionTresholdDays = 360


$deletionTreshold = (Get-Date).AddDays(-$deletionTresholdDays)


$alldevices = get-azureaddevice -All:$true | Where {($_.ApproximateLastLogonTimeStamp -le $deletionTreshold) -and ($_.deviceostype -notmatch "Windows") <#-and ($_.ApproximateLastLogonTimeStamp -ne $null) #>}


$exportPath=$(Join-Path $PSScriptRoot "AzureADDeviceExport.csv")


$allDevices | Select-Object -Property DisplayName, ObjectId, DeviceId, ApproximateLastLogonTimeStamp, DeviceOSType, DeviceOSVersion, IsCompliant, IsManaged `
| Export-Csv -Path $exportPath -UseCulture -NoTypeInformation


Write-Output "Find report with all devices under: $exportPath"


# Supprimer les devices

 <#$allDevices | ForEach-Object {

        Write-Output "Removing device $($PSItem.ObjectId)"

        Remove-AzureADDevice -ObjectId $PSItem.ObjectId
 }#>