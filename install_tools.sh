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

# Download the Vim plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install the gnome Vim version which has clipboard support
sudo apt-get install vim-gnome

# Download NeoVim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/bin/nvim

# Create config file for NeoVim
md ~/.config/nvim
touch ~/.config/nvim/init.vim

# Download the NeoVim plugin manager
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Download a diff tool for git
git clone https://github.com/so-fancy/diff-so-fancy.git ~/.diff-so-fancy

# Install font
echo "Download font: https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
mkdir -p ~/.fonts
unzip FiraCode.zip -d ~/.fonts
fc-cache -fv

# Install zsh
sudo apt-get install -y zsh

# Change the shell to zsh and install "oh-my-zsh"
chsh -s $(which zsh)
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Downloaded ZSH theme
-sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
+if [ -z "$ZSH_CUSTOM" ]
+then
+    echo "\$ZSH_CUSTOM is NULL. Powerlevel10k theme will NOT be downloaded"
+else
+    sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
+fi
