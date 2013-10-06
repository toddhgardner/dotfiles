
Import-Module ..\powershell\module\Pscx

# Presumes we are in HOME\dotfiles
New-Junction ..\..\Documents\WindowsPowerShell ..\powershell
New-Junction "..\..\Documents\Visual Studio 2012\Settings" ..\vs2012