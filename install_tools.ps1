# Install the latest vim from scoop
# Along with the tools fd and fzf for
# file searching
scoop install vim fd fzf ripgrep git sudo

# Install FiraCode from NerdFont
scoop bucket add nerd-font
sudo scoop install FiraCode-NF

# Install Vim-Plug
md ~\vimfiles\autoload
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile(
  $uri,
  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "~\vimfiles\autoload\plug.vim"
  )
)
