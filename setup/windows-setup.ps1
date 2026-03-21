# windows-setup.ps1 — One-shot bootstrap for baseball-terminal on Windows
# Run once to install dependencies and wire up your profile.

param(
  [string]$Team = "seattle-mariners"
)

Write-Host "`n=== baseball-terminal Windows Setup ===" -ForegroundColor Cyan
Write-Host "Team: $Team`n"

# Step 1: Check for Oh My Posh
Write-Host "[1/5] Checking Oh My Posh..." -ForegroundColor Yellow
if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
  Write-Host "  Installing Oh My Posh via winget..."
  winget install JanDeDobbeleer.OhMyPosh -s winget
} else {
  Write-Host "  Oh My Posh already installed."
}

# Step 2: Check for Nerd Font (Cascadia Code NF)
Write-Host "[2/5] Checking Nerd Font..." -ForegroundColor Yellow
$FontInstalled = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" -ErrorAction SilentlyContinue) |
  Get-Member -MemberType NoteProperty |
  Where-Object { $_.Name -like "*Cascadia*Nerd*" }
if (-not $FontInstalled) {
  Write-Host "  Installing Cascadia Code NF via Oh My Posh..."
  oh-my-posh font install CascadiaCode
} else {
  Write-Host "  Cascadia Code NF already installed."
}

# Step 3: Set TEAM environment variable
Write-Host "[3/5] Setting TEAM environment variable..." -ForegroundColor Yellow
[System.Environment]::SetEnvironmentVariable("TEAM", $Team, "User")
$env:TEAM = $Team
Write-Host "  TEAM=$Team (User scope)"

# Step 4: Add auto-theme sourcing to PowerShell profile
Write-Host "[4/5] Configuring PowerShell profile..." -ForegroundColor Yellow
$RepoRoot = Split-Path $PSScriptRoot
$SourceLine = ". `"$RepoRoot\scripts\auto-theme.ps1`""
if (-not (Test-Path $PROFILE)) {
  New-Item -Path $PROFILE -ItemType File -Force | Out-Null
}
$ProfileContent = Get-Content $PROFILE -Raw -ErrorAction SilentlyContinue
if ($ProfileContent -notlike "*auto-theme.ps1*") {
  Add-Content -Path $PROFILE -Value "`n# baseball-terminal auto-theme`n$SourceLine"
  Write-Host "  Added auto-theme to $PROFILE"
} else {
  Write-Host "  auto-theme already in profile."
}

# Step 5: Copy Claude Code statusline config
Write-Host "[5/5] Setting up Claude Code statusline..." -ForegroundColor Yellow
$ClaudeDir = Join-Path $env:USERPROFILE ".claude"
$ClaudeSettings = Join-Path $ClaudeDir "settings.json"
$SourceSettings = Join-Path $RepoRoot "claude\settings.json"
if (-not (Test-Path $ClaudeDir)) {
  New-Item -Path $ClaudeDir -ItemType Directory -Force | Out-Null
}
if (-not (Test-Path $ClaudeSettings)) {
  Copy-Item $SourceSettings $ClaudeSettings
  Write-Host "  Copied settings.json to $ClaudeSettings"
} else {
  Write-Host "  $ClaudeSettings already exists — skipping (back up and re-run to overwrite)."
}

Write-Host "`n=== Setup complete! ===" -ForegroundColor Green
Write-Host "Restart your terminal to see the theme.`n"
