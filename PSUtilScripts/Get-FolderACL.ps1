#Get Folder Permissions - 
<# 
The Get-Acl cmdlet gets objects that represent the security descriptor of a file or resource. 
The security descriptor contains the access control lists (ACLs) of the resource. 
The ACL specifies the permissions that users and user groups have to access the resource.
#>



function Get-FolderACL {
    $path = Read-Host "Enter Path"
    
    $GetAcl = Get-Acl -Path $path
    
    $GetAcl.Access | Select-Object IdentityReference,FileSystemRights | Out-Host
    Pause
    }
Get-FolderACL

