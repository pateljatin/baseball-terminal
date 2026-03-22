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

# Full theme switcher — prompt + Windows Terminal color scheme
function Set-FullTheme {
  param([string]$Name)

  # Step 1 — switch Oh My Posh prompt
  Set-Theme $Name

  # Step 2 — find Windows Terminal settings.json
  $WtPaths = @(
    "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json",
    "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"
  )
  $WtSettings = $WtPaths | Where-Object { Test-Path $_ } | Select-Object -First 1

  if (-not $WtSettings) {
    Write-Warning "Windows Terminal settings not found — prompt theme applied, color scheme skipped"
    return
  }

  # Step 3 — load matching scheme from wt-schemes.json
  $SchemesFile = Join-Path $PSScriptRoot "..\teams\$($env:TEAM)\wt-schemes.json"
  if (-not (Test-Path $SchemesFile)) {
    Write-Warning "wt-schemes.json not found — prompt theme applied, color scheme skipped"
    return
  }

  $AllSchemes = Get-Content $SchemesFile -Raw | ConvertFrom-Json
  $NewScheme  = $AllSchemes | Where-Object { $_.name -eq $Name }
  if (-not $NewScheme) {
    Write-Warning "No color scheme named '$Name' in wt-schemes.json"
    return
  }

  # Step 4 — read raw settings.json text
  $Raw = Get-Content $WtSettings -Raw

  # Step 5 — upsert scheme into "schemes" array using raw JSON string manipulation
  # Build the new scheme JSON block (single line, no trailing comma issues)
  $SchemeJson = $NewScheme | ConvertTo-Json -Depth 5 -Compress

  # Remove existing scheme with this name if present
  # Matches from opening { containing "name":"<Name>" to the closing }, including trailing comma/whitespace
  $Raw = $Raw -replace ('(?s),?\s*\{[^{}]*"name"\s*:\s*"' + [regex]::Escape($Name) + '"[^{}]*\}'), ''

  # Insert new scheme at the start of the schemes array
  $Raw = $Raw -replace '"schemes"\s*:\s*\[', ('"schemes": [' + $SchemeJson + ',')

  # Step 6 — update colorScheme in profiles.defaults
  if ($Raw -match '"defaults"\s*:\s*\{[^{}]*"colorScheme"') {
    # Replace existing colorScheme value inside defaults
    $Raw = $Raw -replace '("defaults"\s*:\s*\{[^{}]*"colorScheme"\s*:\s*")[^"]*(")', ('${1}' + $Name + '${2}')
  } elseif ($Raw -match '"defaults"\s*:\s*\{') {
    # Add colorScheme into existing defaults block
    $Raw = $Raw -replace '("defaults"\s*:\s*\{)', ('${1}"colorScheme": "' + $Name + '", ')
  } else {
    # Add defaults block with colorScheme into profiles
    $Raw = $Raw -replace '("profiles"\s*:\s*\{)', ('${1}"defaults": { "colorScheme": "' + $Name + '" }, ')
  }

  # Step 7 — write back
  $Raw | Set-Content $WtSettings -Encoding UTF8 -NoNewline

  Write-Host "Full theme: $Name (prompt + terminal colors)" -ForegroundColor DarkCyan
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
  Write-Host "  Prompt only:       Set-Theme <name>" -ForegroundColor DarkGray
  Write-Host "  Full terminal:     Set-FullTheme <name>   # also switches WT color scheme" -ForegroundColor DarkGray
  Write-Host ""
}

# Tab-completion for Set-Theme — press Tab after typing Set-Theme
Register-ArgumentCompleter -CommandName Set-Theme -ParameterName Name -ScriptBlock {
  Get-ChildItem $ThemeDir -Filter "*.omp.json" |
    Select-Object -ExpandProperty BaseName |
    ForEach-Object { [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_) }
}

# Tab-completion for Set-FullTheme
Register-ArgumentCompleter -CommandName Set-FullTheme -ParameterName Name -ScriptBlock {
  Get-ChildItem $ThemeDir -Filter "*.omp.json" |
    Select-Object -ExpandProperty BaseName |
    ForEach-Object { [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_) }
}
