# Uses FTP to pull the contents of a remote site
# into a local zip file
#

# Dependencies:
#  Evernote - Notebook http://evernote.com/
#  7-Zip command line - 7za.exe

param(
    [string] $evernotePath,
    [string] $backupRoot
)

# Create temp directory to download into
$tempDirName = "$(Get-Date -format 'Backup-yyyy-MM-dd-hh-mm-ss')"
$tempDirPath = (Join-Path $env:TEMP $tempDirName)
if (!(Test-Path $tempDirPath))
    { New-Item $tempDirPath -type Directory }
else
    { exit 1 }

# Download the files
& NcFtpGet -R -u $userName -p $password $address $tempDirPath "/"

# Create the zip archive
# $outputPath = (Join-Path $outputDir "$tempDirName.zip")
# Write-Zip -level 5 -IncludeEmptyDirectories -Path $tempDirPath -OutputPath $outputDir

# Create the 7z archive
$outputPath = (Join-Path $outputDir "$tempDirName.7z")
& 7za a -t7z $outputPath $tempDirPath -r -ms=off -mmt=on

# Remove the temp directory
# Remove-Item -Recurse $tempDirPath

# Fin!



$evernotePath = '';
$backupPath = '';
 

 .\ENScript.exe listNotebooks | Foreach { .\ENScript.exe exportNotes /q notebook:$_ /f Z:\$_.enex }