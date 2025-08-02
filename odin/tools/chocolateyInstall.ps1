$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/odin-lang/Odin/releases/download/dev-2025-07/odin-windows-amd64-dev-2025-07.zip'
$archiveChecksum = '749db2ec3438f0eb3a05d1cb89cb071b83c96a072960e27c21f3a3d2590df500'
$unzipLocation = Join-Path -Path (Get-ToolsLocation) -ChildPath $packageName

Install-ChocolateyZipPackage -PackageName $packageName `
                              -UnzipLocation $unzipLocation `
                              -Url $url `
                              -Checksum $archiveChecksum `
                              -ChecksumType 'sha256'

$exePath = Join-Path -Path $unzipLocation -ChildPath 'odin.exe'
Install-BinFile -Name 'odin' -Path $exePath