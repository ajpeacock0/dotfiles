[CmdletBinding(DefaultParameterSetName = 'None', SupportsShouldProcess)]
param(
    [Parameter(Mandatory = $true, ParameterSetName = "Scoop")]
    [switch] $Scoop = $false,

    [Parameter(Mandatory = $true, ParameterSetName = "Vim")]
    [switch] $Vim = $false,

    [Parameter(Mandatory = $true, ParameterSetName = "Defender")]
    [switch] $Defender = $false
)

function Install-BasicTools {
    [CmdletBinding(SupportsShouldProcess)]
    param ()

    # Install the latest vim from scoop
    # Along with the tools fd and fzf for
    # file searching
    scoop install vim neovim fd fzf ripgrep git sudo python bat zoxide jq sd

    # Install FiraCode from NerdFont
    scoop bucket add nerd-fonts
    scoop install FiraCode-NF

    # Install XLaunch from extras vcxsrv
    scoop bucket add extras
    scoop install vcxsrv extras/vcredist2015

    # Install On-My-Posh (previously a Powershell Module)
    scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json
}

function Include-PowershellFunctions {
    [CmdletBinding(SupportsShouldProcess)]
    param ()

    # Include Powershell functions
    . powershell\.powershell\functions.ps1
}

function Setup-Vim {
    [CmdletBinding(SupportsShouldProcess)]
    param ()

    # Needed for the `touch` alias
    Include-PowershellFunctions

    # pynvim is needed for Vim to use Python
    python3 -m pip install --user --upgrade pynvim

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
}

function Add-DefenderExclusions {
    [CmdletBinding(SupportsShouldProcess)]
    param ()

    # Stop windows Defener from Scanning Visual Studio
    $VsWhereCommand = "${Env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
    $VsInstances = & $VsWhereCommand -prerelease -all -format json | ConvertFrom-Json
    foreach ($VsInstance in $VsInstances) {
        sudo Add-MpPreference -ExclusionPath $VsInstance.installationPath
    }

    $Script:GitReposPath = "~\git_repos"
    sudo Add-MpPreference -ExclusionPath $GitReposPath

    $Script:OneDrivePath = "~\OneDrive"
    sudo Add-MpPreference -ExclusionPath $OneDrivePath

    $Script:MsBuildProcessName = "msbuild.exe"
    sudo Add-MpPreference -ExclusionProcess $MsBuildProcessName
}

# If no parameters were set, execute all functions
$All = $PSCmdlet.ParameterSetName -eq 'None'

if ($BasicTools -or $All) {
    Write-Output "Installing basic scoop packages..."
    Install-BasicTools
}

if ($Vim -or $All) {
    Write-Output "Setting up Vim..."
    Setup-Vim
}

if ($Defender -or $All) {
    Write-Output "Adding Windows Defender Exclusions..."
    Add-DefenderExclusions
}
