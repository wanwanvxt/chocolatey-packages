$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/odin-lang/Odin/releases/download/dev-2025-04/odin-windows-amd64-dev-2025-04.zip'
$archiveChecksum = '3A12A57880A7FE63DE0363B6930CDD02E624FDB955C1308C23D888E5AC7B135B'
$unzipLocation = Join-Path -Path (Get-ToolsLocation) -ChildPath $packageName

Install-ChocolateyZipPackage -PackageName $packageName `
                              -UnzipLocation $unzipLocation `
                              -Url $url `
                              -Checksum $archiveChecksum `
                              -ChecksumType 'sha256'

$exePath = Join-Path -Path $unzipLocation -ChildPath 'odin.exe'
Install-BinFile -Name 'odin' -Path $exePath