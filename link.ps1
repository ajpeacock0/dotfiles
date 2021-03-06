#Requires -RunAsAdministrator

# Powershell Link Script

# Include Powershell functions, needed for the `ln` alias
. powershell\.powershell\functions.ps1

## Git Section

# Link the .gitconfig to home. TODO: Change assumed "git_repos\dotfiles" path to use scriptDirectory
deleteitem "${Env:UserProfile}\.gitconfig"
ln "${Env:UserProfile}\git_repos\dotfiles\.gitconfig" "${Env:UserProfile}\.gitconfig"

## Windows Terminal Section

# Link the Windows Terminal Profiles. TODO: Change assumed "git_repos\dotfiles" path to use scriptDirectory
# DO NOT remove the previous `profiles.json` as this is only meant to be a starting point, not kept in sync
# due to differences in machine configuration, similar a .ssh config.
$WindowsTerminalProfiles = "$Env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\profiles.json"
if (-Not (Test-Path -Path $WindowsTerminalProfiles)){
    cp "${Env:UserProfile}\git_repos\dotfiles\profiles.json" $WindowsTerminalProfiles
}

## Vim Section

# Remove existing Vim config files
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
ln "${Env:UserProfile}\git_repos\dotfiles\init.vim" "${Env:UserProfile}\AppData\Local\nvim\init.vim"

