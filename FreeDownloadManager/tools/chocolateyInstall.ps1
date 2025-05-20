$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://files2.freedownloadmanager.org/6/latest/fdm_x86_setup.exe'
  url64          = 'https://files2.freedownloadmanager.org/6/latest/fdm_x64_setup.exe'
  softwareName   = 'Free Download Manager'
  checksum       = 'aca9718dc2d77224dcf9f8e530162d51150865d49e5a2b1b7da1bee515dc2eed'
  checksumType   = 'sha256'
  checksum64     = '9f59595d7d79650e1fd9ee86c3e115e4ae336e14596f11f6e3a7807135a55170'
  checksumType64 = 'sha256'
  silentArgs     = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs