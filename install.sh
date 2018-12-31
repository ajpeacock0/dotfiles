#!/bin/bash

# Download and install the fzf tool
git clone --depth 1 http://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Install the RipGrep tool
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb
sudo dpkg -i ripgrep_0.10.0_amd64.deb

# Install the gnome Vim version which has clipboard support
sudo apt-get install vim-gnome
