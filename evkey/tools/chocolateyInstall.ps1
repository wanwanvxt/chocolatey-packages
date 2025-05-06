$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/lamquangminh/EVKey/releases/download/Release/EVKey.zip'
$archiveChecksum = '4f1adbd4875cf224180132fcf63ea08a'
$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$archiveFilePath = Join-Path -Path $toolsDir -ChildPath 'EVKey.zip'
$unzipLocation = Join-Path -Path (Get-ToolsLocation) -ChildPath $packageName

Get-ChocolateyWebFile -PackageName $packageName `
                      -FileFullPath $archiveFilePath `
                      -Url $url `
                      -Checksum $archiveChecksum `
                      -ChecksumType 'md5'

$pp = Get-PackageParameters
Get-ChocolateyUnzip -PackageName $packageName `
                    -FileFullPath $archiveFilePath `
                    -unzipLocation $unzipLocation

Remove-Item -Path $archiveFilePath -Force -ErrorAction SilentlyContinue

$executables = @(
  @{ Name = 'evkau'; Display = 'EVKey Updater' },
  @{ Name = 'EVKey32'; Display = 'EVKey 32-bit' },
  @{ Name = 'EVKey64'; Display = 'EVKey 64-bit' }
)

foreach ($exe in $executables) {
  $exePath = Join-Path $unzipLocation "$($exe.Name).exe"
  $linkName = "$($exe.Display).lnk"
  $shimName = $exe.Name

  if (!$pp.NoShim) {
    Install-BinFile -Name $shimName -Path $exePath -UseStart
  }

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