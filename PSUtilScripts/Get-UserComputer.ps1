
    function UserComp {
        $name = Read-Host "Enter User Full Name or Service Tag" 
        $CompName = Get-ADComputer -LDAPFilter "(Description=*$name*)"
        $CompName | Select-Object "Name" | Out-Host
        pause
            }
    UserComp
        


