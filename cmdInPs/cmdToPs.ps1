<#
.SYNOPSIS
Execute windows command file and set variables

.DESCRIPTION
The cmdToPs function executes a windows command file and set the variables set in the
command file as a global powershell variable

.PARAMETER cmdScript
the Path to the windows command file

.EXAMPLE
cmdToPs($PSScriptRoot + "\commandFile.cmd")
#>
function cmdToPs ([String] $cmdScript) {
    if(Test-Path $cmdScript){
        $newScript=$PSScriptRoot + "\newSript.cmd"
        $tempFile=$PSScriptRoot + "\temp.txt"
        #TODO i'm not shure the windows command opens the console under USERPROFILE everytime
        $replace=$env:USERPROFILE + ">set "
        (get-content $cmdScript).Replace("@echo off", "") | Set-Content "$newScript"        
        cmd /c "$newScript" > "$tempFile"
        (get-content "$tempFile").Replace("$replace", "") | Set-Content "$tempFile"

        Get-Content $tempFile | Foreach-Object {
            if($_ -match "^(.*?)=(.*)$"){
                if(!(Test-Path "variable:$($matches[1])")){
                    Set-Item "variable:global:$($matches[1])" "$($matches[2])".TrimEnd()
                }
            }
        }
        Remove-Item $newScript
        Remove-Item $tempFile
    }else{
        Write-Host "file does not exist!"
    }
}