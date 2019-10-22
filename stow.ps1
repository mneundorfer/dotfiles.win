function Set-DotfileLink() {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string[]]
        $Tools
    )

    process {
        $Tools | ForEach-Object {
            $name = $_.Replace("\", "").Replace(".", "");
            Get-ChildItem -Recurse $_ | ForEach-Object {
                # Attention: We are shadowing the outer $_ here...
                if (-Not ($_ -is [System.IO.DirectoryInfo])) {
                    $x = $HOME + $_.FullName.Replace($PSScriptRoot, "").Remove(0, $name.Length + 1);
                    "Found file $_. Linking to $x ..."
                    New-Item -Path $x -ItemType SymbolicLink -Value $_
                }
            }
        }
    }
}
