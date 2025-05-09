$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$unzipLocation = Join-Path -Path (Get-ToolsLocation) -ChildPath $packageName
$sharedLibDir = Join-Path -Path $unzipLocation -ChildPath 'shared'

Get-ChildItem -Path $unzipLocation | Where-Object { $_.FullName -ne $sharedLibDir } | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue