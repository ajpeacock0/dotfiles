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
