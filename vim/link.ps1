# Include Powershell functions, needed for the `ln` alias
# You must first run the link.ps1 script for powershell
. ~\.powershell\functions.ps1

# Remove existing Vim config files
deleteitem "${Env:UserProfile}\scoop\apps\vim\current\_gvimrc"
deleteitem "${Env:UserProfile}\scoop\apps\vim\current\_vimrc"
deleteitem "${Env:UserProfile}\.gvimrc"
deleteitem "${Env:UserProfile}\.vimrc"
deleteitem "${Env:UserProfile}\.vim"

# Link the .gitconfig to home. TODO: Change assumed "git_repos\dotfiles" path to use scriptDirectory
ln "${Env:UserProfile}\git_repos\dotfiles\vim\.vimrc" "${Env:UserProfile}\.vimrc"

# Link the gvimrc
ln "${Env:UserProfile}\git_repos\dotfiles\vim\.gvimrc" "${Env:UserProfile}\.gvimrc" # Put the gvimrc next to the vimrc
# ln "${Env:UserProfile}\git_repos\dotfiles\vim\.gvimrc" "${Env:UserProfile}\scoop\apps\vim\current\_gvimrc"

# Link the Windows vimfiles to Unix style location
ln "${Env:UserProfile}\vimfiles" "${Env:UserProfile}\.vim"
