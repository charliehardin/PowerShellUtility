#Get Currently Logged In User of specified computer

function Get-LoggedOnUser {
    $compname = Read-Host "Enter Computer Name:"
    
    if (Test-Connection -ComputerName $compname -Quiet) {
        Invoke-Command -ComputerName $compname -ScriptBlock {
            $loggedUser = Get-WmiObject -Class Win32_ComputerSystem | select-object UserName
            Write-Host $loggedUser
        } }
        else {
            write-host "Computer Not Online"
        }
        
        pause 
    }
    Get-LoggedOnUser