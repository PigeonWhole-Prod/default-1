# env-snapshots

`add-snapshots.ps1` captures local environment details to help reproduce build/test issues.

## What it captures
Timestamped files (`<name>-YYYYMMDD-HHMMSS.*`) written to this folder:

- `nvidia-smi-*.txt` – GPU details (`nvidia-smi -q`)
- `driver-list-*.txt` – display/system drivers (via `Get-CimInstance Win32_PnPSignedDriver`)
- `winget-list-*.txt` – installed applications
- `wsl-list-*.txt` – WSL distributions
- `pip-freeze-*.txt`, `npm-ls-*.txt` – Python / top-level npm packages
- `env-metadata-*.json` – OS version, PowerShell/Python/Node/npm versions, architecture, git commit

Missing tools are tolerated; the corresponding file just records that the tool is unavailable.

## Run
```powershell
pwsh .\env-snapshots\add-snapshots.ps1
# or choose another location
pwsh .\env-snapshots\add-snapshots.ps1 -OutDir C:\temp\snapshots
```
By default output goes to this folder regardless of the current directory. The script is read-only with respect to your system.

## Privacy
Snapshots list installed software, hardware, drivers and system configuration, and may include machine-identifying details. Review before sharing.

- `.gitignore` excludes `env-snapshots/*.txt`. **Do not commit** snapshots, and note it does not exclude `env-metadata-*.json`; don't commit those either.
- Do not attach snapshots to public issues without redacting sensitive information.

## CI
`.github/workflows/verify-on-pr.yml` does not run this script. It uploads any snapshot files present in the checkout as artifacts only if they exist (they are normally not committed).
