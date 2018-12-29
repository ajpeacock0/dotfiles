#!/bin/bash

# Install zsh
sudo apt-get install -y zsh 

# Change the shell to zsh and install "oh-my-zsh"
chsh -s $(which zsh)
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
