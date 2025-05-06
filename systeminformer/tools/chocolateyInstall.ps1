$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe'
  url           = 'https://github.com/winsiderss/si-builds/releases/download/3.2.25011/systeminformer-3.2.25011-release-setup.exe'
  softwareName  = 'System Informer'
  checksum      = '7612D5E44A5A392AB9F0D1B5B8A79BDA3CDBE19848E8EE9EC23909AAF3DAAD45'
  checksumType  = 'sha256'
  silentArgs    = "-silent"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs