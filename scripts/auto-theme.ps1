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
