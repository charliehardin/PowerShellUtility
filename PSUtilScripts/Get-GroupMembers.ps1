#Get Members of Specified Group

$GroupName = Read-Host "Enter Group Name:"

Get-ADGroupMember -Identity $GroupName | Select-Object 'name', 'SAMAccountName', 'distinguishedName'| Out-GridView

pause

