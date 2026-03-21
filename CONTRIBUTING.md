# Contributing to baseball-terminal

Want to add your team? Awesome. Here's exactly how to do it.

## Adding a New Team

### 1. Fork and clone

```bash
git clone https://github.com/YOUR_USER/baseball-terminal.git
cd baseball-terminal
```

### 2. Create your team folder

```bash
cp -r teams/seattle-mariners teams/your-team-slug
```

Use the MLB-standard slug format: `team-city-name` (e.g. `chicago-cubs`, `los-angeles-dodgers`, `new-york-yankees`).

### 3. Build your 5 theme files

Every team needs exactly 5 `.omp.json` files in `teams/<team-slug>/themes/`:

| File | Purpose |
|------|---------|
| `<slug>-classic.omp.json` | Home uniform — primary + secondary colors |
| `<slug>-nw-green.omp.json` | Alternate uniform — your team's alternate jersey |
| `<slug>-city-connect.omp.json` | City Connect — the special edition colors |
| `<slug>-cream-sunday.omp.json` | Sunday fauxback — cream/retro vibe |
| `claude-inspired.omp.json` | Claude collab — keep this one as-is |

**Rules for theme files:**

- All hex colors must be **UPPERCASE** (e.g. `#0C2C56`, not `#0c2c56`)
- Use only your team's official palette — no random colors
- Every theme needs 3 segments: **path**, **git**, and **tools**
- Include `_terminal_background` at the top of each file
- Valid JSON — no trailing commas, no comments

### 4. Update your team README

Edit `teams/<team-slug>/README.md` with:

- Team name and theme list
- Full color palette table with hex codes and usage
- Color sources (link to official MLB brand guide, city connect page, etc.)

### 5. Don't touch shared files

Do **not** modify anything in `scripts/`, `setup/`, or `claude/`. These are team-agnostic and read the `TEAM` variable to find your folder automatically.

### 6. Test it

```powershell
# Windows
$env:TEAM = "your-team-slug"
. .\scripts\auto-theme.ps1
List-Themes

# Mac / Linux
export TEAM="your-team-slug"
source scripts/auto-theme.sh
list-themes
```

Cycle through all 5 themes with `Set-Theme` / `set-theme` and confirm they look right.

### 7. Submit your PR

- Branch name: `add-<team-slug>` (e.g. `add-chicago-cubs`)
- Fill out the PR template checklist completely
- Include a screenshot of each theme in the PR description

## Finding Your Team's Colors

- [Team Color Codes](https://teamcolorcodes.com/) — hex codes for every MLB team
- [MLB City Connect](https://www.mlb.com/city-connect) — city connect jersey palettes
- Your team's official site usually has a brand/media page

## What Gets Reviewed

When you submit a PR, CI will automatically check:

- All 5 theme files exist and are valid JSON
- Hex colors are uppercase
- Folder structure matches the convention
- `claude-inspired.omp.json` is unchanged

I'll also review the color choices manually. If the theme looks off or doesn't match the real uniform, I'll leave comments.

## Code Style

- JSON: 2-space indent, hex colors always UPPERCASE
- Shell scripts: 2-space indent (but you shouldn't need to touch these)
- Commit messages: present tense, descriptive (e.g. "Add Chicago Cubs themes")

## Questions?

Open an issue. Happy to help you get your team's colors right.
