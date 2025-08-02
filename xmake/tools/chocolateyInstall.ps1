$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/xmake-io/xmake/releases/download/v3.0.1/xmake-v3.0.1.win32.exe'
  url64          = 'https://github.com/xmake-io/xmake/releases/download/v3.0.1/xmake-v3.0.1.win64.exe'
  softwareName   = 'xmake'
  checksum       = '7165b6e1709c840d57babcc6ffd20ddfeb30c136ee1fb61dfcc837a63d03d349'
  checksumType   = 'sha256'
  checksum64     = 'c0d21f114d06f1ccbe4941f55e7067ad51b432b31a439ff4c2cc4c733ab868e1'
  checksumType64 = 'sha256'
  silentArgs     = "/S"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs