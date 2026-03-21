#!/usr/bin/env bash
# auto-theme.sh — Day-of-week Oh My Posh theme switcher (Mac/Linux Zsh/Bash)
# Reads $TEAM to locate the correct teams/ subfolder.
# Source this in your .zshrc or .bashrc to auto-switch on every new shell.

# Default team if not set
TEAM="${TEAM:-seattle-mariners}"

# Resolve themes directory (relative to this script's location)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_DIR="$SCRIPT_DIR/../teams/$TEAM/themes"

# Day-of-week schedule (matches real uniform rotation)
DAY=$(date +%A)
case "$DAY" in
  Monday)    THEME_NAME="mariners-classic" ;;
  Tuesday)   THEME_NAME="claude-inspired" ;;
  Wednesday) THEME_NAME="mariners-classic" ;;
  Thursday)  THEME_NAME="mariners-nw-green" ;;
  Friday)    THEME_NAME="mariners-city-connect" ;;
  Saturday)  THEME_NAME="claude-inspired" ;;
  Sunday)    THEME_NAME="mariners-cream-sunday" ;;
esac

# Apply the theme
THEME_PATH="$THEME_DIR/$THEME_NAME.omp.json"
if [ -f "$THEME_PATH" ]; then
  eval "$(oh-my-posh init "$(basename "$SHELL")" --config "$THEME_PATH")"
  echo "Theme: $THEME_NAME ($DAY)"
else
  echo "Warning: Theme not found: $THEME_PATH" >&2
fi

# Manual override function
set-theme() {
  local name="$1"
  local override="$THEME_DIR/$name.omp.json"
  if [ -f "$override" ]; then
    eval "$(oh-my-posh init "$(basename "$SHELL")" --config "$override")"
    echo "Theme switched to: $name"
  else
    echo "No theme named '$name' in $THEME_DIR" >&2
  fi
}
