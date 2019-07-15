Import-Module C:\path\Microsoft.Graph.Intune.psd1


$upn = Connect-MSgraph -ForceInteractive


if ($? -eq $false) {
    Write-Host "Error : cannot connect to Graph."
    exit
}

$upn = $upn.upn
Write-host "Connected to Graph as : $upn"


$companyDevices = Get-DeviceManagement_ManagedDevices | Where-Object {($_.managedDeviceOwnerType -eq "company") -and ($_.operatingsystem -notmatch "Windows") -and ($_.managementAgent -eq "mdm")}| Select-Object id, deviceName, managedDeviceOwnerType, operatingSystem



if ($CompanyDevices -ne $null) {  
    ForEach ($CompanyDevice in $CompanyDevices) {
        update-DeviceManagement_ManagedDevices -managedDeviceid $CompanyDevice.id -manageddeviceownertype personal
    }
    Write-Host -ForegroundColor Yellow "Switch completed"
}

else {
    Write-Host -ForegroundColor Yellow "No company devices found"
}

