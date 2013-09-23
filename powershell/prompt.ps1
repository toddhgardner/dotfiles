# Powershell Prompt

# Vim-style shorten-path originally from Tomas Restrepo
# https://github.com/tomasr
function get-vimShortPath([string] $path) {
   $loc = $path.Replace($HOME, '~')
   $loc = $loc.Replace($env:WINDIR, '[Windows]')
   # remove prefix for UNC paths
   $loc = $loc -replace '^[^:]+::', ''
   # make path shorter like tabs in Vim,
   # handle paths starting with \\ and . correctly
   return ($loc -replace '\\(\.?)([^\\])[^\\]*(?=\\)','\$1$2')
}


function get-isAdminUser() {
  $id = [Security.Principal.WindowsIdentity]::GetCurrent()
  $wp = new-object Security.Principal.WindowsPrincipal($id)
  return $wp.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}


$global:promptTheme = @{
  prefixColor = [ConsoleColor]::Cyan
  pathColor = [ConsoleColor]::Cyan
  pathBracesColor = [ConsoleColor]::DarkCyan
  hostNameColor = ?: { get-isAdminUser } { [ConsoleColor]::Red } { [ConsoleColor]::Green }
}


function global:prompt {
  $realLASTEXITCODE = $LASTEXITCODE
  $prefix = [char]0x221e + " "
  $hostName = [net.dns]::GetHostName().ToLower()
  $shortPath = get-vimShortPath(get-location)

  # Reset color, which can be messed up by Enable-GitColors
  $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor
  
  write-host $prefix -noNewLine -foregroundColor $promptTheme.prefixColor
  write-host $hostName -noNewLine -foregroundColor $promptTheme.hostNameColor
  write-host ' {' -noNewLine -foregroundColor $promptTheme.pathBracesColor
  write-host $shortPath -noNewLine -foregroundColor $promptTheme.pathColor
  write-host '}' -noNewLine -foregroundColor $promptTheme.pathBracesColor
  write-vcsStatus # from posh-git, posh-hg and posh-svn
  
  $global:LASTEXITCODE = $realLASTEXITCODE
  
  return ' '
}


Enable-GitColors