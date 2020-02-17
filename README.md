# dotfiles

## What I've configured

My dotfile repo contains configuration files for
- git
- zsh
- vim
- powershell-core

## Linux scripts

These are ordered in recommended calling order.

### `zsh/install.sh`

Installs `zsh` + `oh-my-zsh` and changes the default shell to zsh. You might need to log out to have the default shell change take affect.

### `install_tools.sh`

Downloads and installs tools I can't have a Unix shell without.

### `vim/install.sh`

Installs a plugin manager and my perfered Vim version.

### `link.sh`

Creates symlinks for all linux dotfiles and tool configurations.

## Powershell scripts

These setup scripts were written for Powershell-Core, and so may not run successfully on standard
Powershell.

### `powershell/install_modules.ps1`

Installs the Powershell Modules referenced by my PowerShell profile.

### `powershell/link.ps1`

**This must be done with admin permissions.** 

Create symlinks for Windows powershell config and profile.

### `link.ps1`

**This must be done with admin permissions.** 

Create symlinks for any Powershell dotfiles in the home directory.

For the Windows Terminal `profiles.json`, there are 2 options to run PowerShellCore
- `"source": "Windows.Terminal.PowershellCore"`
- `"commandline": "%PWSH%"` 
This is after you run `export` to your `pwsh.exe` path, e.g.
```
export PWSH %ProgramFiles%\PowerShell\6\pwsh.exe
```
For increased flexibility across multiple machines, I use the "commandline" argument. 

### `vim/install.ps1`

### `vim/link.ps1`

**This must be done with admin permissions.** 
