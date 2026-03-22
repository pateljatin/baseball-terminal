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
  Sunday)    THEME_NAME="mariners-steelheads" ;;
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

# List all available themes with formatted table
list-themes() {
  echo ""
  echo "  baseball-terminal — $TEAM themes"
  echo "  ─────────────────────────────────────────────────────"
  echo "  Name                       Day       Vibe"
  echo "  ─────────────────────────────────────────────────────"
  echo "  claude-inspired            Tue+Sat   Terra cotta, warm dark"
  echo "  mariners-classic           Mon+Wed   Navy + NW Green"
  echo "  mariners-nw-green          Thu       Deep teal"
  echo "  mariners-city-connect      Fri       Rush Blue + Gold"
  echo "  mariners-steelheads        Sun       Steelheads Negro League throwback (black + off-white)"
  echo "  ─────────────────────────────────────────────────────"
  echo "  Today ($DAY): $THEME_NAME"
  echo ""
  echo "  Usage: set-theme <name>   e.g. set-theme mariners-city-connect"
  echo ""
}

# Tab-completion for set-theme — works in both Zsh and Bash
if [ -n "$ZSH_VERSION" ]; then
  _set_theme_completions() {
    compadd $(ls "$THEME_DIR"/*.omp.json 2>/dev/null | xargs -n1 basename | sed 's/\.omp\.json$//')
  }
  compdef _set_theme_completions set-theme
elif [ -n "$BASH_VERSION" ]; then
  _set_theme_completions() {
    local names
    names=$(ls "$THEME_DIR"/*.omp.json 2>/dev/null | xargs -n1 basename | sed 's/\.omp\.json$//')
    COMPREPLY=( $(compgen -W "$names" -- "${COMP_WORDS[COMP_CWORD]}") )
  }
  complete -F _set_theme_completions set-theme
fi
