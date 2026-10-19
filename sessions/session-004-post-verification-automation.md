# session-004-post-verification-automation

OBJECTIVE
- Automate environment capture, reproducible builds, and CI verification after manual checks.
- Triage and fix recurring failures; record remediation steps and create issues for code fixes.
- Add repository artifacts (env snapshots, scripts, CI config) to make reproductions repeatable.

PREREQUISITES
- Completed session-003 checks and collected snapshot files (or have outputs ready).
- Repo cloned locally and you can run build/test commands.

STEPS

1) Add reproducible environment capture scripts
- Windows PowerShell script to export winget/choco/pip/npm outputs into env-snapshots/ with timestamped filenames.
  Example filenames: env-snapshots/winget-YYYYMMDD-HHMMSS.txt, pip-freeze-*.txt
- Optionally add a cross-platform script (bash/PowerShell) that:
  - Runs npm/pip freeze, writes package.json lock if applicable
  - Collects OS/version info, git rev-parse HEAD, and writes env-metadata.json

2) Commit snapshots and scripts (suggested path)
- env-snapshots/
  - add-captured-files.sh (or add-captured-files.ps1)
  - README.md explaining how/when to run and how to attach outputs to sessions
- Example commit message: "Add env snapshot capture scripts and README"

3) Add a minimal CI workflow to run the project's build/tests on PRs
- Create .github/workflows/verify-on-pr.yml
  - Runs on: pull_request
  - Steps: checkout, install dependencies, run tests, upload test logs/artifacts
  - For Windows-specific checks add a matrix that includes windows-latest if tests need that platform

4) Repro and triage checklist (automated + manual)
- Re-run build in clean environment (CI or container/devcontainer)
- If tests fail: capture failing test names, stack traces, failing input files
- Create a focused issue per failing test with reproduction steps and attach failing logs

5) Optional: add devcontainer or Dockerfile for reproducible developer environment
- Devcontainer (VS Code) or Dockerfile that installs required runtime and dev tools to reproduce locally
- Add quick-start in README

6) Create short remediation templates
- Issue template for build/test failure (include env snapshot link, logs, steps taken)
- PR checklist to require passing CI and env snapshot if platform-specific fixes were made

7) Finalize and next actions
- If you want these artifacts added to the repo, reply: "add session-004" and I will create sessions/session-004-post-verification-automation.md plus the env-snapshot script and CI workflow (or only the files you request).
- If you prefer I only create the session note, reply: "add session-004 note".
- If you want me to analyze specific outputs from session-003, paste them here (env snapshots, sfc/DISM outputs, build logs), and I’ll triage and propose fixes or create issues/PRs per the findings.

STATUS (setup)
- Done: env-snapshots/add-snapshots.ps1, env-snapshots/README.md, .github/workflows/verify-on-pr.yml (hardened).
- Next: run `pwsh .\env-snapshots\add-snapshots.ps1` locally, review outputs (do not commit), open a test PR to confirm verify-on-pr passes, then create the restore branch.
- Remaining optional: devcontainer/Dockerfile, issue template, PR checklist.
