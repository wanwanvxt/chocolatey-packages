$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file = Join-Path $toolsDir 'fdm_x86_setup.exe'
$file64 = Join-Path $toolsDir 'fdm_x64_setup.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  file           = $file
  file64         = $file64
  softwareName   = 'Free Download Manager'
  checksum       = 'aca9718dc2d77224dcf9f8e530162d51150865d49e5a2b1b7da1bee515dc2eed'
  checksumType   = 'sha256'
  checksum64     = '3e017e3b6efec76c0716afaa673745682d038cba81bb768cc8a65e05bd911361'
  checksumType64 = 'sha256'
  silentArgs     = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs -SkipShim
Remove-Item -Path $file -ErrorAction Ignore -Force
Remove-Item -Path $file64 -ErrorAction Ignore -Force