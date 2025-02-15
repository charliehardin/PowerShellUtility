#Get List of Group Membership for specified user


function Get-UserGroups {
    $user = Read-Host "Enter Username"
    $Groups = Get-ADPrincipalGroupMembership -Identity $user | Select-Object Name | Sort-Object -Property name
    $Groups | Out-GridView 
    }
Write-Host "--------------------------------------------------------------------------"
Write-Host "Get AD User Group Membership"
Write-Host "--------------------------------------------------------------------------"
Get-UserGroups
pause
