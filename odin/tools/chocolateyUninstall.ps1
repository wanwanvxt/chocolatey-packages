$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$unzipLocation = Join-Path -Path (Get-ToolsLocation) -ChildPath $packageName
Remove-Item -Path $unzipLocation -Recurse -Force -ErrorAction SilentlyContinue
Uninstall-BinFile -Name 'odin'