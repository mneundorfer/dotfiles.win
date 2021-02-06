# Dotfiles for Windows

`stow.ps1` contains a best guess implementation of what GNU stow does on Linux. For it to work properly, checkout this repo to `$HOME/.dotfiles`, then `cd` into it and

```powershell
# be aware that this must be run in an elevated PowerShell, as SymbolicLink requires Admin privileges
# https://security.stackexchange.com/a/10198
Import-Module .\stow.ps1
Set-DotfileLink -Tools vscode pscore git
```

## How It Works

The assumption is, that all configurations are placed below the user's `$HOME`. The same subdirectory structure must be used in the folders for each tool, i.e. the configuration for `pscode` will end up in `$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`. This behavior can be overwritten by passing the parameter `$RootPath`

## Enable `ssh-agent`

```powershell
Set-Service ssh-agent -StartupType Automatic
ssh-add ~/.ssh/key
```
