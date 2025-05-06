$ErrorActionPreference = 'Stop'

$executables = @(
  @{ Name = 'evkau'; Display = 'EVKey Updater' },
  @{ Name = 'EVKey32'; Display = 'EVKey 32-bit' },
  @{ Name = 'EVKey64'; Display = 'EVKey 64-bit' }
)

$desktopDir = [Environment]::GetFolderPath([Environment+SpecialFolder]::DesktopDirectory)
$programsDir = [Environment]::GetFolderPath([Environment+SpecialFolder]::Programs)
$evkeyProgramsDir = Join-Path $programsDir 'EVKey'

foreach ($exe in $executables) {
  $shimName = $exe.Name
  $linkName = "$($exe.Display).lnk"

  Uninstall-BinFile -Name $shimName

  $desktopShortcut = Join-Path $desktopDir $linkName
  if (Test-Path -Path $desktopShortcut) {
    Remove-Item -Path $desktopShortcut -Force -ErrorAction SilentlyContinue
  }

  $programsShortcut = Join-Path $evkeyProgramsDir $linkName
  if (Test-Path -Path $programsShortcut) {
    Remove-Item -Path $programsShortcut -Force -ErrorAction SilentlyContinue
  }
}

if (Test-Path -Path $evkeyProgramsDir) {
  $items = Get-ChildItem -Path $evkeyProgramsDir
  if ($items.Count -eq 0) {
    Remove-Item -Path $evkeyProgramsDir -Force -ErrorAction SilentlyContinue
  }
}