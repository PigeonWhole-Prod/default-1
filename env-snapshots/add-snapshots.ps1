<#
.SYNOPSIS
  Captures local environment details for reproducing issues.
.PARAMETER OutDir
  Output directory. Defaults to the directory containing this script.
#>
[CmdletBinding()]
param(
  [string]$OutDir = $PSScriptRoot
)

$ErrorActionPreference = 'Stop'
if (-not $OutDir) { $OutDir = Join-Path (Get-Location) 'env-snapshots' }
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

function Save-Command {
  param([string]$Name, [string]$Path, [scriptblock]$Script)
  if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
    "$Name not available" | Out-File -FilePath $Path -Encoding utf8
    return
  }
  try { & $Script 2>&1 | Out-File -FilePath $Path -Encoding utf8 }
  catch { "$Name failed: $($_.Exception.Message)" | Out-File -FilePath $Path -Encoding utf8 }
}

function Get-ToolVersion {
  param([string]$Name, [string[]]$VersionArgs = @('--version'))
  if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) { return $null }
  try { (& $Name @VersionArgs 2>&1 | Select-Object -First 1).ToString() } catch { $null }
}

Save-Command 'nvidia-smi' (Join-Path $OutDir "nvidia-smi-$stamp.txt") { nvidia-smi -q }
Save-Command 'winget' (Join-Path $OutDir "winget-list-$stamp.txt") { winget list }
Save-Command 'wsl' (Join-Path $OutDir "wsl-list-$stamp.txt") { wsl -l -v }
Save-Command 'pip' (Join-Path $OutDir "pip-freeze-$stamp.txt") { pip freeze }
Save-Command 'npm' (Join-Path $OutDir "npm-ls-$stamp.txt") { npm ls --depth=0 }

$driverLog = Join-Path $OutDir "driver-list-$stamp.txt"
if (Get-Command Get-CimInstance -ErrorAction SilentlyContinue) {
  try {
    Get-CimInstance -ClassName Win32_PnPSignedDriver |
      Where-Object { $_.DeviceClass -in @('DISPLAY', 'SYSTEM') } |
      Select-Object DeviceName, DriverVersion, Manufacturer, DriverDate |
      Format-Table -AutoSize | Out-String -Width 200 |
      Out-File -FilePath $driverLog -Encoding utf8
  } catch { "Get-CimInstance failed: $($_.Exception.Message)" | Out-File -FilePath $driverLog -Encoding utf8 }
} else {
  'Get-CimInstance not available' | Out-File -FilePath $driverLog -Encoding utf8
}

$gitCommit = $null
if (Get-Command git -ErrorAction SilentlyContinue) {
  try { $gitCommit = (git -C $PSScriptRoot rev-parse HEAD 2>$null) } catch { }
}
$os = $null
try { $os = Get-CimInstance -ClassName Win32_OperatingSystem } catch { }

[ordered]@{
  timestamp         = (Get-Date).ToString('o')
  powershell        = $PSVersionTable.PSVersion.ToString()
  osCaption         = $os.Caption
  osVersion         = $os.Version
  osBuild           = $os.BuildNumber
  architecture      = $env:PROCESSOR_ARCHITECTURE
  gitCommit         = $gitCommit
  pythonVersion     = Get-ToolVersion 'python'
  nodeVersion       = Get-ToolVersion 'node'
  npmVersion        = Get-ToolVersion 'npm'
} | ConvertTo-Json | Out-File -FilePath (Join-Path $OutDir "env-metadata-$stamp.json") -Encoding utf8

Write-Host "Snapshots saved to $OutDir"
