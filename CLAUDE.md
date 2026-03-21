# baseball-terminal — CLAUDE.md

## Project Overview
This repo is a baseball-team-themed terminal setup for Claude Code users.
It provides Oh My Posh prompt themes, auto day-of-week uniform switching scripts,
cross-platform setup (Windows + Mac), and a Claude Code statusline config.

The Seattle Mariners implementation under teams/seattle-mariners/ is the
reference implementation. All other teams follow the same folder structure.

## Repo Structure
```
baseball-terminal/
  teams/
      seattle-mariners/
            themes/
                    claude-inspired.omp.json
                            mariners-classic.omp.json
                                    mariners-city-connect.omp.json
                                            mariners-nw-green.omp.json
                                                    mariners-cream-sunday.omp.json
                                                          README.md
                                                            scripts/
                                                                auto-theme.ps1       # Windows PowerShell — reads TEAM env var
                                                                    auto-theme.sh        # Mac/Zsh — reads TEAM env var
                                                                      setup/
                                                                          windows-setup.ps1    # One-shot Windows bootstrap
                                                                              mac-setup.sh         # One-shot Mac bootstrap
                                                                                claude/
                                                                                    settings.json        # Claude Code statusline config (ccstatusline)
                                                                                      CLAUDE.md
                                                                                        README.md
                                                                                          LICENSE
                                                                                          ```

                                                                                          ## Theme System
                                                                                          - 5 Oh My Posh JSON themes per team, named by uniform type
                                                                                          - auto-theme scripts select theme by day of week:
                                                                                            - Friday    -> city-connect (game night)
                                                                                              - Sunday    -> cream-sunday (fauxback)
                                                                                                - Monday    -> classic
                                                                                                  - Tuesday   -> claude-inspired
                                                                                                    - Wednesday -> classic
                                                                                                      - Thursday  -> nw-green (or team alternate, appears least)
                                                                                                        - Saturday  -> claude-inspired
                                                                                                        - Manual override: Set-Theme <name> (PowerShell) or set-theme <name> (Zsh)
                                                                                                        - TEAM variable in setup scripts controls which teams/ subfolder is used
                                                                                                        
                                                                                                        ## Seattle Mariners Color Palette (reference team)
                                                                                                        - Navy:          #0C2C56
                                                                                                        - NW Green:      #005C5C
                                                                                                        - Silver:        #C4CED4
                                                                                                        - Red accent:    #D50032
                                                                                                        - City Connect Rush Blue:  #1B3A8C
                                                                                                        - City Connect Sundown:    #F5C842
                                                                                                        - City Connect Amarillo:   #D4A017
                                                                                                        - Cream (Sunday fauxback): #F5F0E0
                                                                                                        - Claude Crail:  #C15F3C
                                                                                                        - Claude Pampas: #F4F3EE
                                                                                                        - Claude Cloudy: #B1ADA1
                                                                                                        
                                                                                                        ## Oh My Posh Theme JSON Structure
                                                                                                        Each .omp.json file must include:
                                                                                                        - A path segment (bg: team primary color, fg: white or silver)
                                                                                                        - A git segment (bg: team secondary color)
                                                                                                        - A tools segment (node/python version, bg: dark variant)
                                                                                                        - Terminal background hex noted in a comment at top of file
                                                                                                        - All colors use team palette only — no random colors
                                                                                                        
                                                                                                        ## Claude Code Statusline
                                                                                                        - Use ccstatusline (npm) — works natively on Windows PowerShell and Mac Zsh
                                                                                                        - settings.json template lives in claude/ folder
                                                                                                        - Copy to ~/.claude/settings.json on setup
                                                                                                        
                                                                                                        ## Cross-Platform Rules
                                                                                                        - .omp.json theme files are identical on Windows and Mac — never platform-branch them
                                                                                                        - auto-theme.ps1 = Windows only (PowerShell syntax)
                                                                                                        - auto-theme.sh = Mac/Linux only (Bash/Zsh syntax)
                                                                                                        - Both scripts read the same TEAM variable and same day-of-week logic
                                                                                                        - Font: Cascadia Code NF on Windows, CaskaydiaCove NF on Mac (same family)
                                                                                                        
                                                                                                        ## Adding a New Team
                                                                                                        1. Create teams/<team-slug>/ folder
                                                                                                        2. Copy teams/seattle-mariners/ as template
                                                                                                        3. Update all hex colors in the 5 theme JSON files
                                                                                                        4. Update teams/<team-slug>/README.md with team name and color sources
                                                                                                        5. Do not modify shared scripts/ or setup/ — they are team-agnostic
                                                                                                        
                                                                                                        ## Code Style
                                                                                                        - Shell scripts: 2-space indent, comments on every section
                                                                                                        - JSON: 2-space indent, color hex values always uppercase
                                                                                                        - README files: keep install steps numbered, copy-pasteable commands only
                                                                                                        - No external dependencies beyond Oh My Posh, ccstatusline, and a Nerd Font
