#!/usr/bin/env bash
# mac-setup.sh — One-shot bootstrap for baseball-terminal on macOS
# Run once to install dependencies and wire up your shell profile.

set -e

TEAM="${1:-seattle-mariners}"
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo ""
echo "=== baseball-terminal macOS Setup ==="
echo "Team: $TEAM"
echo ""

# Step 1: Check for Homebrew
echo "[1/5] Checking Homebrew..."
if ! command -v brew &>/dev/null; then
  echo "  Homebrew not found. Install it first:"
  echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
  exit 1
fi
echo "  Homebrew found."

# Step 2: Install Oh My Posh
echo "[2/5] Checking Oh My Posh..."
if ! command -v oh-my-posh &>/dev/null; then
  echo "  Installing Oh My Posh via Homebrew..."
  brew install jandedobbeleer/oh-my-posh/oh-my-posh
else
  echo "  Oh My Posh already installed."
fi

# Step 3: Install Nerd Font (CaskaydiaCove NF)
echo "[3/5] Checking Nerd Font..."
if ! fc-list 2>/dev/null | grep -qi "CaskaydiaCove" && \
   ! system_profiler SPFontsDataType 2>/dev/null | grep -qi "CaskaydiaCove"; then
  echo "  Installing CaskaydiaCove NF via Oh My Posh..."
  oh-my-posh font install CascadiaCode
else
  echo "  CaskaydiaCove NF already installed."
fi

# Step 4: Add auto-theme sourcing to shell profile
echo "[4/5] Configuring shell profile..."
SHELL_NAME="$(basename "$SHELL")"
if [ "$SHELL_NAME" = "zsh" ]; then
  PROFILE_FILE="$HOME/.zshrc"
elif [ "$SHELL_NAME" = "bash" ]; then
  PROFILE_FILE="$HOME/.bashrc"
else
  PROFILE_FILE="$HOME/.profile"
fi

SOURCE_LINE="export TEAM=\"$TEAM\"; source \"$REPO_ROOT/scripts/auto-theme.sh\""
if ! grep -q "auto-theme.sh" "$PROFILE_FILE" 2>/dev/null; then
  echo "" >> "$PROFILE_FILE"
  echo "# baseball-terminal auto-theme" >> "$PROFILE_FILE"
  echo "$SOURCE_LINE" >> "$PROFILE_FILE"
  echo "  Added auto-theme to $PROFILE_FILE"
else
  echo "  auto-theme already in $PROFILE_FILE."
fi

# Step 5: Copy Claude Code statusline config
echo "[5/5] Setting up Claude Code statusline..."
CLAUDE_DIR="$HOME/.claude"
CLAUDE_SETTINGS="$CLAUDE_DIR/settings.json"
SOURCE_SETTINGS="$REPO_ROOT/claude/settings.json"
mkdir -p "$CLAUDE_DIR"
if [ ! -f "$CLAUDE_SETTINGS" ]; then
  cp "$SOURCE_SETTINGS" "$CLAUDE_SETTINGS"
  echo "  Copied settings.json to $CLAUDE_SETTINGS"
else
  echo "  $CLAUDE_SETTINGS already exists — skipping (back up and re-run to overwrite)."
fi

echo ""
echo "=== Setup complete! ==="
echo "Restart your terminal to see the theme."
echo ""
