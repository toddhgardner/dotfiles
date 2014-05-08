# Presumes we are in HOME\dotfiles
# Must be run as administrator

Import-Module pscx
New-Symlink 	"..\..\AppData\Roaming\ConEmu.xml"		        "..\conemu.xml"
New-Symlink 	"..\..\.gitconfig"								"..\.gitconfig"

New-Junction 	"..\..\Documents\WindowsPowerShell"				"..\powershell"
