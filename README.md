# baseball-terminal ⚾

**Your terminal wears a different uniform every day of the week.**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Works on Windows + Mac](https://img.shields.io/badge/platform-Windows%20%2B%20Mac-informational)](README.md)
[![Powered by Oh My Posh](https://img.shields.io/badge/powered%20by-Oh%20My%20Posh-blueviolet)](https://ohmyposh.dev/)

---

## What is this?

Baseball teams wear different uniforms on different days — home whites on Monday, city connect on Friday night, cream fauxbacks on Sunday. Your terminal should too. **baseball-terminal** is a set of cross-platform [Oh My Posh](https://ohmyposh.dev/) themes that auto-rotate by day of week, built for [Claude Code](https://claude.ai) users who want their prompt to have some personality.

---

## Theme Preview

Five themes. Five vibes. One for every day of the week.

### 🔵 Classic — Monday + Wednesday

> *Home whites under the lights. Navy and teal, the way Safeco intended.*

| Segment | Color | Hex |
|---------|-------|-----|
| 🔵 Path | Navy | `#0C2C56` |
| 🟢 Git | NW Green | `#005C5C` |
| ⬛ Tools | Dark Navy | `#091E3A` |
| Terminal BG | | `#0C2C56` |

```
  ~/projects/baseball-terminal   main ❯  node 22.0.0
```

---

### 🟠 Claude Inspired — Tuesday + Saturday

> *Terra cotta warmth on a dark roast background. Claude meets the diamond.*

| Segment | Color | Hex |
|---------|-------|-----|
| 🟠 Path | Crail | `#C15F3C` |
| 🟤 Git | Cloudy | `#B1ADA1` |
| ⬛ Tools | Dark warm | `#352A22` |
| Terminal BG | | `#1C1410` |

```
  ~/projects/my-project   feature/my-branch ❯  node 22.0.0
```

---

### 🟢 NW Green — Thursday

> *The rarest jersey in the rotation. Deep teal, earned not given.*

| Segment | Color | Hex |
|---------|-------|-----|
| 🟢 Path | NW Green | `#005C5C` |
| 🔵 Git | Navy | `#0C2C56` |
| ⬛ Tools | Dark Teal | `#002626` |
| Terminal BG | | `#003333` |

```
  ~/projects/api-server   develop ❯  python 3.12
```

---

### 🟡 City Connect — Friday

> *Friday night. Rush blue and sundown gold. The trident glows.*

| Segment | Color | Hex |
|---------|-------|-----|
| 🔵 Path | Rush Blue | `#1B3A8C` |
| 🟡 Git | Sundown | `#F5C842` |
| ⬛ Tools | Deep Blue | `#0F2259` |
| Terminal BG | | `#1B3A8C` |

```
  ~/projects/baseball-terminal   main ❯  node 22.0.0
```

---

### 🟤 Cream Sunday — Sunday

> *Fauxback day. Cream background, navy letters, a nod to the old days.*

| Segment | Color | Hex |
|---------|-------|-----|
| 🔵 Path | Navy on Cream | `#0C2C56` |
| 🟢 Git | NW Green on Cream | `#005C5C` |
| 🔴 Tools | Red accent | `#D50032` |
| Terminal BG | | `#F5F0E0` |

```
  ~/code/baseball-terminal   main ❯  node 22.0.0
```

---

## Quick Start

### **Windows (PowerShell)**

1. Clone the repo:
   ```powershell
   git clone https://github.com/YOUR_USER/baseball-terminal.git
   cd baseball-terminal
   ```

2. Run the setup script:
   ```powershell
   .\setup\windows-setup.ps1
   ```

3. Restart your terminal. Done.

### **Mac (Zsh)**

1. Clone the repo:
   ```bash
   git clone https://github.com/YOUR_USER/baseball-terminal.git
   cd baseball-terminal
   ```

2. Run the setup script:
   ```bash
   chmod +x setup/mac-setup.sh
   ./setup/mac-setup.sh
   ```

3. Restart your terminal. Done.

The setup scripts install Oh My Posh and a Nerd Font if you don't already have them.

---

## Theme Commands

Switch themes on the fly or see what's available.

**List all themes:**

```
> List-Themes                              # PowerShell
$ list-themes                              # Zsh / Bash
```

```
  baseball-terminal — seattle-mariners themes
  ─────────────────────────────────────────────────────
  Name                       Day       Vibe
  ─────────────────────────────────────────────────────
  claude-inspired            Tue+Sat   Terra cotta, warm dark
  mariners-classic           Mon+Wed   Navy + NW Green
  mariners-nw-green          Thu       Deep teal
  mariners-city-connect      Fri       Rush Blue + Gold
  mariners-cream-sunday      Sun       Cream fauxback
  ─────────────────────────────────────────────────────
  Today (Friday): mariners-city-connect

  Usage: Set-Theme <name>   e.g. Set-Theme mariners-city-connect
```

**Switch to any theme:**

```
> Set-Theme mariners-city-connect          # PowerShell
$ set-theme mariners-city-connect          # Zsh / Bash
```

Tab completion is built in — press `Tab` after typing the command to cycle through theme names.

---

## Day Schedule

| Day | Theme | Uniform Inspiration | Auto? |
|-----|-------|---------------------|-------|
| Monday | Classic | Home white jersey | Yes |
| Tuesday | Claude Inspired | Claude brand collab | Yes |
| Wednesday | Classic | Home white jersey | Yes |
| Thursday | NW Green | Alternate jersey (rarest) | Yes |
| Friday | City Connect | Friday night special | Yes |
| Saturday | Claude Inspired | Claude brand collab | Yes |
| Sunday | Cream Sunday | Fauxback Sunday alternate | Yes |

Every new terminal session picks the right theme automatically. Override anytime with `Set-Theme` / `set-theme`.

---

## Adding Your Team

1. Create a folder: `teams/<team-slug>/` (e.g. `teams/chicago-cubs/`)
2. Copy `teams/seattle-mariners/` as your starting template
3. Replace every hex color in the 5 `.omp.json` theme files with your team's palette
4. Update `teams/<team-slug>/README.md` with team name, colors, and sources
5. Set the `TEAM` environment variable and restart:
   ```powershell
   $env:TEAM = "chicago-cubs"        # PowerShell
   export TEAM="chicago-cubs"        # Zsh / Bash
   ```

Don't modify `scripts/` or `setup/` — they read `TEAM` and find the right theme folder automatically.

---

## Part of a bigger vision

This is the **Seattle Mariners** reference implementation — the first team in what could be all 30.

The architecture is team-agnostic: same scripts, same day-of-week rotation, same Oh My Posh engine. Only the colors change. Every team folder is self-contained under `teams/`.

**Want to add your team?** PRs are welcome. Pick a team, build the 5 themes, and submit. The [Seattle Mariners folder](teams/seattle-mariners/) is your blueprint.

| Team | Folder | Status |
|------|--------|--------|
| Seattle Mariners | `teams/seattle-mariners/` | Reference implementation |
| *Your team here* | `teams/???/` | [Open a PR](https://github.com/YOUR_USER/baseball-terminal/pulls) |

---

## Requirements

| Tool | What it does | Installed by setup? |
|------|-------------|---------------------|
| [Oh My Posh](https://ohmyposh.dev/) | Prompt theme engine | Yes |
| [Cascadia Code NF](https://github.com/microsoft/cascadia-code) | Nerd Font for icons | Yes |
| [ccstatusline](https://www.npmjs.com/package/ccstatusline) | Claude Code statusline | Optional |

---

MIT License — see [LICENSE](LICENSE).

Built with [Claude Code](https://claude.ai/claude-code).
