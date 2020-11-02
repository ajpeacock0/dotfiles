#!/bin/bash

# Get the path of the script
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

# Create the symlinks to the dot files
echo "Creating symlinks from $SCRIPTPATH to ~"
ln -f -s $SCRIPTPATH/.vimrc ~/.vimrc
ln -f -s $SCRIPTPATH/init.vim ~/.config/nvim/init.vim
ln -f -s $SCRIPTPATH/.zshrc ~/.zshrc
ln -f -s $SCRIPTPATH/.p10k.zsh ~/.p10k.zsh
ln -f -s $SCRIPTPATH/.gitconfig ~/.gitconfig
ln -f -s $SCRIPTPATH/.inputrc ~/.inputrc
ln -f -s $SCRIPTPATH/.tmux.conf ~/.tmux.conf
ln -f -s $SCRIPTPATH/.tmuxline_lightline ~/.tmuxline_lightline
