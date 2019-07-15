Connect-AzureAD

#diff (Get-AzureADGroupMember -ObjectId "grp") (Get-AzureADGroupMember -ObjectId "grp") -Property "userPrincipalName" -IncludeEqual

### Export CSV

$res = diff (Get-AzureADGroupMember -ObjectId "id1") (Get-AzureADGroupMember -ObjectId "id2") -Property "userPrincipalName" -IncludeEqual

$res | Where-Object SideIndicator -match "<=" | Select-Object -Property "userPrincipalName"  | Export-Csv -path C:\path\file.csv
