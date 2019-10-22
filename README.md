# Dotfiles for Windows

`stow.ps1` contains a best guess implementation of what GNU stow does on Linux. For it to work properly, checkout this repo to `$HOME/.dotfiles`, then `cd` into it and

```ps
Import-Module .\stow.ps1
Set-DotfileLink -Tools vscode pscore git
```
