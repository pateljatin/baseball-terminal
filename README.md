# baseball-terminal

Baseball-team-themed terminal setup for Claude Code users. Oh My Posh prompt
themes that rotate by day of week — like your team wears different uniforms for
home, away, and special games — your terminal changes too.

Cross-platform: Windows PowerShell + macOS Zsh. Zero runtime dependencies beyond
Oh My Posh, a Nerd Font, and optionally ccstatusline for the Claude Code statusline.

## What You Get

- **5 Oh My Posh themes per team** matching real uniform rotations
- **Auto day-of-week switching** — Friday is City Connect night, Sunday is cream fauxback day
- **Manual override** — `Set-Theme city-connect` (PowerShell) or `set-theme city-connect` (Zsh)
- **Claude Code statusline** config via ccstatusline
- **One-shot setup scripts** for Windows and Mac

## Quick Start

### Windows (PowerShell)

```powershell
git clone https://github.com/YOUR_USER/baseball-terminal.git
cd baseball-terminal
.\setup\windows-setup.ps1
```

### macOS (Zsh)

```bash
git clone https://github.com/YOUR_USER/baseball-terminal.git
cd baseball-terminal
chmod +x setup/mac-setup.sh
./setup/mac-setup.sh
```

Restart your terminal. The theme auto-switches based on the day of the week.

## Folder Structure

```
baseball-terminal/
  teams/
    seattle-mariners/        # Reference implementation
      themes/
        mariners-classic.omp.json
        mariners-nw-green.omp.json
        mariners-city-connect.omp.json
        mariners-cream-sunday.omp.json
        claude-inspired.omp.json
      README.md
  scripts/
    auto-theme.ps1           # Windows — day-of-week switcher
    auto-theme.sh            # Mac/Linux — day-of-week switcher
  setup/
    windows-setup.ps1        # One-shot Windows bootstrap
    mac-setup.sh             # One-shot Mac bootstrap
  claude/
    settings.json            # Claude Code statusline config
  CLAUDE.md
  README.md
  LICENSE
```

## Day-of-Week Schedule

| Day | Theme | Inspired By |
|-----|-------|-------------|
| Monday | Classic | Home jersey |
| Tuesday | Claude Inspired | Claude brand collab |
| Wednesday | Classic | Home jersey |
| Thursday | NW Green (alt) | Alternate jersey (rarest) |
| Friday | City Connect | Game night special |
| Saturday | Claude Inspired | Claude brand collab |
| Sunday | Cream Sunday | Fauxback Sunday alternate |

## Manual Override

Switch to any theme at any time without waiting for the right day:

```powershell
# PowerShell
Set-Theme mariners-city-connect

# Zsh / Bash
set-theme mariners-city-connect
```

## Requirements

- [Oh My Posh](https://ohmyposh.dev/) — prompt engine
- [Cascadia Code NF](https://github.com/microsoft/cascadia-code) — Nerd Font (Windows: Cascadia Code NF, Mac: CaskaydiaCove NF)
- [ccstatusline](https://www.npmjs.com/package/ccstatusline) (optional) — Claude Code statusline

The setup scripts install Oh My Posh and the font automatically if missing.

## Adding Your Team

1. Create `teams/<team-slug>/` (e.g. `teams/chicago-cubs/`)
2. Copy `teams/seattle-mariners/` as your starting template
3. Replace all hex color values in the 5 `.omp.json` files with your team's palette
4. Update `teams/<team-slug>/README.md` with your team name, colors, and sources
5. Set the `TEAM` environment variable to your team slug:
   ```powershell
   # PowerShell
   $env:TEAM = "chicago-cubs"

   # Zsh / Bash
   export TEAM="chicago-cubs"
   ```
6. Re-run the setup script or restart your terminal

**Do not modify** files in `scripts/` or `setup/` — they are team-agnostic and
read the `TEAM` variable to find the right `teams/` subfolder.

## Available Teams

| Team | Folder | Status |
|------|--------|--------|
| Seattle Mariners | `teams/seattle-mariners/` | Reference implementation |

## License

MIT — see [LICENSE](LICENSE).
