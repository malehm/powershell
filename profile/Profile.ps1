Import-Module $PSScriptRoot\functions.psm1
. $PSScriptRoot\variables.ps1

New-Alias cdworkspace fCdWorkspace -Force -Scope Global -Description "sets the current location to workspaces"
New-Alias mcv fMCV -Force -Scope Global -Description "executes maven clean verify"
#New-Alias bsync "browser-sync start -s src -f src -b `"opera`" --no-notify" -Force -Scope Global
#New-Alias np "$($notepadHome)\notepad++.exe" -Force
