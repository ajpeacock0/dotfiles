# Include Powershell functions, needed for the `ln` alias
. ..\.powershell\functions.ps1

# Link the .powershell config files to home. TODO: Change assumed "git_repos\dotfiles" path to use scriptDirectory
ln "${Env:UserProfile}\vimfiles" "${Env:UserProfile}\.vim"
