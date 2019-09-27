#!/bin/bash

# Install curl
sudo apt-get install curl

# Download and install the fzf tool
git clone --depth 1 http://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Download the `z` tool for jumping around directories
git clone https://github.com/rupa/z.git ~/.z

# Install the RipGrep tool
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb
sudo dpkg -i ripgrep_0.10.0_amd64.deb

# Install the fd tool
curl -LO https://github.com/sharkdp/fd/releases/download/v7.2.0/fd_7.2.0_amd64.deb
sudo dpkg -i fd_7.2.0_amd64.deb

# Install `thefuck` tool
sudo apt-get update
sudo apt install python3-dev python3-pip python3-setuptools
sudo pip3 install thefuck

# Install GO and the path-extractor
sudo apt-get install golang
go get github.com/edi9999/path-extractor/path-extractor
