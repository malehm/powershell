. $PSScriptRoot\cmdToPs.ps1

#prepare
$commandFile = $PSScriptRoot + "\commandFile.cmd"
Set-Content $commandFile "@echo off`r`n"
Add-Content $commandFile "@rem some properties"
Add-Content $commandFile "set psTestName=hugo"
Add-Content $commandFile "set psTestMail=mail@mail.com"
Add-Content $commandFile "set home=other"
Add-Content $commandFile "set psTestResolvePercent=%JAVA_HOME%"
Add-Content $commandFile "echo the end"

#test
cmdToPs($PSScriptRoot + "\commandFile.cmd")

#assert
if(!($psTestName -eq "hugo")){
    Write-Host "psTestName falsch"
}
if(!($psTestMail -eq "mail@mail.com")){
    Write-Host "psTestMail falsch"
}
if($psTestResolvePercent.contains("%")){
    Write-Host "psTestResolvePercent falsch"
}
if($home -eq "other"){
    Write-Host "home falsch"
}

#cleanup
if(Test-Path "variable:psTestName"){
    Remove-Item "variable:psTestName"
}
if(Test-Path "variable:psTestMail"){
    Remove-Item "variable:psTestMail"
}
if(Test-Path "variable:psTestResolvePercent"){
    Remove-Item "variable:psTestResolvePercent"
}
if(Test-Path $commandFile){
    Remove-Item $commandFile
}