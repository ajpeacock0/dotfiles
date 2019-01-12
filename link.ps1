# Include Powershell functions, needed for the `ln` alias
# You must first run the link.ps1 script for powershell
. ~\.powershell\functions.ps1

# Link the .gitconfig to home. TODO: Change assumed "git_repos\dotfiles" path to use scriptDirectory
ln "${Env:UserProfile}\git_repos\dotfiles\.gitconfig" "${Env:UserProfile}\.gitconfig"

# Link the .gitconfig to home. TODO: Change assumed "git_repos\dotfiles" path to use scriptDirectory
ln "${Env:UserProfile}\git_repos\dotfiles\vim\.vimrc" "${Env:UserProfile}\.vimrc"
