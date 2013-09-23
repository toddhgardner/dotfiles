# Global Powershell Profile

$powershell = resolve-path ~/dotfiles/powershell

# Environment Variables
$global:PSDefaultModulePath = $env:PSModulePath
$modulePath = (join-path $powershell module)
$env:PSModulePath = $modulePath + ";" + $env:PSModulePath

$env:PHANTOMJS_BIN = "phantomjs.exe" #Expect it has been loaded on the path by chocolatey

$scriptPath = (join-path $powershell script)
Add-PathVariable $scriptPath


# Powershell Modules
#Import-Module "Pscx" -Arg (join-path $powershell Pscx.UserPreferences.ps1)
Import-Module "posh-git"
#Import-Module "posh-hg"
#Import-Module "posh-svn"


# Profile Extensions
. (join-path $powershell alias.ps1)
. (join-path $powershell coloredDirWithSize.ps1)
. (join-path $powershell prompt.ps1)