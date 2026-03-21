# Seattle Mariners — baseball-terminal

The reference implementation for baseball-terminal. Five Oh My Posh themes
inspired by the Mariners uniform rotation, plus Claude-inspired alternates.

## Themes

| Theme | File | Uniform | Terminal BG |
|-------|------|---------|-------------|
| Classic | `mariners-classic.omp.json` | Home white / Navy | `#0C2C56` |
| NW Green | `mariners-nw-green.omp.json` | NW Green alternate | `#003333` |
| City Connect | `mariners-city-connect.omp.json` | City Connect | `#1B3A8C` |
| Cream Sunday | `mariners-cream-sunday.omp.json` | Sunday fauxback | `#F5F0E0` |
| Claude Inspired | `claude-inspired.omp.json` | Claude brand collab | `#F4F3EE` |

## Day-of-Week Schedule

| Day | Theme |
|-----|-------|
| Monday | Classic |
| Tuesday | Claude Inspired |
| Wednesday | Classic |
| Thursday | NW Green |
| Friday | City Connect |
| Saturday | Claude Inspired |
| Sunday | Cream Sunday |

## Color Palette

| Name | Hex | Usage |
|------|-----|-------|
| Navy | `#0C2C56` | Primary / path segment BG |
| NW Green | `#005C5C` | Secondary / git segment BG |
| Silver | `#C4CED4` | Foreground text |
| Red | `#D50032` | Accent (Cream Sunday tools) |
| Rush Blue | `#1B3A8C` | City Connect primary |
| Sundown | `#F5C842` | City Connect secondary |
| Amarillo | `#D4A017` | City Connect dark accent |
| Cream | `#F5F0E0` | Sunday fauxback BG |
| Claude Crail | `#C15F3C` | Claude theme primary |
| Claude Pampas | `#F4F3EE` | Claude theme BG |
| Claude Cloudy | `#B1ADA1` | Claude theme secondary |

## Color Sources

- [MLB Brand Guide — Seattle Mariners](https://teamcolorcodes.com/seattle-mariners-color-codes/)
- [2023 City Connect Series](https://www.mlb.com/mariners/fans/city-connect)
- [Claude brand palette](https://claude.ai)

## Quick Install

If you cloned the repo and just want the Mariners setup:

```powershell
# Windows
.\setup\windows-setup.ps1 -Team seattle-mariners

# Mac
./setup/mac-setup.sh seattle-mariners
```
