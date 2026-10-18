# session-002-apply-updates-and-verify

This session continues from the Windows restart diagnosis and focuses on bringing the PC to a known-good state for working on the project.

Run the steps below (as Administrator where indicated). Paste command outputs or attach logs into this file or reply here, and I will analyze and provide follow-ups.

OBJECTIVE
- Fully update Windows and drivers
- Update firmware/BIOS if available
- Install project tooling and dependencies (generic steps provided)
- Verify repository can be cloned and built (if applicable)

PREREQUISITES
- An admin account on the PC
- Internet connection

STEPS

1) Windows Update (GUI)
- Settings → Update & Security → Windows Update → Check for updates
- Install all available updates and reboot as prompted

If you prefer PowerShell (Admin):
- Install/update the PSWindowsUpdate module and run the update sequence:
  Install-Module -Name PSWindowsUpdate -Force -AllowClobber
  Get-WindowsUpdate -AcceptAll -Install -AutoReboot

Paste the Windows Update result or note whether a reboot happened and whether updates succeeded.


2) Update device drivers
- Recommended: use vendor utilities (Intel Driver & Support Assistant, NVIDIA GeForce Experience, AMD Radeon Software, or your laptop vendor's updater)

Device Manager method (manual):
- devmgmt.msc → expand categories → right-click device → Update driver → Search automatically for drivers

PowerShell to list major drivers and dates:
Get-WmiObject Win32_PnPSignedDriver | Where-Object { $_.DeviceClass -in @("Display","System","DiskDrive","Net") } | Select DeviceName,DriverVersion,Manufacturer,DriverDate | Format-Table -AutoSize

Paste the driver list and confirm which vendors you updated drivers from.


3) BIOS / firmware
- Check your PC/laptop vendor site for BIOS/UEFI updates. If one exists, follow vendor instructions (do not interrupt power during update).
- If unsure, paste your model and BIOS version here and I’ll look up the vendor instructions.

Command to show BIOS version:
wmic bios get smbiosbiosversion,serialnumber,manufacturer,name

Paste the output here.


4) Storage health & system file checks (run after updates)
- Check disk health (SMART): install CrystalDiskInfo (GUI) or run PowerShell/WMIC quick check:
  wmic diskdrive get model,status

- Run SFC and DISM if you haven't already (Admin):
  sfc /scannow
  Dism /Online /Cleanup-Image /RestoreHealth

Paste results.


5) Install common dev tools (pick according to project needs)
- Git: https://git-scm.com/download/win
- Node.js (LTS) if project uses JavaScript/Node: https://nodejs.org/en/download/
- Python 3.11+ if project uses Python: https://www.python.org/downloads/
- Visual Studio / Build Tools if native builds are required: https://visualstudio.microsoft.com/downloads/
- Docker Desktop if containerized: https://www.docker.com/get-started

If you want, I can add one-line installers via Chocolatey. Example (Admin PowerShell):
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install git nodejs-lts python visualstudio2019buildtools -y

List which tools you need and I will provide exact commands.


6) Clone the project and verify
- Clone the repo (choose a working directory):
  git clone https://github.com/PigeonWhole-Prod/default-1.git
  cd default-1

- If the project has a README build/test steps, run them. For example, if Node:
  npm install
  npm test

- If there are no build steps, at minimum confirm git status and latest commit:
  git status --porcelain
  git log -n 3 --oneline

Paste the clone output and the git status/log outputs.


7) Create a snapshot of the environment (useful for reproducibility)
- Create a Packages/Tools list:
  # Installed programs (winget)
  winget list > %USERPROFILE%\desktop\installed-packages.txt

- List installed chocolatey packages (if used):
  choco list --local-only > %USERPROFILE%\desktop\choco-packages.txt

Attach these files or paste their content.


8) Final verification checklist
- Windows fully updated: YES / NO
- Drivers updated: YES / NO (list which)
- BIOS updated: YES / NO
- SFC/DISM: clean / repaired / failed
- Project cloned and built: YES / NO (paste errors)


---

After you run the steps, paste outputs here. I will analyze and: recommend targeted driver/firmware updates, provide commands to install missing tooling, and, if the project build fails, produce a focused debugging checklist.
