# Session 001 — Initial setup & verification

Purpose: capture step-by-step progress and outputs so we never lose work mid-session.

How this file will be used
- You run the small command group(s) I ask for on each machine.
- Paste the exact terminal output (labelled Laptop or Desktop) into this thread.
- I will commit your outputs and the next steps into this repository under sessions/ so we can always resume.

---

## Run now (Step 1)

Commands to run in Windows PowerShell (Admin) on both machines:

1) Check WSL distros and version:

wsl -l -v

2) Update WSL (optional but recommended):

wsl --update
wsl --shutdown

Paste outputs below (replace the placeholders with your real outputs):

### Laptop — Step 1 outputs

```
<PASTE LAPTOP wsl -l -v OUTPUT HERE>
```

### Desktop — Step 1 outputs

```
<PASTE DESKTOP wsl -l -v OUTPUT HERE>
```

---

## Then run (Step 2)

Open your WSL Ubuntu shell on each machine and run:

nvidia-smi

Also run:

hostname

Paste outputs below:

### Laptop — Step 2 outputs (nvidia-smi & hostname)

```
<PASTE LAPTOP nvidia-smi OUTPUT HERE>
<PASTE LAPTOP hostname OUTPUT HERE>
```

### Desktop — Step 2 outputs (nvidia-smi & hostname)

```
<PASTE DESKTOP nvidia-smi OUTPUT HERE>
<PASTE DESKTOP hostname OUTPUT HERE>
```

---

If anything errors, paste the full error text under the relevant step and I will diagnose and commit the fix steps into the repository.

I'll commit your pasted outputs into a new file sessions/session-001-results.md if you want — please confirm in your reply that I have permission to commit the outputs you paste into this repository.
