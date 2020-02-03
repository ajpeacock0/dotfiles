# Include Powershell functions, needed for the `ln` alias
. .\.powershell\functions.ps1

# Link the .powershell config files to home. TODO: Change assumed "git_repos\dotfiles" path to use scriptDirectory
ln "${Env:UserProfile}\git_repos\dotfiles\powershell\.powershell" "${Env:UserProfile}\.powershell"

# Link the profile to it's Windows location. TODO: Change assumed "git_repos\dotfiles" path to use scriptDirectory
mkdir "${Env:UserProfile}\Documents\Powershell" # ensure the Powershell directory exists
ln "${Env:UserProfile}\git_repos\dotfiles\powershell\profile.ps1" "${Env:UserProfile}\Documents\Powershell\Microsoft.PowerShell_profile.ps1"
