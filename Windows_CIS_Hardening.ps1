# sur le client et le server
#Enable-PSRemoting -Force
#winrm set winrm/config/client '@{TrustedHosts="192.168.0.1,192.168.0.2"}'

#Set-Item wsman:\localhost\client\trustedhosts *


<#$PathTab = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\'

$KeyTab = 'dontdisplaylastusername'

$ExpectedValues = "1"


$cpt = 0#>
#$KeyTab[$num]
#$pathtab[$num]

#$PathTab
#$path
#$cpt = 0

#while ($cpt -lt $PathTab.Length){
    
    #ForEach-Object 
    #Invoke-Command -ComputerName desktop-qj45a72 -ScriptBlock { get-itemproperty -path $pathtab[$cpt] -name $KeyTab[$cpt]} -credential cesare
Invoke-Command -ComputerName desktop-qj45a72 -ScriptBlock { 
   
######################################## REGISTRY ####################################################


    Write-host "Registry key checking : " -BackgroundColor Blue

    $PathTab = @('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\', 'HKLM:\SYSTEM\CurrentControlSet\Services\bthserv', 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer')
    $KeyTab = @('dontdisplaylastusername', 'Start','NoDataExecutionPrevention')
    $ExpectedValues = @('1', '4', '1')

    # 1 : Ensure "interactive logon : don't display last signed-in" is set to enabled 
    # 2 : Ensure "bluetooth support service" is set to disabled 
    # 3 : Ensure "turn off data execution prevention for explorer" is set to disabled (permit legacy plug-ins to terminate without Explorer)

    $cpt = 0
    $good = 0

    while ($cpt -lt $PathTab.Length){
        $computerValue = get-itemproperty -path $PathTab[$cpt] -name $KeyTab[$cpt]  -erroraction 'silentlycontinue'
        #$computerValue = $computervalue | Select-Object -Property start -Unique
        $computervalue = $computerValue | Select -ExpandProperty $KeyTab[$cpt] 


        If ($computerValue -eq $Expectedvalues[$cpt]) {
            #$PathTab[$cpt]
            #$KeyTab[$cpt]
            Write-Host $PathTab[$cpt]$KeyTab[$cpt] = Correct Value : $Expectedvalues[$cpt] Computer Value : $computervalue -ForegroundColor Green
            $good++
        }
        elseif ($computervalue -eq $null){
            Write-host $PathTab[$cpt]$KeyTab[$cpt] = Correct Value : $Expectedvalues[$cpt] Computer Value : does not exist  -ForegroundColor Red
        }
        else {
            Write-host $PathTab[$cpt]$KeyTab[$cpt] = Correct Value : $Expectedvalues[$cpt] Computer Value : $computervalue  -ForegroundColor Red
            Write-host "Correcting the issue ..."
            set-itemproperty -path $PathTab[$cpt] -name $KeyTab[$cpt] -Value $ExpectedValues[$cpt]
            Write-Host "Corrected."
        }
        $cpt++
    }
   
   Write-Host "`n --> Your CIS grade is : " $good / $cpt


######################################## GPO ####################################################

    
    <#$GPOPath = @('Computer Configuration\Policies\Windows Settings\Security Settings\Local Policies\User Rights Assignment\Change the system time')
    #ParameterTab = @('Administrators, LOCAL SERVICE')
    $ExpectedValues = @('Administrators, LOCAL SERVICE')
    $cpt = 0


    while ($cpt -lt $gpopath.Length){
        $computerValue = get-itemproperty -path $gpopath[$cpt] -name $parametertab[$cpt] 
        #$computerValue = $computervalue | Select-Object -Property start -Unique
        $computervalue = $computerValue | Select -ExpandProperty $paramatertab[$cpt] 


        If ($computerValue -eq $Expectedvalues[$cpt]) {
            #$PathTab[$cpt]
            #$KeyTab[$cpt]
            Write-Host $gpopath[$cpt] -> $parametertab[$cpt] = "OK" -ForegroundColor Green
        }
        else {
            Write-host $gpopath[$cpt] -> $parametertab[$cpt] = "KO" -ForegroundColor Red
        }
        $cpt++
    }




    # GPO Checking

    #$GPOS('Computer')



    # File checking #>

}  -credential cesare






#HKEY_LOCAL_MACHINE\SYSTEzz\Services\bthserv good :4 




<#Foreach($path in $pathtab)
{
    $lol = Invoke-Command -ComputerName desktop-qj45a72 -ScriptBlock { get-itemproperty -path $key -name dontdisplaylastusername} -credential cesare

    Write-Host $lol.dontdisplaylastusername

}#>


#HKLM:\SOFTWAre\Microsoft\windowsnt\currentversion\
#HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\ <# good : 1 #>

#Invoke-Command -ComputerName desktop-qj45a72 -ScriptBlock { get-itemproperty -Path HKLM:\SOFTWARE\Microsoft\AppV\Client -name Version } -credential cesare






 
#HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\AppV\Client
<# C:\Users\cesare#> <#get-itemproperty -Path HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System.identifier #>

<#Microsoft\Windows NT\CurrentVersion #>
# Blocage de cookies

#Get-ItemProperty -Path HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\MicrosoftEdge\Main -Name Cookies