# Session 001 — Laptop verification

Date: 2026-10-18

## Step 1 result

Windows PowerShell (Admin):

```powershell
PS C:\WINDOWS\system32> wsl -l -v
NAME      STATE   VERSION
* Ubuntu   Stopped 2
```

Result: Ubuntu WSL distro is installed and using WSL version 2.

## Step 2 result

Ubuntu terminal output:

```bash
dandm@LAPTOP-AHNOH0K7:/mnt/c/WINDOWS/system32$ whoami
dandm
dandm@LAPTOP-AHNOH0K7:/mnt/c/WINDOWS/system32$ hostname
LAPTOP-AHNOH0K7
dandm@LAPTOP-AHNOH0K7:/mnt/c/WINDOWS/system32$ uname -a
Linux LAPTOP-AHNOH0K7 6.8.54.1-microsoft-standard-WSL2 #1 SMP PREEMPT_DYNAMIC Tue Oct 6 19:13:07 UTC 2026 x86_64 x86_64 x86_64 GNU/Linux
dandm@LAPTOP-AHNOH0K7:/mnt/c/WINDOWS/system32$ nvidia-smi
NVIDIA-SMI 575.78.05    Driver Version: 575.78.05    CUDA Version: 13.4
GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
 0   NVIDIA GeForce RTX 3060  On    00000000:01:00.0  Off | N/A
  A2C  P8     12W / 85W  |  2230MiB / 6144MiB |  1% | Default
```

Result: GPU is visible inside WSL and working correctly on the laptop.

## Current status

Laptop is ready for the next step: Docker GPU passthrough test.
