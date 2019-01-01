#!/bin/bash

# Download and install the fzf tool
git clone --depth 1 http://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Download the `z` tool for jumping around directories
git clone https://github.com/rupa/z.git ~/.z

# Install the RipGrep tool
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb
sudo dpkg -i ripgrep_0.10.0_amd64.deb
