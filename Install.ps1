#PowerShell Utility Install Script
#Created By Charlie Hardin

function Test-LocalAdmin {
    $currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object System.Security.Principal.WindowsPrincipal($currentUser)
    $isAdmin = $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
    
    return $isAdmin
}
Write-Host "Checking for Admin Privilges..."
if (Test-LocalAdmin) {
    Write-Output "The current user has local admin privileges."
} else {
    Write-Output "The current user does NOT have local admin privileges."
    Write-Output "Run as Admin and try again"
    Start-Sleep -Seconds 5
    exit
}

Write-Host "Continuing Install..."

#Check PowerShell Version
<#
function Get-PowerShellVersion {
    $Major = $host.Version | Select-Object Major
    $Minor = $host.Version | Select-Object Minor
    Write-Host $Major $Minor
}
#>

#Check For Required Modules 
Write-Host "Checking For Required Modules..."
function Get-ReqModules {
    $ReqModule1 = "ActiveDirectory"
   if (Get-Module -ListAvailable -Name ActiveDirectory){
    Write-Output "Required Modules Are Installed"
   } else {
    Write-Output "Required Modules $ReqModule1 Not Installed"
    $Userinput = Read-Host -Prompt "Would You Like To Install Required Modules Now? (y/n)"
    if ($Userinput -eq "y"){
        Write-Output "Installing Required Modules.. Please Wait.."
        Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online
        Write-Output "Required Modules Installed"
    } else {
        exit 
    }
   }
    
}
Get-ReqModules

#Download Scripts
Write-Output "Downloading Scripts..."


    # Get the current user's home directory
    $UserHome = [System.Environment]::GetFolderPath("UserProfile")

    # Define a default download directory inside the user's home folder
    $DownloadFolder = "$UserHome\Downloads\"

    # GitHub repository URL (replace with your actual repository)
    $RepoURL = "https://github.com/charliehardin/PowerShellUtility/archive/refs/heads/main.zip"

    # Output ZIP file path
    $ZipFile = "$DownloadFolder\PSUtil.zip"

    # Extracted folder path
    $ExtractedPath = "$UserHome\PowerShellUtility"

    
    Invoke-WebRequest -Uri $RepoURL -OutFile $ZipFile
    Expand-Archive -Path $ZipFile -DestinationPath $ExtractedPath -Force
    


Write-Output "Successfuly Installed PowerShell Utility! Scripts & Executable Available At: $ExtractedPath "
Pause

