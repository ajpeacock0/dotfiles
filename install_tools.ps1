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

    $systemFonts = Get-ChildItem -Path 'C:\Windows\Fonts' -Filter '*.ttf' -Recurse
    $currentUserFonts = Get-ChildItem -Path "$env:LOCALAPPDATA\Microsoft\Windows\Fonts" -Filter '*.ttf' -Recurse

    $foundFonts = @()

    $systemMatchedFonts = $systemFonts | Where-Object { $_.Name -like "*$FontName*" }
    if ($systemMatchedFonts.Count -gt 0) {
        $foundFonts += $systemMatchedFonts
    }

    $currentUserMatchedFonts = $currentUserFonts | Where-Object { $_.Name -like "*$FontName*" }
    if ($currentUserMatchedFonts.Count -gt 0) {
        $foundFonts += $currentUserMatchedFonts
    }

    if ($foundFonts.Count -eq 0) {
        Write-Output "No fonts found matching '$FontName'."
    }
    else {
        foreach ($font in $foundFonts) {
            Write-Output "$font.Name"
        }
    }
}

function Install-BasicTools {
    [CmdletBinding(SupportsShouldProcess)]
    param ()

    Write-FramedString "Installing Basic Tools and Font"

    # Install the latest vim from scoop along with the tools fd and fzf for
    # file searching. Also install mingw for treesitter in NeoVim
    scoop install vim neovim fd fzf ripgrep git sudo python bat zoxide jq sd mingw delta

    # Install FiraCode from NerdFont to the local user
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
    scoop install oh-my-posh
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

    # Install Packer for NeoVim plugin management
    git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
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

Install-BasicTools
Setup-Vim
Install-OhMyPosh
Add-DefenderExclusions
