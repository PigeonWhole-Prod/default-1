# Session 002 — Continue on PC

Date: 2026-10-18

## Current status

Desktop verification is complete and successful.

- WSL 2 is working
- Docker Desktop is running
- Docker hello-world test passed
- GPU passthrough test passed inside a container
- Laptop verification was already recorded in `sessions/session-001-laptop-step2.md`
- Desktop verification was recorded in `sessions/session-001-desktop-step2.md`

## Goal for this session

Continue from the verified environment stage and make sure the repo is safe and ready for the next project-specific workload.

## Step 1 — Confirm repo is cloned locally on the PC

Open PowerShell and run:

```powershell
cd C:\
git --version
```

If Git is not installed, install it from:

https://git-scm.com/download/win

Then clone the repository:

```powershell
git clone https://github.com/PigeonWhole-Prod/default-1.git
cd default-1
```

## Step 2 — Scan for obvious secrets before continuing

Run this from inside the repo:

```powershell
git grep -nE "BEGIN [A-Z ]*PRIVATE KEY|BEGIN OPENSSH PRIVATE KEY|ghp_[A-Za-z0-9]+|sk_live_[A-Za-z0-9]+|AKIA[0-9A-Z]{16,}|aws_access_key|password|secret|token|api[_-]?key" -- .
```

If you want a broader non-git search as well:

```powershell
Select-String -Path . -Pattern "BEGIN [A-Z ]*PRIVATE KEY|BEGIN OPENSSH PRIVATE KEY|ghp_[A-Za-z0-9]+|sk_live_[A-Za-z0-9]+|AKIA[0-9A-Z]{16,}|password|secret|token|api[_-]?key" -Recurse -CaseSensitive
```

Important: do not paste any real secret content into chat. If a match is found, treat it as compromised and remove it immediately.

## Step 3 — Add protection for future commits

If the repo is clean, add the usual ignore patterns:

```powershell
notepad .gitignore
```

Add:

```text
*.pem
*.key
.env
.env.local
id_rsa*
```

Then commit:

```powershell
git add .gitignore
git commit -m "ignore local secrets and key files"
```

## Step 4 — Re-run sanity checks for Docker + GPU

From PowerShell:

```powershell
docker version
docker info
docker run --rm hello-world
docker run --rm --gpus all nvidia/cuda:12.1.1-base-ubuntu22.04 nvidia-smi
```

Expected result: Docker is healthy and GPU is visible inside the container.

## Step 5 — Move to the actual project workload

Once the environment checks pass, decide the next real target:

- project container startup
- model/API service startup
- app run command
- data or inference test

At that point, save the exact output to a new file such as:

- `sessions/session-003-project-start.md`

## Next action

Continue by running Step 1 above on the PC. Then paste the output of the repo scan and the Docker sanity check here. I will interpret the result and guide the next project-specific step.
