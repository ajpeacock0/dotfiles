# Install the latest vim from scoop
# Along with the tools fd and fzf for
# file searching
scoop install vim neovim fd fzf ripgrep git sudo python

# pynvim is needed for Vim to use Python
python3 -m pip install --user --upgrade pynvim

# Install FiraCode from NerdFont
scoop bucket add nerd-fonts
sudo scoop install FiraCode-NF

# Install XLaunch from extras vcxsrv
scoop bucket add extras
scoop install vcxsrv extras/vcredist2015

# Install Vim-Plug for Vim
md ~\vimfiles\autoload
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile(
  $uri,
  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "~\vimfiles\autoload\plug.vim"
  )
)

# Install Vim-Plug for NeoVim
md ~\AppData\Local\nvim
touch ~\AppData\Local\nvim\init.vim

# Install plugin-manager vim-plug
$ md ~\AppData\Local\nvim\autoload
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile(
  $uri,
  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "~\AppData\Local\nvim\autoload\plug.vim"
  )
)
