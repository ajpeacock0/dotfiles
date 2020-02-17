# Include Powershell functions, needed for the `ln` alias
# You must first run the link.ps1 script for powershell
. ~\.powershell\functions.ps1

# Link the .gitconfig to home. TODO: Change assumed "git_repos\dotfiles" path to use scriptDirectory
deleteitem "${Env:UserProfile}\.gitconfig"
ln "${Env:UserProfile}\git_repos\dotfiles\.gitconfig" "${Env:UserProfile}\.gitconfig"

# Link the Windows Terminal Profiles. TODO: Change assumed "git_repos\dotfiles" path to use scriptDirectory
# DO NOT remove the previous `profiles.json` as this is only meant to be a starting point, not kept in sync
# due to differences in machine configuration, similar a .ssh config.
cp "${Env:UserProfile}\git_repos\dotfiles\profiles.json" "$Env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\profiles.json"
