# Windows restart diagnosis session

This session file guides collection of logs and diagnostics after an unexpected restart or BSOD. Run the commands in an elevated PowerShell (right-click PowerShell → Run as Administrator). Paste the command outputs into this file (or attach them) and push or paste back here so I can analyze.

## 1) Capture system summary

Command:
Get-ComputerInfo | Select CsName,WindowsVersion, WindowsBuildLabEx,OsHardwareAbstractionLayer,OsName,OsLocale,OsLanguage

Paste output here:


## 2) List recent critical/errors from System event log (last 6 hours)

Command:
Get-WinEvent -FilterHashtable @{LogName='System'; Level=1,2; StartTime=(Get-Date).AddHours(-6)} | Format-List TimeCreated,ProviderName,Id,Message

Paste the top 20 lines of output here:


## 3) Check for Kernel-Power Event ID 41 or BugCheck

Command (search for 41 or BugCheck):
Get-WinEvent -FilterHashtable @{LogName='System'; StartTime=(Get-Date).AddHours(-24)} | Where-Object { $_.Id -eq 41 -or $_.ProviderName -like '*BugCheck*' } | Format-List TimeCreated,ProviderName,Id,Message

Paste any hits here:


## 4) List minidump files (if BSOD)

Command:
if (Test-Path "C:\Windows\Minidump") { Get-ChildItem C:\Windows\Minidump\*.dmp | Select Name,Length,LastWriteTime | Format-List } else { "No minidump folder found" }

Paste the listing here (or attach filenames):


## 5) Quick Driver and Device checks

Commands:
# List display and chipset drivers
Get-WmiObject Win32_PnPSignedDriver | Where-Object { $_.DeviceClass -in @("Display", "System") } | Select DeviceName,DriverVersion,Manufacturer,DriverDate | Format-Table -AutoSize

# List recently installed updates (last 30 days)
Get-HotFix | Where-Object { $_.InstalledOn -gt (Get-Date).AddDays(-30) } | Select Source,Description,HotFixID,InstalledOn | Format-Table -AutoSize

Paste outputs here:


## 6) Run SFC and DISM (may take a while)

Commands:
# System File Checker
sfc /scannow

# DISM health check and restore
Dism /Online /Cleanup-Image /CheckHealth
Dism /Online /Cleanup-Image /ScanHealth
Dism /Online /Cleanup-Image /RestoreHealth

Paste any errors/warnings and the final status messages here.


## 7) Disk check suggestion (schedule on next reboot if needed)

Command to schedule check on C: (will run at reboot):
chkdsk C: /f

If you prefer, run: chkdsk C: /f /r (longer)


## 8) Optional: collect system reliability history (GUI) and diagnostics

- Open Reliability Monitor: Control Panel → Security and Maintenance → Reliability Monitor. Save the report or copy the events around the crash time.

- Optionally, run WhoCrashed (third-party) to analyze minidumps and paste its report.


---

After you run commands, paste the outputs into this file or reply here with them. I will analyze and give next steps (drivers to update, which minidump to analyze in detail, or hardware checks).