$ErrorActionPreference = 'Stop'
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$outDir = Join-Path (Get-Location) 'env-snapshots'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$gpuLog = Join-Path $outDir "nvidia-smi-$stamp.txt"
$driverLog = Join-Path $outDir "driver-list-$stamp.txt"
$wingetLog = Join-Path $outDir "winget-list-$stamp.txt"
$wslLog = Join-Path $outDir "wsl-list-$stamp.txt"

try { nvidia-smi -q | Out-File -FilePath $gpuLog -Encoding utf8 } catch { 'nvidia-smi not available' | Out-File -FilePath $gpuLog -Encoding utf8 }
try { Get-WmiObject Win32_PnPSignedDriver | Where-Object { $_.DeviceClass -in @('Display','System') } | Select DeviceName,DriverVersion,Manufacturer,DriverDate | Format-Table -AutoSize | Out-File -FilePath $driverLog -Encoding utf8 } catch { 'Get-WmiObject failed' | Out-File -FilePath $driverLog -Encoding utf8 }
try { winget list | Out-File -FilePath $wingetLog -Encoding utf8 } catch { 'winget not available' | Out-File -FilePath $wingetLog -Encoding utf8 }
try { wsl -l -v | Out-File -FilePath $wslLog -Encoding utf8 } catch { 'wsl not available' | Out-File -FilePath $wslLog -Encoding utf8 }

Write-Host "Snapshots saved to $outDir"
