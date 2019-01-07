# Link the .gitconfig to home. TODO: Change assumed "git_repos\dotfiles" path to use scriptDirectory
ln "${Env:UserProfile}\git_repos\dotfiles\.gitconfig" "${Env:UserProfile}\.gitconfig"

# Link the .gitconfig to home. TODO: Change assumed "git_repos\dotfiles" path to use scriptDirectory
ln "${Env:UserProfile}\git_repos\dotfiles\vim\.vimrc" "${Env:UserProfile}\.vimrc"