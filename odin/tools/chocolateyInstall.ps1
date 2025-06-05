$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/odin-lang/Odin/releases/download/dev-2025-06/odin-windows-amd64-dev-2025-06.zip'
$archiveChecksum = 'c1fa00f424df047497bbd113a492b3afb19db9dc96d51cc075a10ad904500ff6'
$unzipLocation = Join-Path -Path (Get-ToolsLocation) -ChildPath $packageName

Install-ChocolateyZipPackage -PackageName $packageName `
                              -UnzipLocation $unzipLocation `
                              -Url $url `
                              -Checksum $archiveChecksum `
                              -ChecksumType 'sha256'

$exePath = Join-Path -Path $unzipLocation -ChildPath 'odin.exe'
Install-BinFile -Name 'odin' -Path $exePath