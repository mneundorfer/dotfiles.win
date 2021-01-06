function Set-DotfileLink() {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string[]]
        $Tools,
        [Parameter(Mandatory = $false)]
        [string]
        $RootPath=$HOME
    )

    process {
        $Tools | ForEach-Object {
            $name = $_.Replace("\", "").Replace(".", "");
            Get-ChildItem -Recurse $_ | ForEach-Object {
                # Attention: We are shadowing the outer $_ here...
                if (-Not ($_ -is [System.IO.DirectoryInfo])) {
                    $targetPath = $RootPath + $_.FullName.Replace($PSScriptRoot, "").Remove(0, $name.Length + 1);
                    "Found file $_.FullName. Linking to $targetPath ..."
                    New-Item -Force -Path $targetPath -ItemType SymbolicLink -Value $_.FullName
                }
            }
        }
    }
}
