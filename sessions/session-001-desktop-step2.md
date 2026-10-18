# Session 001 — Desktop verification

Date: 2026-10-18

## Step 1 result

Administrator PowerShell output:

```powershell
PS C:\WINDOWS\system32> wsl -l -v
NAME      STATE   VERSION
* Ubuntu   Stopped 2
  docker-desktop  Running 2
```

Result: WSL is installed and the Docker backend distro is available and using WSL version 2.

```powershell
PS C:\WINDOWS\system32> wsl --shutdown
PS C:\WINDOWS\system32>
```

## Step 2 result

Docker Desktop launched successfully and reached the normal "Containers" landing screen without a startup error.

Result: Docker Desktop is running normally after the reboot.

## Step 3 result

Windows PowerShell output:

```powershell
PS C:\WINDOWS\system32> docker version
Client:
 Version:           29.8.2
 API version:       1.56
 Go version:        go1.26.8
 Git commit:        7fc2dff
 Built:             Wed Sep 30 19:35:42 2026
 OS/Arch:           windows/amd64
 Context:           desktop-linux

Server: Docker Desktop 4.95.0 (242831)
 Engine:
  Version:          29.8.2
  API version:      1.56
  Go version:       go1.26.8
  Git commit:       af9fe3
  Built:            Wed Sep 30 19:35:42 2026
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          v2.3.6
 runc:
  Version:          1.5.1
 docker-init:
  Version:          0.19.0
```

```powershell
PS C:\WINDOWS\system32> docker info
Client:
 Version:    29.8.2
 Context:    desktop-linux

Server:
 Containers: 0
 Running: 0
 Paused: 0
 Stopped: 0
 Images: 0
 Server Version: 29.8.2
 Storage Driver: overlayfs
 Operating System: Docker Desktop
 OSType: linux
 Architecture: x86_64
 CPUs: 12
 Total Memory: 15.54GiB
 Name: docker-desktop
```

Result: Docker engine is healthy and running successfully on the desktop system.

## Step 4 result

Windows PowerShell output:

```powershell
PS C:\WINDOWS\system32> docker run --rm hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
...
Hello from Docker!
This message shows that your installation appears to be working correctly.
```

## Step 5 result

Windows PowerShell output (GPU passthrough test):

```powershell
PS C:\WINDOWS\system32> docker pull nvidia/cuda:12.1.1-base-ubuntu22.04
PS C:\WINDOWS\system32> docker run --rm --gpus all nvidia/cuda:12.1.1-base-ubuntu22.04 nvidia-smi
Sun Oct 18 12:22:52 2026
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 575.78.05    Driver Version: 575.78.05    CUDA Version: 13.4 |
|-------------------------------+----------------------+----------------------|
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap| Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
| 0  NVIDIA GeForce RTX 3060  On   00000000:01:00.0  Off | N/A |
| N/A   45C    P8     11W / 85W |  961MiB / 6144MiB |  0% | Default |
+-------------------------------+----------------------+----------------------+
```

Result: GPU is visible inside the container and Docker GPU passthrough is working correctly on the desktop.

## Current status

Desktop is ready for the next step: project container setup and workflow validation.
