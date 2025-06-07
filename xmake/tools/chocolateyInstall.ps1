$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/xmake-io/xmake/releases/download/v2.9.9/xmake-v2.9.9.win32.exe'
  url64          = 'https://github.com/xmake-io/xmake/releases/download/v2.9.9/xmake-v2.9.9.win64.exe'
  softwareName   = 'xmake'
  checksum       = '93DA7A5DEB261FC10970C30FB71FDFAE58390E390B369C7B4E6C1269ACD94B5B'
  checksumType   = 'sha256'
  checksum64     = '934BEB6995D87BF902FD9C9B73A4E72B13CFD80AD73EF3BEF3050E83A2E931D6'
  checksumType64 = 'sha256'
  silentArgs     = "/S"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs