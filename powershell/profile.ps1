# Global Powershell Profile

$powershell = (join-path $env:USERPROFILE dotfiles/powershell)

# Environment Variables
$global:PSDefaultModulePath = $env:PSModulePath
$modulePath = (join-path $powershell module)
$env:PSModulePath = $modulePath + ";" + $env:PSModulePath

$scriptPath = (join-path $powershell script)
Add-PathVariable $scriptPath


# Powershell Modules
Import-Module Pscx
Import-Module "posh-git"
#Import-Module "posh-hg"


# Profile Extensions
. (join-path $powershell alias.ps1)
. (join-path $powershell coloredDirWithSize.ps1)
. (join-path $powershell prompt.ps1)