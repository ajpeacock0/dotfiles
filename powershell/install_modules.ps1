# TODO: Ensure this is running on Powershell core

# Syntax coloring, key bindings
Install-Module PSReadLine

# Adds colors to the output of Get-ChildItem; used by ls alias
Install-Module -AllowClobber Get-ChildItemColor

# Ensure posh-git is loaded
Install-Module posh-git

# Powershell wrapper for fzf
Install-Module PSFzf

# Support for text-based clipboard operations
Install-Module -Name ClipboardText
