# Presumes we are in HOME\dotfiles
# Must be run as administrator

Import-Module 	"..\powershell\module\Pscx"

New-Symlink 	"..\..\AppData\Roaming\ConEmu.xml"		        "..\conemu.xml"
New-Symlink 	"..\..\.gitconfig"								            "..\.gitconfig"
New-Symlink 	"..\..\AppData\Roaming\Notepad++\config.xml"             "..\notepad++.xml"

New-Junction 	"..\..\Documents\WindowsPowerShell"				    "..\powershell"

New-Junction 	"..\..\Documents\Visual Studio 2012\Settings" "..\vs2012"