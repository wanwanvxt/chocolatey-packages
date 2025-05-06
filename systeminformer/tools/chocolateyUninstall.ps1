$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'System Informer'
  fileType      = 'exe'
  silentArgs    = "-silent"
  validExitCodes= @(0)
}

[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

if ($key.Count -eq 1) {
  $key | ForEach-Object {
    $uninstallString = $_.UninstallString.Trim()
    $parts = $uninstallString -split '\s+(?=(?:[^"]*"[^"]*")*[^"]*$)'

    if ($parts.Count -ge 1) {
      $packageArgs['file'] = $parts[0]
      if ($parts.Count -gt 1) {
        $otherArgs = $parts[1..($parts.Count - 1)] -join ' '
        $packageArgs['silentArgs'] = "$otherArgs $($packageArgs['silentArgs'])"
      }
    }

    Uninstall-ChocolateyPackage @packageArgs
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | ForEach-Object {Write-Warning "- $($_.DisplayName)"}
}