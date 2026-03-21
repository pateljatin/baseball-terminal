# auto-theme.ps1 — Day-of-week Oh My Posh theme switcher (Windows PowerShell)
# Reads $env:TEAM to locate the correct teams/ subfolder.
# Source this in your $PROFILE to auto-switch on every new shell.

# Default team if not set
if (-not $env:TEAM) {
  $env:TEAM = "seattle-mariners"
}

# Resolve themes directory
$ThemeDir = Join-Path $PSScriptRoot "..\teams\$($env:TEAM)\themes"

# Day-of-week schedule (matches real uniform rotation)
$ThemeMap = @{
  "Monday"    = "mariners-classic"
  "Tuesday"   = "claude-inspired"
  "Wednesday" = "mariners-classic"
  "Thursday"  = "mariners-nw-green"
  "Friday"    = "mariners-city-connect"
  "Saturday"  = "claude-inspired"
  "Sunday"    = "mariners-cream-sunday"
}

# Select theme by day
$Today = (Get-Date).DayOfWeek.ToString()
$ThemeName = $ThemeMap[$Today]
$ThemePath = Join-Path $ThemeDir "$ThemeName.omp.json"

# Apply the theme
if (Test-Path $ThemePath) {
  oh-my-posh init pwsh --config $ThemePath | Invoke-Expression
  Write-Host "Theme: $ThemeName ($Today)" -ForegroundColor DarkCyan
} else {
  Write-Warning "Theme not found: $ThemePath"
}

# Manual override function
function Set-Theme {
  param([string]$Name)
  $Override = Join-Path $ThemeDir "$Name.omp.json"
  if (Test-Path $Override) {
    oh-my-posh init pwsh --config $Override | Invoke-Expression
    Write-Host "Theme switched to: $Name" -ForegroundColor DarkCyan
  } else {
    Write-Warning "No theme named '$Name' in $ThemeDir"
  }
}

# List all available themes with visual preview info
function List-Themes {
  Write-Host ""
  Write-Host "  baseball-terminal — $env:TEAM themes" -ForegroundColor Cyan
  Write-Host "  ─────────────────────────────────────────────────────" -ForegroundColor DarkGray
  Write-Host "  Name                       Day       Vibe" -ForegroundColor DarkGray
  Write-Host "  ─────────────────────────────────────────────────────" -ForegroundColor DarkGray
  Write-Host "  claude-inspired            Tue+Sat   Terra cotta, warm dark" -ForegroundColor Yellow
  Write-Host "  mariners-classic           Mon+Wed   Navy + NW Green" -ForegroundColor Yellow
  Write-Host "  mariners-nw-green          Thu       Deep teal" -ForegroundColor Yellow
  Write-Host "  mariners-city-connect      Fri 🔱    Rush Blue + Gold" -ForegroundColor Yellow
  Write-Host "  mariners-cream-sunday      Sun       Cream fauxback" -ForegroundColor Yellow
  Write-Host "  ─────────────────────────────────────────────────────" -ForegroundColor DarkGray
  Write-Host "  Today ($((Get-Date).DayOfWeek)): $ThemeName" -ForegroundColor Green
  Write-Host ""
  Write-Host "  Usage: Set-Theme <name>   e.g. Set-Theme mariners-city-connect" -ForegroundColor DarkGray
  Write-Host ""
}

# Tab-completion for Set-Theme — press Tab after typing Set-Theme
Register-ArgumentCompleter -CommandName Set-Theme -ParameterName Name -ScriptBlock {
  Get-ChildItem $ThemeDir -Filter "*.omp.json" |
    Select-Object -ExpandProperty BaseName |
    ForEach-Object { [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_) }
}
