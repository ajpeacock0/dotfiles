# Ensure that Get-ChildItemColor is loaded
Import-Module Get-ChildItemColor

# Set l and ls alias to use the new Get-ChildItemColor cmdlets
Set-Alias l Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope

# Helper function to change directory to my development workspace
# Change c:\ws to your usual workspace and everytime you type
# in cws from PowerShell it will take you directly there.
# function cws { Set-Location c:\ws }

# Helper function to set location to the User Profile directory
function cuserprofile { Set-Location ~ }
Set-Alias ~ cuserprofile -Option AllScope

# Helper function to show Unicode character
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

# Ensure posh-git is loaded - DISABLED FOR NOW
# Import-Module -Name posh-git

# Ensure oh-my-posh is loaded
Import-Module -Name oh-my-posh

# Default the prompt to Honukai oh-my-posh theme
Set-Theme Honukai

Import-Module PSReadLine

Set-PSReadLineOption -EditMode Emacs

# https://github.com/lzybkr/PSReadLine/blob/577d1444a073a5daa4666bc627af041aa631d093/PSReadLine/SamplePSReadlineProfile.ps1#L19
# Searching for commands with up/down arrow is really handy.  The
# option "moves to end" is useful if you want the cursor at the end
# of the line while cycling through history like it does w/o searching,
# without that option, the cursor will remain at the position it was
# when you used up arrow, which can be useful if you forget the exact
# string you started the search on.
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# In Emacs mode - Tab acts like in bash, but the Windows style completion
# is still useful sometimes, so bind some keys so we can do both
Set-PSReadlineKeyHandler -Key Ctrl+Q -Function TabCompleteNext
Set-PSReadlineKeyHandler -Key Ctrl+Shift+Q -Function TabCompletePrevious

# Clipboard interaction is bound by default in Windows mode, but not Emacs mode.
# Set-PSReadlineKeyHandler -Key Shift+Ctrl+C -Function Copy
# Set-PSReadlineKeyHandler -Key Ctrl+V -Function Paste
