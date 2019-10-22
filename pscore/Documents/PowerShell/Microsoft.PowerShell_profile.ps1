Import-Module posh-git
Import-Module PSColor

# https://stackoverflow.com/a/37715242/1110628
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

function .. { Set-Location .. }
function ... { Set-Location ..\.. }
function .... { Set-Location ..\..\.. }
function ..... { Set-Location ..\..\..\.. }
