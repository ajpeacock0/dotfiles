#Requires -RunAsAdministrator

# Ensure this is running on Powershell core
if ($PSVersionTable.PSEdition -ne "Core") {
    Write-Warning "This script is intended to run on PowerShell Core. Please run it using PowerShell Core."
    return
}

# Include Powershell functions, needed for the link function
. .\.powershell\functions.ps1

# Check if $Script:DotfilesPowerShell is not set, assigning if not
if (-not $Script:DotfilesPowerShell) {
    $Script:DotfilesPowerShell = (Get-Location).Path
    Write-Host "Assigned DotfilesPowerShell path to the current directory: ${Script:DotfilesPowerShell}" -ForegroundColor Yellow
} else {
    Write-Host "DotfilesPowerShell path is already set to: ${Script:DotfilesPowerShell}" -ForegroundColor Green
}

# Link the .powershell functions and unique configuration files to home
ln "${Script:DotfilesPowerShell}\.powershell" "${Env:UserProfile}\.powershell"

# Create PowerShell directory if it doesn't already exist
$Script:WindowsPowerShellHome = "${Env:UserProfile}\Documents\WindowsPowerShell"
if (-not (Test-Path $Script:WindowsPowerShellHome)) {
    New-Item -Path $Script:WindowsPowerShellHome -ItemType 'Directory'
}

# Use the same directory for Windows PowerShell and PowerShell Core
$Script:PowerShellCoreHome = "${Env:UserProfile}\Documents\PowerShell"
New-Link -TargetPath $Script:WindowsPowerShellHome -LinkPath $Script:PowerShellCoreHome -LinkType 'Junction'

# If the user's documents directory is not at '~/Documents', link the PowerShell directories into place there too.
# This will be the case if 'Documents' is being backed up to OneDrive.
$Script:MyDocumentsPath = [Environment]::GetFolderPath("MyDocuments")
if ($Script:MyDocumentsPath -ne "${Env:UserProfile}\Documents") {
    New-Link -TargetPath $Script:WindowsPowerShellHome -LinkPath "${Script:MyDocumentsPath}\WindowsPowerShell" -LinkType 'Junction'
    New-Link -TargetPath $Script:PowerShellCoreHome -LinkPath "${Script:MyDocumentsPath}\PowerShell" -LinkType 'Junction'
}

# Link PowerShell profile into place
$Script:PowerShellProfile = "${Script:WindowsPowerShellHome}\Microsoft.PowerShell_profile.ps1"
New-Link -TargetPath "${Script:DotfilesPowerShell}\profile.ps1" -LinkPath $Script:PowerShellProfile -LinkType 'SymbolicLink'
