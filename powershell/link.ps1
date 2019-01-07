# Link the .powershell config files to home. TODO: Change assumed "git_repos\dotfiles" path to use scriptDirectory
ln "${Env:UserProfile}\git_repos\dotfiles\powershell\.powershell" "${Env:UserProfile}\.powershell"

# Link the profile to it's Windows location. TODO: Change assumed "git_repos\dotfiles" path to use scriptDirectory
ln "${Env:UserProfile}\git_repos\dotfiles\powershell\profile.ps1" "${Env:UserProfile}\Documents\Powershell\Microsoft.PowerShell_profile.ps1"