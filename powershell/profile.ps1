

$dotfiles = resolve-path ~/dotfiles/


# MODULE
$modulePath = (join-path $dotfiles powershell/modules)

Import-Module "PowerTab"
Import-Module "posh-git"
Import-Module "posh-hg"
Import-Module "posh-svn"


# SCRIPT




# ALIAS