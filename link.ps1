#Requires -RunAsAdministrator

# Ensure this is running on Powershell core
if ($PSVersionTable.PSEdition -ne "Core") {
    Write-Warning "This script is intended to run on PowerShell Core. Please run it using PowerShell Core."
    return
}

function Write-FramedString {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$InputString
    )

    $frameLineLength = ([string]$InputString).Length + 12  # Adjust the frame length
    $frameLine = "-" * $frameLineLength
    $output = "$frameLine`n-$(' ' * 5)$InputString$(' ' * 5)-`n$frameLine"

    Write-Host $output
}

# Include Powershell functions, needed for the `ln` alias
. powershell\.powershell\functions.ps1

## Git Section

Write-FramedString "Linking Git Config"

# Link the .gitconfig to home. TODO: Change assumed "git_repos\dotfiles" path to use scriptDirectory
deleteitem "${Env:UserProfile}\.gitconfig"
ln "${Env:UserProfile}\git_repos\dotfiles\.gitconfig" "${Env:UserProfile}\.gitconfig"

## Windows Terminal Section

Write-FramedString "Linking Windows Terminal Settings"

# TODO: Change assumed "git_repos\dotfiles" path to use scriptDirectory
# Due to differences in machine configuration, the `settings.json` should be copied,
# not linked. The `settings.json` in this repo is only meant to be a starting point
$WindowsTerminalDirectory = "$Env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
if (Test-Path -Path $WindowsTerminalDirectory) {
    cp "${Env:UserProfile}\git_repos\dotfiles\settings.json" $WindowsTerminalDirectory
} else {
    Write-Warning "Cannot find the Windows Terminal settings at $WindowsTerminalDirectory"
}

## Vim Section

Write-FramedString "Linking Vim Config"

# Remove any existing Vim config files
deleteitem "${Env:UserProfile}\scoop\apps\vim\current\_gvimrc"
deleteitem "${Env:UserProfile}\scoop\apps\vim\current\_vimrc"
deleteitem "${Env:UserProfile}\.gvimrc"
deleteitem "${Env:UserProfile}\.vimrc"
deleteitem "${Env:UserProfile}\.vim"
deleteitem "${Env:UserProfile}\AppData\Local\nvim\init.vim"

# Link the .gitconfig to home. TODO: Change assumed "git_repos\dotfiles" path to use scriptDirectory
ln "${Env:UserProfile}\git_repos\dotfiles\.vimrc" "${Env:UserProfile}\.vimrc"

# Link the gvimrc
ln "${Env:UserProfile}\git_repos\dotfiles\.gvimrc" "${Env:UserProfile}\.gvimrc" # Put the gvimrc next to the vimrc
# ln "${Env:UserProfile}\git_repos\dotfiles\.gvimrc" "${Env:UserProfile}\scoop\apps\vim\current\_gvimrc"

# Link the Windows vimfiles to Unix style location
ln "${Env:UserProfile}\vimfiles" "${Env:UserProfile}\.vim"

# Link the init.vim to nvim AppData. TODO: Change assumed "git_repos\dotfiles" path to use scriptDirectory
ln "${Env:UserProfile}\git_repos\dotfiles\nvim\init.lua" "${Env:UserProfile}\AppData\Local\nvim\init.lua"
ln "${Env:UserProfile}\git_repos\dotfiles\nvim\lua" "${Env:UserProfile}\AppData\Local\nvim\lua"
ln "${Env:UserProfile}\git_repos\dotfiles\nvim\after" "${Env:UserProfile}\AppData\Local\nvim\after"

