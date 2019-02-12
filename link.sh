#!/bin/bash

# Get the path of the script
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

# Create the symlinks to the dot files
echo "Creating symlinks from $SCRIPTPATH to ~"
ln -f -s $SCRIPTPATH/vim/.vimrc ~/.vimrc
ln -f -s $SCRIPTPATH/zsh/.zshrc ~/.zshrc
ln -f -s $SCRIPTPATH/.gitconfig ~/.gitconfig
ln -f -s $SCRIPTPATH/.inputrc ~/.inputrc

# Download a shared tmux config
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
# Link the included .tmux.conf
ln -f -s ~/.tmux.conf ~/.tmux.conf
# Link my local tmux.conf overrides and additions
ln -f -s $SCRIPTPATH/.tmux.conf.local ~/.tmux.conf.local

