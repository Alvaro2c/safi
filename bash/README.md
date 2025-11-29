# README — Running Bash scripts

Quick steps to run bash files.

Prerequisites
- Bash installed (Linux, macOS, WSL, Git Bash, Cygwin).

Make script executable (Linux / macOS)
1. Add shebang at top:
  ```bash
  #!/usr/bin/env bash
  ```
2. Make executable and run:
  ```bash
  chmod +x script.sh
  ./script.sh
  ```

Run without changing permissions
- Invoke directly with bash:
  ```bash
  bash script.sh
  ```

Windows
- Use Git Bash or WSL (recommended). In those shells:
  ```bash
  ./script.sh
  # or
  bash script.sh
  ```
- If you see CRLF errors, run: `dos2unix script.sh`.

That's it — add executable bit or call bash explicitly.
