$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/odin-lang/Odin/releases/download/dev-2025-08/odin-windows-amd64-dev-2025-08.zip'
$archiveChecksum = 'a48b560e6f24ef5735456794dc9f10c9939d32ccb594fa5cbce0ff46587a66f9'
$unzipLocation = Join-Path -Path (Get-ToolsLocation) -ChildPath $packageName

Install-ChocolateyZipPackage -PackageName $packageName `
                              -UnzipLocation $unzipLocation `
                              -Url $url `
                              -Checksum $archiveChecksum `
                              -ChecksumType 'sha256'

$exePath = Join-Path -Path $unzipLocation -ChildPath 'odin.exe'
Install-BinFile -Name 'odin' -Path $exePath