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

### Step 1: Install scoop

You will first need to install `scoop`:

```
$ Set-ExecutionPolicy RemoteSigned -scope CurrentUser
$ iwr -useb get.scoop.sh | iex
```

These setup scripts were written for Powershell-Core, and so may not run successfully on standard Powershell.

### Step 2: Install Powershell-Core and Git

```
$ scoop install pwsh git
```

You can now clone this repo:

```
$ git clone https://github.com/ajpeacock0/dotfiles.git
```

### Step 3: Run the `install_tools.ps1` script

This downloads and installs tools I can't have a Powershell shell without, as well as Vim plugin managers.

```
$ .\install_tools.ps1
```

Once this completed, close the shell and open an Admin Powershell-Core shell.

### Step 4: Run the `install_modules.ps1`

**This must be done with admin permissions.**

Installs the Powershell Modules referenced by my PowerShell profile.

```
$ cd powershell
$ .\install_modules.ps1
```

> Note: This script has been written in such a way calling it outside of the `/powershell` directory will cause failures during installation.

> For an unknown reason this fails to install the modules and must be run again after the both link.ps1 scripts

### Step 5: Run the `powershell/link.ps1` script

**This must be done with admin permissions.** 

Create symlinks for Powershell-Core config and profile.

```
$ .\link.ps1
```

### Step 6: Run the `link.ps1` script

**This must be done with admin permissions.** 

```
$ cd ..
$ .\link.ps1
```

Create symlinks for any Powershell dotfiles in the home directory.

### Step 7: Restart your terminal

Due to a bug in my scripts, you will get a series of `Import-Module` errors:
```
The specified module '<module_name>' was not loaded because no valid module file was found in any module directory.
```

The Powershell modules aren't found, and so you need to run the `install_modules.ps1` script again.

##

For the Windows Terminal `profiles.json`, there are 2 options to run PowerShellCore
- `"source": "Windows.Terminal.PowershellCore"`
- `"commandline": "%PWSH%"` 
This is after you run `export` to your `pwsh.exe` path, e.g.
```
export PWSH %ProgramFiles%\PowerShell\6\pwsh.exe
```
For increased flexibility across multiple machines, I use the "commandline" argument. 
