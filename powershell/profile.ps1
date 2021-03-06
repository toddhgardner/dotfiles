# Global Powershell Profile

$powershell = (join-path $env:USERPROFILE Documents/WindowsPowershell)

# Environment Variables
$global:PSDefaultModulePath = $env:PSModulePath
$modulePath = (join-path $powershell module)
$env:PSModulePath = $modulePath + ";" + $env:PSModulePath

$env:PHANTOMJS_BIN = "phantomjs.exe" #Expect it has been loaded on the path by chocolatey
$env:CHROME_BIN = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
$env:FIREFOX_BIN = "C:\Program Files (x86)\Mozilla Firefox\firefox.exe"

$scriptPath = (join-path $powershell script)
Add-PathVariable $scriptPath


# Powershell Modules
Import-Module "Pscx" -Arg (join-path $powershell Pscx.UserPreferences.ps1)
Import-Module "posh-git"
Import-Module "posh-hg"
#Import-Module "posh-svn"


# Profile Extensions
. (join-path $powershell alias.ps1)
. (join-path $powershell coloredDirWithSize.ps1)
. (join-path $powershell prompt.ps1)