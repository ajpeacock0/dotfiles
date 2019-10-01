#### Version Statement ####

echo "Powershell-Core profile (Updated 10.22.18)"

#### Module Imports ####

# Used to create `ls` alias
Import-Module Get-ChildItemColor

# Syntax coloring, key bindings
Import-Module PSReadLine

# Ensure posh-git is loaded
Import-Module posh-git

# A theme engine for Powershell
Import-Module oh-my-posh

#### Aliases ####

# ll and ls aliases to use the new Get-ChildItemColor cmdlets
Set-Alias ll Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope

# Set '~' location to the User Profile directory
function cuserprofile { Set-Location ~ }
Set-Alias ~ cuserprofile -Option AllScope

#### Encoding ####

$OutputEncoding = [Text.Encoding]::UTF8
[Console]::OutputEncoding = $OutputEncoding
CHCP 65001 | Out-Null

#### Key Bindings ####

# Emac Style - TODO: Fix these not working
# Set-PSReadLineKeyHandler -Key Ctrl+k -Function KillLine
# Set-PSReadLineKeyHandler -Key Ctrl+u -Function BackwardKillLine
# Set-PSReadLineKeyHandler -Key Alt+d -Function KillWord
# Set-PSReadLineKeyHandler -Key Ctrl+w -Function BackwardKillWord
# Set-PSReadLineKeyHandler -Key Ctrl+l -Function ClearScreen

# Allow tab complete
Set-PSReadlineKeyHandler "Tab" MenuComplete
# Emacs style complete (overrides Windows `TabCompleteNext`)
#Set-PSReadlineKeyHandler -Key Tab -Function Complete

# Display scroll
Set-PSReadLineKeyHandler -Key Ctrl+UpArrow -Function ScrollDisplayUpLine
Set-PSReadLineKeyHandler -Key Ctrl+DownArrow -Function ScrollDisplayDownLine

# Unix style clipboard bindings
Set-PSReadLineKeyHandler -Key Ctrl+C -Function Copy
Set-PSReadLineKeyHandler -Key Ctrl+Shift+V -Function Paste

# Set Readline options
$PSReadLineOptions = @{
    # Enable Vi mode when escaped shell
    EditMode = "Vi"
    HistoryNoDuplicates = $true
    # Match unix behaviour of moving the cursor to the end of the line
    HistorySearchCursorMovesToEnd = $true
    ViModeIndicator = "Cursor"
}
Set-PSReadLineOption @PSReadLineOptions

# Set `Ctrl+c` to toggle the Vi mode
Set-PSReadlineKeyHandler -Chord Ctrl+c -Function ViCommandMode -ViMode Insert
Set-PSReadlineKeyHandler -Chord Ctrl+c -Function ViInsertMode -ViMode Command

Set-PSReadlineKeyHandler -Chord Ctrl+k -Function Abort -ViMode Insert

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

## Display the given Unicode value as a character. Used to test font support.
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

#### Theme ####

# Change the default the prompt to a oh-my-posh theme
Set-Theme Honukai

#### Include local variables ####

# Include a `vars.ps1` file if it exists
$varsPath="${Env:UserProfile}\vars.ps1"
if (Test-Path $varsPath)
{
    . $varsPath
}
