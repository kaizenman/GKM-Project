[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Download latest dotnet/codeformatter release from github
$repo = "kaizenman/GKM-Project"
$file = "app-release.apk"
$name = "app-release.apk"

$releases = "https://api.github.com/repos/$repo/releases"

Write-Host Determining latest release
$tag = (Invoke-WebRequest $releases -UseBasicParsing | ConvertFrom-Json)[0].tag_name

$download = "https://github.com/$repo/releases/download/$tag/$file"

Write-Host $download
Invoke-WebRequest $download -Out $name -UseBasicParsing

$DOCDIR = (Resolve-Path .\).Path
$command = $DOCDIR+"\update_apk.bat"
Start-Process $command


#$name = $file.Split(".")[0]

#Write-Host Dowloading latest release

#Write-Host $name
# Invoke-WebRequest $download -Out $name -UseBasicParsing


#Expand-Archive -Path $zip -Force -DestinationPath  .\".latest"
#del $zip -Force