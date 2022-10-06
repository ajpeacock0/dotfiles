# Install the latest vim from scoop
# Along with the tools fd and fzf for
# file searching
scoop install vim neovim fd fzf ripgrep git sudo python bat zoxide jq

# pynvim is needed for Vim to use Python
python3 -m pip install --user --upgrade pynvim

# Install FiraCode from NerdFont
scoop bucket add nerd-fonts
sudo scoop install FiraCode-NF

# Install XLaunch from extras vcxsrv
scoop bucket add extras
scoop install vcxsrv extras/vcredist2015

# Include Powershell functions, needed for the `touch` alias
. powershell\.powershell\functions.ps1

# Create config file for NeoVim if it doesn't already exist
$Script:NeoVimHome = "~\AppData\Local\nvim"
if (-not (Test-Path $Script:NeoVimHome)) {
    md $Script:NeoVimHome
}
touch "${Script:NeoVimHome}\init.vim"

# Install Vim-Plug for NeoVim
if (-not (Test-Path "${Script:NeoVimHome}\autoload")) {
    md "${Script:NeoVimHome}\autoload"
}
$Script:uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile(
  $Script:uri,
  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "${Script:NeoVimHome}\autoload\plug.vim"
  )
)

# Install Vim-Plug for Vim
$Script:VimHome = "~\vimfiles"
if (-not (Test-Path "${Script:VimHome}\autoload")) {
    md "${Script:VimHome}\autoload"
}
(New-Object Net.WebClient).DownloadFile(
  $Script:uri,
  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "${Script:VimHome}\autoload\plug.vim"
  )
)

# Install On-My-Posh (previously a Powershell Module)
scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json

# Install the prefered Font
scoop install FiraCode-NF
