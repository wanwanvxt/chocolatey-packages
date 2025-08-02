$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://files2.freedownloadmanager.org/6/latest/fdm_x86_setup.exe'
  url64          = 'https://files2.freedownloadmanager.org/6/latest/fdm_x64_setup.exe'
  softwareName   = 'Free Download Manager'
  checksum       = 'aca9718dc2d77224dcf9f8e530162d51150865d49e5a2b1b7da1bee515dc2eed'
  checksumType   = 'sha256'
  checksum64     = '167012f1720f5450588ac4c29db3799427498663fcba21a6ed64bf15ed4d2c5f'
  checksumType64 = 'sha256'
  silentArgs     = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs