Import-Module C:\path\Microsoft.Graph.Intune.psd1


$upn = Connect-MSgraph


if ($? -eq $false) {
    Write-Host "Error : cannot connect to Graph."
    exit
}

$upn = $upn.upn
Write-host "Connected to Graph as : $upn"

$alldevices = get-devicemanagement_manageddevices -Select imei

$cpt = 0

while ($cpt -lt $alldevices.Count)
{
    if ($alldevices[$cpt].imei)
    {
        $onedevice = $alldevices[$cpt].imei
        $onedevice = $onedevice -replace '\s',''
        write-host "$onedevice"
    }

     $cpt++
}

#write-host $alldevices


