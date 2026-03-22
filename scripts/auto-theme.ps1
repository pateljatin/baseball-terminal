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

# Windows Terminal color scheme switcher
# Upserts the matching scheme from wt-schemes.json into WT settings.json
function Set-WTColorScheme {
  param([string]$SchemeName)

  # Locate the repo's scheme definitions
  $SchemeFile = Join-Path $PSScriptRoot "..\teams\$($env:TEAM)\wt-schemes.json"
  if (-not (Test-Path $SchemeFile)) { return }

  # Find Windows Terminal settings.json (stable or preview)
  $WTSettingsPaths = @(
    "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json",
    "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"
  )
  $WTSettings = $WTSettingsPaths | Where-Object { Test-Path $_ } | Select-Object -First 1
  if (-not $WTSettings) { return }

  # Read scheme definitions and find the requested one
  $AllSchemes = Get-Content $SchemeFile -Raw | ConvertFrom-Json
  $NewScheme = $AllSchemes | Where-Object { $_.name -eq $SchemeName }
  if (-not $NewScheme) { return }

  # Read current WT settings
  $Settings = Get-Content $WTSettings -Raw | ConvertFrom-Json

  # Ensure schemes array exists
  if (-not $Settings.schemes) {
    $Settings | Add-Member -NotePropertyName "schemes" -NotePropertyValue @()
  }

  # Upsert: remove existing scheme with same name, then add the new one
  $Settings.schemes = @($Settings.schemes | Where-Object { $_.name -ne $SchemeName }) + $NewScheme

  # Set the default profile color scheme
  if (-not $Settings.profiles.defaults) {
    $Settings.profiles | Add-Member -NotePropertyName "defaults" -NotePropertyValue @{}
  }
  $Settings.profiles.defaults | Add-Member -NotePropertyName "colorScheme" -NotePropertyValue $SchemeName -Force

  # Write back — WT hot-reloads on file change
  $Settings | ConvertTo-Json -Depth 10 | Set-Content $WTSettings -Encoding UTF8
  Write-Host "Color scheme: $SchemeName" -ForegroundColor DarkCyan
}

# Select theme by day
$Today = (Get-Date).DayOfWeek.ToString()
$ThemeName = $ThemeMap[$Today]
$ThemePath = Join-Path $ThemeDir "$ThemeName.omp.json"

# Apply the theme
if (Test-Path $ThemePath) {
  oh-my-posh init pwsh --config $ThemePath | Invoke-Expression
  Set-WTColorScheme $ThemeName
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
    Set-WTColorScheme $Name
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
