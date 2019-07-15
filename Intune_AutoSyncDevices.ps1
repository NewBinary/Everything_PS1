#Import-Module C:\path\Microsoft.Graph.Intune.psd1

$upn = Connect-MSgraph -ForceInteractive

if ($? -eq $false) {
    Write-Host "Error : cannot connect to Graph."
    exit
}

$upn = $upn.upn
Write-host "Connected to Graph as : $upn"


#### Grab all devices enrolled which are not Windows, enrolled in 2019

#### Stores the enroll date of each device

while (1){
    $devicesToSync = Get-DeviceManagement_ManagedDevices | 
    Where-Object {($_.operatingsystem -notmatch "Windows") -and 
    ($_.managementAgent -eq "mdm") -and 
    ($_.EnrolledDateTime -match 'X?2019X?')} #| Select-Object id , enrollmentdate

    $month_actual = Get-Date -UFormat %B
    $day_actual = get-date -UFormat %d
    $hour_actual = get-date -UFormat %I
    $ampm = get-date -Uformat %r
    $ampm_actual = $ampm.Substring(9,2)

    foreach ($device in $devicestosync){
        if ($device -eq $null){
            Write-host "Device is null" -ForegroundColor Red
        }
        else {
            $dateenrolldevice = $device.enrolledDateTime | out-string

            ### Exclude all out of day & hour

            $regex = "X?" + "${month_actual}" + " " + "${day_actual}" + ", 2019"# + [regex]::escape($month_actual) +'2019X?'
            $regex2 =  "X?" + "2019 " + "*"# + "${ampm_actual}"


            if (($dateenrolldevice -match $regex) -and ($dateenrolldevice -match $regex2)){
                Write-host "Syncing :"$device.devicename " - " $device.enrolledDateTime -ForegroundColor Green
                Invoke-DeviceManagement_ManagedDevices_SyncDevice -managedDeviceId $device.id
            }
        }
    }
sleep 50
Write-Host "Finished, relaunching" -ForegroundColor White
}



    #break

    #$dateenrolldevice = $device | out-string
    #$day = $dateenrolldevice.Substring(48,2)
    #$month = $dateenrolldevice.Substring(51,3)
    #$year = $dateenrolldevice.Substring(55,2)
    #$hour  = $dateenrolldevice.Substring(58,2)
    #$minutes  = $dateenrolldevice.Substring(61,2)
    #$seconds  = $dateenrolldevice.Substring(64,2)
    #$ampm = $dateenrolldevice.Substring(67,2)

  #  if ($ampm -match "pm"){
  #      $hour = [int]$hour + 12 + 2
  #  }
  #  else{
  #      $hour = [int]$hour + 2
  #  }
   <# switch ( $Month ){
            Jan { $Month = '01'}
            Feb { $Month = '02'}
            Mar { $Month = '03'}
            Apr { $Month = '04'}
            May { $Month = '05'}
            Jun { $Month = '06'}
            Jul { $Month = '07'}
            Aug { $Month = '08'}
            Sep { $Month = '09'}
            Oct { $Month = '10'}
            Nov { $Month = '11'}
            Dec { $Month = '12'}
        }
    $year = "20" + $year

    echo "day : "$day
    echo "month : "$month
    echo "year : "$year
    echo "hour : "$hour
    echo "minutes : "$minutes
    echo "seconds : "$seconds
    echo "ampm : "$ampm

    
    #### Exclude all device out of the month

    #>
    <#if ($month_actual -ne $month){
        break
    }
    else {
        $ts = New-TimeSpan -End (get-date -Year $year -Month $month -Day $day -Hour $hour -Minute $minutes -Second $seconds)

        if (($ts.Days -eq 0) -and ($ts.hours -eq 0) -and ($ts.minutes -gt -10)  -and ($ts.minutes -lt 0)){
            write-host "Syncing the device : " $device.id -ForegroundColor Green
            Invoke-DeviceManagement_ManagedDevices_SyncDevice -managedDeviceId $device
        }
        else{
        write-host "No syncing" -ForegroundColor Red
        }
    }
    break #>




#$upn = Connect-MSgraph -ForceInteractive


#if ($? -eq $false) {
#    Write-Host "Error : cannot connect to Graph."
#    exit
#}

#$upn = $upn.upn
#Write-host "Connected to Graph as : $upn"


#$companyDevices = Get-DeviceManagement_ManagedDevices |
#Where-Object {($_.managedDeviceOwnerType -eq "personal") -and ($_.operatingsystem -notmatch "Windows") -and ($_.managementAgent -eq "mdm")}| 
#Select-Object id, deviceName, managedDeviceOwnerType, operatingSystem

#$companydevices

#$devicesToSync = Get-DeviceManagement_ManagedDevices |
#Where-Object {($_.operatingsystem -notmatch "Windows") -and ($_.managementAgent -eq "mdm")} | 
#Select-Object id, deviceName, managedDeviceOwnerType, operatingSystem, enrolledDateTime



#$actualdate = Get-Date -Format g
#$lol
#$lol = [datetime]::parseexact($diff, 'yyyyMMdd', $null)

#$lol
#$actualdate
#if ($lol.ToString() -lt $actualdate){
#    echo "lol"

#}
#else{
#    echo "lil"
#}



#$dateenrolldevice = $dateenrolldevice.ToString()
#$dateenrolldevice 


#$separate



#$ts
 # Check results

#$lol

#$devicesToSync
#$actualdate

