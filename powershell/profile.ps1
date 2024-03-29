#### Version Statement ####

echo "Powershell-Core profile (Updated 12.23.23)"

#### Theme ####

# Change the default the prompt to a oh-my-posh theme
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\\slimfat.omp.json" | Invoke-Expression

#### Module Imports ####

# Used to create `ls` alias
Import-Module Get-ChildItemColor

# Syntax coloring, key bindings
Import-Module PSReadLine

# Ensure posh-git is loaded
Import-Module posh-git

# Disable the default ReverseHistorySearch
Remove-PSReadlineKeyHandler 'Ctrl+r'

# Powershell wrapper for FZF
Import-Module PSFzf -SkipEditionCheck

# Clipboard copy function
Import-Module ClipboardText

#### Initialize zoxide ####

Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell) -join "`n"
})

#### Aliases ####

# ll and ls aliases to use the new Get-ChildItemColor cmdlets
Set-Alias ll Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope

# Set '~' location to the User Profile directory
function cusorprofile { Set-Location ~ }
Set-Alias ~ cusorprofile -Option AllScope

# Shortcut for moving to parent directory
function moveup1 { cd .. }
Set-Alias .. moveup1 -Option AllScope

function moveup2 { cd .. && cd .. }
Set-Alias ... moveup2 -Option AllScope

function moveup3 { cd .. && cd .. && cd .. }
Set-Alias .... moveup3 -Option AllScope

Set-Alias ba bat

Set-Alias xclip Set-ClipboardText

#### Encoding ####

$OutputEncoding = [Text.Encoding]::UTF8
[Console]::OutputEncoding = $OutputEncoding
CHCP 65001 | Out-Null

##### Vi Mode Key Bindings ####

# Set Readline options
$PSReadLineOptions = @{
    # Enable Vi mode when escaped shell
    EditMode = "Vi"
    HistoryNoDuplicates = $true
    # Match unix behaviour of moving the cursor to the end of the line
    HistorySearchCursorMovesToEnd = $true
    ViModeIndicator = "Cursor"
}

# Set and override all PS readline options
Set-PSReadLineOption @PSReadLineOptions

# Set `Ctrl+x` to toggle the Vi mode
Set-PSReadlineKeyHandler -Chord Ctrl+x -Function ViCommandMode -ViMode Insert
Set-PSReadlineKeyHandler -Chord Ctrl+x -Function ViInsertMode -ViMode Command

# Custom `ReverseSearchHistory` which uses previous session history
Set-PSReadlineKeyHandler -Chord Ctrl+r -ScriptBlock { cat (Get-PSReadlineOption).HistorySavePath | Invoke-Fzf -NoSort -ReverseInput -Exact | Invoke-Expression } -ViMode Insert
#Set-PSReadlineKeyHandler -Chord Ctrl+r -ScriptBlock { Invoke-FuzzyHistory } -ViMode Insert

# TODO: Explain this
Set-PSReadlineKeyHandler -Chord Ctrl+k -Function Abort -ViMode Insert

# Set history navigation to set with current command
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward -ViMode Command
Set-PSReadLineKeyHandler -Key k -Function HistorySearchBackward -ViMode Command
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward -ViMode Command
Set-PSReadLineKeyHandler -Key j -Function HistorySearchForward -ViMode Command

# Shift+dir to move cursor to begin/end of line
Set-PSReadLineKeyHandler -Key H -Function BeginningOfLine -ViMode Command
Set-PSReadLineKeyHandler -Key L -Function EndOfLine -ViMode Command

#### Key Bindings ####

# Emac Style kill
Set-PSReadLineKeyHandler -Key Ctrl+k -Function KillLine
Set-PSReadLineKeyHandler -Key Ctrl+u -Function BackwardKillLine
Set-PSReadLineKeyHandler -Key Alt+d -Function KillWord
Set-PSReadLineKeyHandler -Key Ctrl+w -Function BackwardKillWord
Set-PSReadLineKeyHandler -Key Ctrl+l -Function ClearScreen

# Allow tab complete
Set-PSReadlineKeyHandler "Tab" MenuComplete

# Display scroll
Set-PSReadLineKeyHandler -Key Ctrl+UpArrow -Function ScrollDisplayUpLine
Set-PSReadLineKeyHandler -Key Ctrl+DownArrow -Function ScrollDisplayDownLine

# Unix style clipboard bindings
Set-PSReadLineKeyHandler -Key Ctrl+C -Function Copy
Set-PSReadLineKeyHandler -Key Ctrl+Shift+V -Function Paste

#### History ####

# Searches the history with the current command
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

#### Script Imports ####

# Set syntax colors
. "${Env:UserProfile}\.powershell\syntax-colors.ps1"

# Import custom functions
. "${Env:UserProfile}\.powershell\functions.ps1"

# Import Enviornment vars
. "${Env:UserProfile}\.powershell\environment.ps1"

#### Functions ####

# Display the given Unicode value as a character. Used to test font support.
function U
{
    param
    (
        [int] $Code
    )

    if ((0 -le $Code) -and ($Code -le 0xFFFF))
    {
        return [char] $Code
    }

    if ((0x10000 -le $Code) -and ($Code -le 0x10FFFF))
    {
        return [char]::ConvertFromUtf32($Code)
    }

    throw "Invalid character code $Code"
}

#### Include local variables ####

# Include a `vars.ps1` file if it exists
$varsPath="${Env:UserProfile}\.vars.ps1"
if (Test-Path $varsPath)
{
    . $varsPath
}

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
