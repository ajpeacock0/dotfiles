# dotfiles

## What I've configured

My dotfile repo contains configuration files for
- git
- zsh
- vim
- powershell-core

## Linux scripts

These are ordered in recommended calling order.

### `install_tools.sh`

Downloads and installs tools I can't have a Unix shell without. Installs `zsh` + `oh-my-zsh` and changes the
default shell to zsh. You might need to log out to have the default shell change take affect.

### `link.sh`

Creates symlinks for all linux dotfiles and tool configurations.

## Powershell scripts

You will first need to install `scoop`:

```
$ Set-ExecutionPolicy RemoteSigned -scope CurrentUser
$ iwr -useb get.scoop.sh | iex
```

These setup scripts were written for Powershell-Core, and so may not run successfully on standard Powershell.
I recommend installing Powershell-Core and switching to it before running the install scripts.

```
$ scoop install pwsh
```

From here you can install `git` using `scoop` and clone this repo.

### `install_tools.ps1`

Downloads and installs tools I can't have a Powershell shell without, as well as Vim plugin managers.

### `powershell/install_modules.ps1`

**This must be done with admin permissions.**

Installs the Powershell Modules referenced by my PowerShell profile.

> Note: For an unknown reason this fails to install the modules and must be run again after the both link.ps1
> scripts

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
