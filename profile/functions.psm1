<#
.SYNOPSIS

executes maven clean verify

.DESCRIPTION

Executes maven clean verify
#>
function fMCV {
    Invoke-Expression -Command "mvn clean verify"
}

<#
.SYNOPSIS

starts browser-sync

.DESCRIPTION

starts browser-sync
#>
function fBsync {
    Start-Process -FilePath "browser-sync" -ArgumentList "start -s src -f src -b `"opera`" --no-notify"
}

<#
.SYNOPSIS

Sets the current location to workspaces.

.DESCRIPTION

Sets the current location to workspaces.
#>
function fCdWorkspace {
    if($workspaces){
        Set-Location $workspaces
    }else{
        "Variable `$workspaces not set"
    }
}

<#
.SYNOPSIS

Starts eclipse

.DESCRIPTION

Starts eclipse with the provided workspace. If no workspace is provided eclipse is startet without workspace.

.PARAMETER wsPath
Path to the workspace

.EXAMPLE

C:\PS> eclipse c:\workspaces\myWorkspace
#>
function eclipse {
    param([String] $wsPath)
    if(!$eclipseHome){
        "Variable `$eclipseHome not set"
        return
    }
    if($wsPath){
        & "$($eclipseHome)\eclipse.exe" -data "`"$($wsPath)`"" *> $null
    }else{
        & "$($eclipseHome)\eclipse.exe" *> $null
    }
}

<#
.SYNOPSIS

Starts vsCode

.DESCRIPTION

Starts vsCode with the provided workspace. If no workspace is provided vsCode is startet without workspace.

.PARAMETER wsPath
Path to the workspace

.EXAMPLE

C:\PS> code c:\workspaces\myWorkspace
#>
function code {
    param([String] $wsPath)
    if(!$vsCodeHome){
        "Variable `$vsCodeHome not set"
        return
    }
    if(!$wsPath){
        $wsPath = "."
    }
    & "$($vsCodeHome)\Code.exe" "$wsPath" *> $null
}

<#
.SYNOPSIS

Compares hashcode of file against provided hashcode

.DESCRIPTION

Compares the hashcode of the provided file against the provided hashcode

.PARAMETER file

Path to file to generate hashcode from

.PARAMETER expectedHash

The expected hashcode of the file

.PARAMETER algorithm

The algorithm used to compute the hash. The default is SHA512

.EXAMPLE

PS C:\Users\user> hash .\log-camel-lsp.out 123
hashes are not identical
hash of file:  '965C0F1A3315019CD1703C30014D2CA6158D74DE693C356A7E918BB1D6963EA5'
expected hash: '123'

.EXAMPLE

PS C:\Users\user> hash .\log-camel-lsp.out 965C0F1A3315019CD1703C30014D2CA6158D74DE693C356A7E918BB1D6963EA5
hashes are identical
hash of file:  '965C0F1A3315019CD1703C30014D2CA6158D74DE693C356A7E918BB1D6963EA5'
expected hash: '965C0F1A3315019CD1703C30014D2CA6158D74DE693C356A7E918BB1D6963EA5'

#>
function hash {
    param(
        [Parameter(Mandatory=$true)][String] $file, 
        [Parameter(Mandatory=$true)][String] $expectedHash,
        [String][ValidateSet("SHA1","SHA256", "SHA384", "SHA512", "MACTripleDES", "MD5", "RIPEMD160")] $algorithm = "SHA512"
    )
    $expectedHash = $expectedHash.ToUpper()
    $actualHash = (Get-FileHash "$file" -Algorithm $algorithm).hash
    if ($actualHash -eq $expectedHash) {
        "hashes are identical"
    } else {
        "hashes are not identical"
    }
    "hash of file:  '$actualHash'"
    "expected hash: '$expectedHash'"
}