# https://stackoverflow.com/a/37715242/1110628
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

function .. { Set-Location .. }
function ... { Set-Location ..\.. }
function .... { Set-Location ..\..\.. }
function ..... { Set-Location ..\..\..\.. }

function dp { docker ps }
function de { docker exec -it }

New-Alias grep findstr

function Test-Admin {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function prompt {
    $origLastExitCode = $LastExitCode
    
    $user = $env:USERNAME
    $device = $env:COMPUTERNAME
    $currentPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path
    if ($currentPath.ToLower().StartsWith($Home.ToLower()))
    {
        $currentPath = "~" + $currentPath.SubString($Home.Length)
    }
    $dateTime = $(Get-Date).ToString("yyyy-MM-dd HH:mm:ss")

    $prompt = ""

    if (Test-Admin) {
        $prompt += Write-Prompt "⦿ " -ForegroundColor Red
    }

    $prompt += Write-Prompt "[" -ForegroundColor White
    $prompt += Write-Prompt $dateTime -ForegroundColor Green
    $prompt += Write-Prompt "]" -ForegroundColor White

    $prompt += Write-Prompt " (" -ForegroundColor DarkBlue
    $prompt += Write-Prompt $user -ForegroundColor White
    $prompt += Write-Prompt "@" -ForegroundColor DarkCyan
    $prompt += Write-Prompt $device -ForegroundColor White
    $prompt += Write-Prompt ") " -ForegroundColor DarkBlue

    $prompt += Write-Prompt $currentPath -ForegroundColor DarkMagenta

    $prompt += Write-VcsStatus

    $prompt += Write-Prompt "`n$('$' * ($nestedPromptLevel + 1))"

    $LastExitCode = $origLastExitCode
    # return something so make sure we don't get default prompt
    " "
}

Import-Module posh-git
Import-Module oh-my-posh
Import-Module PSColor

Set-Theme Robbyrussell
