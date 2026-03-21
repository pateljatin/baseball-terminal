# baseball-terminal — Kick-off Prompt

Use this file to bootstrap the repo with Claude Code in a fresh session.

## How to use

```
cd C:\Users\jatin\code
git clone https://github.com/pateljatin/baseball-terminal
cd baseball-terminal
claude
```

Then paste the prompt below as your first message.

---

## Kick-off Prompt (paste this into Claude Code)

```
Read CLAUDE.md fully before doing anything. Then scaffold the complete repo:

TASK 1 — Update README.md
- Replace all references to "pnw-terminal" with "baseball-terminal"
- Rewrite with: project description, prerequisites (Oh My Posh, Cascadia Code NF,
  ccstatusline), quick-start for Mariners (clone, run setup script), folder structure
    overview, "Adding your team" section pointing to teams/seattle-mariners/ as template

    TASK 2 — Create teams/seattle-mariners/themes/ with 5 Oh My Posh JSON files
    Use ONLY the hex colors from CLAUDE.md. Each file needs path, git, and tools segments.
    Files to create:
    - claude-inspired.omp.json     (bg: #1c1410, primary: #C15F3C, secondary: #7A4A2E)
    - mariners-classic.omp.json    (bg: #080f1f, primary: #0C2C56, secondary: #005C5C)
    - mariners-city-connect.omp.json (bg: #0a0f1a, primary: #1B3A8C, secondary: #D4A017)
    - mariners-nw-green.omp.json   (bg: #001f1f, primary: #005C5C, secondary: #003f3f)
    - mariners-cream-sunday.omp.json (bg: #2a2515, primary: #3a3220, secondary: #005C5C)

    TASK 3 — Create teams/seattle-mariners/README.md
    Mariners-specific install guide: prerequisites, clone steps, run windows-setup.ps1
    or mac-setup.sh, set TEAM=seattle-mariners, test with Set-Theme or set-theme command.
    Include the color palette table with all hex codes from CLAUDE.md.

    TASK 4 — Create scripts/auto-theme.ps1 (Windows PowerShell)
    - Reads $env:TEAM variable (default: seattle-mariners if not set)
    - Selects theme by day: Friday=city-connect, Sunday=cream-sunday, Monday=classic,
      Tuesday=claude-inspired, Wednesday=classic, Thursday=nw-green, Saturday=claude-inspired
      - Points to ~/.baseball-terminal/themes/$theme.omp.json
      - Includes Set-Theme function for manual override
      - Includes Set-Team function to switch teams

      TASK 5 — Create scripts/auto-theme.sh (Mac/Zsh)
      - Same logic as auto-theme.ps1 but Bash/Zsh syntax
      - Reads $TEAM env var (default: seattle-mariners)
      - Includes set-theme and set-team functions

      TASK 6 — Create setup/windows-setup.ps1
      - winget installs: Windows Terminal, Oh My Posh, CascadiaCode
      - git clone of this repo to ~/.baseball-terminal
      - Symlinks themes folder from cloned repo
      - Sets TEAM env var to seattle-mariners
      - Runs ccstatusline setup
      - Adds auto-theme.ps1 source line to $PROFILE
      - Prints success summary with next steps

      TASK 7 — Create setup/mac-setup.sh
      - brew installs: oh-my-posh, ghostty, font-caskaydia-cove-nerd-font, node
      - git clone to ~/.baseball-terminal
      - Sets TEAM in ~/.zshrc
      - Adds auto-theme.sh source line to ~/.zshrc
      - Runs ccstatusline setup
      - Prints success summary

      TASK 8 — Create claude/settings.json
      ccstatusline statusline config for ~/.claude/settings.json:
      {
        "statusLine": {
            "type": "command",
                "command": "npx -y ccstatusline@latest",
                    "padding": 0
                      }
                      }

                      Commit all files with meaningful messages grouped by task.
                      Work through tasks 1-8 in order. Do not skip any.
                      Ask me before making any color or structural decision not covered in CLAUDE.md.
                      ```
