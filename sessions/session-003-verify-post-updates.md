# session-003-verify-post-updates

Continues from session-002-apply-updates-and-verify. This session picks up after updates, driver and BIOS checks and focuses on deeper verification, reproducible environment capture, and resolving any remaining build or runtime issues.

OBJECTIVE
- Confirm system is in a known-good state after updates
- Reproduce and fix any remaining project build/run failures
- Capture environment and logs for reproducibility and future troubleshooting

PREREQUISITES
- Completed steps in sessions/session-002-apply-updates-and-verify.md
- Admin access for elevated commands where indicated

STEPS

1) Confirm Windows update & reboot status
- Paste the final Windows Update output or confirm: "Windows fully updated: YES/NO" and whether a reboot was performed after the last updates.

2) Re-check driver and BIOS versions
- Paste outputs from the earlier driver listing command and BIOS query if available.
- Driver list command (PowerShell):
  Get-WmiObject Win32_PnPSignedDriver | Where-Object { $_.DeviceClass -in @("Display","System","DiskDrive","Net") } | Select DeviceName,DriverVersion,Manufacturer,DriverDate | Format-Table -AutoSize
- BIOS query:
  wmic bios get smbiosbiosversion,serialnumber,manufacturer,name

3) Storage and system file health (confirm results)
- Paste outputs for:
  wmic diskdrive get model,status
  sfc /scannow
  Dism /Online /Cleanup-Image /RestoreHealth

4) Environment snapshot (required)
- Capture installed packages and environment into the repo (or attach files):
  winget list > %USERPROFILE%\desktop\installed-packages.txt
  choco list --local-only > %USERPROFILE%\desktop\choco-packages.txt
  (If using Python) pip freeze > %USERPROFILE%\desktop\pip-freeze.txt
  (If Node) npm -g ls --depth=0 > %USERPROFILE%\desktop\npm-global.txt

- Attach these files to this session file or paste their content below. If you'd like, I can add them to the repository in a new folder `env-snapshots/` — say "add snapshots to repo" and I will create the files here.

5) Clone & reproduce build/tests
- If you haven't already, clone here (choose working folder):
  git clone https://github.com/PigeonWhole-Prod/default-1.git
  cd default-1

- Re-run the build/test steps. Provide the exact commands you ran and their full output. Example flows:
  - Node:
    npm install
    npm test
  - Python:
    python -m pip install -r requirements.txt
    pytest -q

- If the build fails, paste the full error output. I will analyze and provide targeted fixes (missing packages, path issues, permission errors, dev tools missing).

6) Runtime verification (if applicable)
- If the project runs a server or binary, attempt to run it and capture logs. Example:
  - Start: npm start
  - Check logs or console output; paste errors.

7) Collect diagnostic logs (if issues persist)
- System event logs (Admin PowerShell):
  wevtutil qe System /c:50 /f:text > %USERPROFILE%\desktop\system-events.txt
- Application logs (adjust channel if needed):
  wevtutil qe Application /c:50 /f:text > %USERPROFILE%\desktop\application-events.txt

- GPU/driver logs (if applicable):
  - Attach driver vendor logs (NVIDIA/AMD/Intel) or paste notable errors.

8) Next-action decision tree (I'll perform these after you paste outputs)
- If SFC/DISM repaired files: re-run builds and confirm.
- If drivers cause crashes: recommend specific vendor driver version or rollback.
- If build tools missing: provide one-line installers and repeat build commands.
- If tests fail with code errors: create a focused issue and propose a code patch.

9) Optional: add session snapshot to repo
- Reply with "add snapshot" plus the file paths (from desktop output) and I will add them to `env-snapshots/` in the repository.

FINAL CHECKLIST (paste answers inline)
- Windows fully updated: YES / NO
- Reboot performed after updates: YES / NO
- Drivers updated: YES / NO (list which)
- BIOS updated: YES / NO
- SFC/DISM: clean / repaired / failed
- Project cloned and built: YES / NO (paste errors or success logs)
- Attachments added to session: list files or say NONE

---

When you paste outputs or attach snapshot files, I will analyze them and either:
- Provide a short remediation plan (driver/firmware/build fixes), or
- Make changes to the repository (add snapshots, create an issue, or add a small build script) if you ask me to.
