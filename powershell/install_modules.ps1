#Requires -RunAsAdministrator

# Ensure this is running on Powershell core
if ($PSVersionTable.PSEdition -ne "Core") {
    Write-Warning "This script is intended to run on PowerShell Core. Please run it using PowerShell Core."
    return
}

# Set the InstallationPolicy of the PowerShell Gallery repository to Untrusted
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

# Syntax coloring, key bindings
Install-Module PSReadLine -Verbose

# Adds colors to the output of Get-ChildItem; used by ls alias
Install-Module -AllowClobber Get-ChildItemColor -Verbose

# Ensure posh-git is loaded
Install-Module posh-git -Verbose

# Powershell wrapper for fzf
Install-Module PSFzf -Verbose

# Support for text-based clipboard operations
Install-Module -Name ClipboardText -Verbose
