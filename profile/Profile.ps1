Import-Module $PSScriptRoot\functions.psm1
. $PSScriptRoot\variables.ps1

New-Alias cdworkspace fCdWorkspace -Force -Scope Global -Description "sets the current location to workspaces"
New-Alias mcv fMCV -Force -Scope Global -Description "executes maven clean verify"
New-Alias bsync fBsync -Force -Scope Global -Description "starts browser-sync"
#New-Alias np "$($notepadHome)\notepad++.exe" -Force
