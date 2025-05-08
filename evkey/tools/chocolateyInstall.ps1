$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/lamquangminh/EVKey/releases/download/Release/EVKey.zip'
$archiveChecksum = '9671472133e5561eeff67ad7237c927d2acaa779e158c02c97d1504deee46734'
$unzipLocation = Join-Path -Path (Get-ToolsLocation) -ChildPath $packageName

Install-ChocolateyZipPackage -PackageName $packageName `
                              -UnzipLocation $unzipLocation `
                              -Url $url `
                              -Checksum $archiveChecksum `
                              -ChecksumType 'sha256'

$pp = Get-PackageParameters

$executables = @(
  @{ Name = 'evkau'; Display = 'EVKey Updater' },
  @{ Name = 'EVKey32'; Display = 'EVKey 32-bit' },
  @{ Name = 'EVKey64'; Display = 'EVKey 64-bit' }
)

foreach ($exe in $executables) {
  $exePath = Join-Path $unzipLocation "$($exe.Name).exe"
  $linkName = "$($exe.Display).lnk"

  if (!$pp.NoDesktopShortcut) {
    $desktopDir = [Environment]::GetFolderPath([Environment+SpecialFolder]::DesktopDirectory)
    $shortcutPath = Join-Path $desktopDir $linkName
    Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $exePath -ErrorAction SilentlyContinue
  }

  if (!$pp.NoProgramsShortcut) {
    $programsDir = [Environment]::GetFolderPath([Environment+SpecialFolder]::Programs)
    $evkeyFolder = Join-Path $programsDir 'EVKey'
    New-Item -Path $evkeyFolder -ItemType Directory -Force | Out-Null
    $shortcutPath = Join-Path $evkeyFolder $linkName
    Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $exePath -ErrorAction SilentlyContinue
  }
}

if ($pp.Start) {
  try {
    if (Get-ProcessorBits -Compare '64') {
      $startTarget = Join-Path $unzipLocation 'EVKey64.exe'
      Start-Process -FilePath $startTarget -ErrorAction Continue
    } else {
      $startTarget = Join-Path $unzipLocation 'EVKey32.exe'
      Start-Process -FilePath $startTarget -ErrorAction Continue
    }
  }
  catch {
    Write-Warning "EVKey failed to start, please run it manually."
  }
}