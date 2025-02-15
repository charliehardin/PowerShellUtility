#Get Description of Specified Computer, including assinged user, service tag, etc. 

function CompUser {
    $ComputerName = Read-Host "Enter Computer Name"
    $User = Get-ADComputer $ComputerName -Properties Description | Select-Object Description
    $User | Out-Host
    Pause
    }
    CompUser 