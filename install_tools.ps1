[CmdletBinding(DefaultParameterSetName = 'None', SupportsShouldProcess)]
param(
    [Parameter(Mandatory = $true, ParameterSetName = "Scoop")]
    [switch] $Scoop = $false,

    [Parameter(Mandatory = $true, ParameterSetName = "Vim")]
    [switch] $Vim = $false,

    [Parameter(Mandatory = $true, ParameterSetName = "Defender")]
    [switch] $Defender = $false
)

function Write-FramedString {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$InputString
    )

    $frameLineLength = ([string]$InputString).Length + 12  # Adjust the frame length
    $frameLine = "-" * $frameLineLength
    $output = "$frameLine`n-$(' ' * 5)$InputString$(' ' * 5)-`n$frameLine"

    Write-Host $output
}

function Search-InstalledFonts {
    param (
        [Parameter(Mandatory = $true)]
        [string]$FontName
    )

    $fonts = Get-ChildItem -Path 'C:\Windows\Fonts' -Filter '*.ttf' -Recurse

    $foundFonts = $fonts | Where-Object { $_.Name -like "*$FontName*" }

    if ($foundFonts.Count -eq 0) {
        Write-Warning "No fonts found on this machine containing '$FontName'."
    } else {
        foreach ($font in $foundFonts) {
            Write-Output "The font is installed on this machine: $font.Name"
        }
    }
}

function Install-BasicTools {
    [CmdletBinding(SupportsShouldProcess)]
    param ()

    Write-FramedString "Installing Basic Tools and Font"

    # Install the latest vim from scoop
    # Along with the tools fd and fzf for
    # file searching
    scoop install vim neovim fd fzf ripgrep git sudo python bat zoxide jq sd

    # Install FiraCode from NerdFont
    scoop bucket add nerd-fonts
    scoop install FiraCode-NF

    # Check that FiraCode is available on this machine
    Search-InstalledFonts FiraCode
}

function Install-OhMyPosh {
    [CmdletBinding(SupportsShouldProcess)]
    param ()

    Write-FramedString "Installing On-My-Posh"

    # Install On-My-Posh (previously a Powershell Module)
    scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json
}

function Setup-Vim {
    [CmdletBinding(SupportsShouldProcess)]
    param ()

    Write-FramedString "Installing Vim dependencies and creating configuration files"

    # Needed for the `touch` alias. Note that cannot be moved to a function, as items that have the AllScope
    # property become part of any child scopes that you create, although they aren't retroactively inherite
    # by parent scopes.
    $functionsFilePath = "powershell\.powershell\functions.ps1"

    if (Test-Path $functionsFilePath) {
        . $functionsFilePath
    }
    else {
        Write-Warning "PowerShell functions file not found at $functionsFilePath"
    }

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

    Write-FramedString "Adding Windows Defender Exclusions"

    # Stop windows Defener from Scanning Visual Studio
    $VsWherePath = "${Env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
    if (Test-Path $VsWherePath) {
        $VsInstances = & $VsWherePath -prerelease -all -format json | ConvertFrom-Json

        foreach ($VsInstance in $VsInstances) {
            sudo Add-MpPreference -ExclusionPath $VsInstance.installationPath
        }
    } else {
        Write-Host "vswhere.exe not found. Visual Studio instances could not be retrieved."
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
    Install-BasicTools
}

if ($Vim -or $All) {
    Setup-Vim
}

if ($Defender -or $All) {
    Add-DefenderExclusions
}
