#!/usr/bin/env bash
# sync.sh — sync bootstrap-managed files into your AI workspace
# Usage: ./sync.sh <yourname>
#
# Copies all bootstrap-managed files into ~/Desktop/ai/<yourname>/
# User-added files (custom commands, personas, plans, etc.) are never touched.
# Always run after ./update.sh to pick up new templates and commands.

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
VERSION=$(cat "$REPO_DIR/VERSION" 2>/dev/null | tr -d '[:space:]')

# ─── resolve username ──────────────────────────────────────────────────────────
if [ -n "$1" ]; then
  YOURNAME="$1"
else
  printf "Enter your username: "
  read -r YOURNAME
fi

if [ -z "$YOURNAME" ]; then
  echo "Error: username is required."
  exit 1
fi

# ─── detect AI_BASE ───────────────────────────────────────────────────────────
OS_TYPE=$(uname -s 2>/dev/null || echo "Windows")
case "$OS_TYPE" in
  Darwin|MINGW*|MSYS*|CYGWIN*)
    AI_BASE=~/Desktop/ai
    ;;
  Linux)
    if grep -qi microsoft /proc/version 2>/dev/null; then
      WIN_USER=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
      AI_BASE=/mnt/c/Users/$WIN_USER/Desktop/ai
    elif [ -d ~/Desktop ]; then
      AI_BASE=~/Desktop/ai
    else
      AI_BASE=~/ai
    fi
    ;;
  *)
    AI_BASE=~/Desktop/ai
    ;;
esac

USER_DIR="$AI_BASE/$YOURNAME"
TMPL="$REPO_DIR/templates/username"

if [ ! -d "$USER_DIR" ]; then
  echo "Error: workspace not found at $USER_DIR"
  echo "Run ./setup.sh $YOURNAME first."
  exit 1
fi

SYNCED_VERSION_FILE="$USER_DIR/.bootstrap-version"
SYNCED_VERSION=$(cat "$SYNCED_VERSION_FILE" 2>/dev/null | tr -d '[:space:]')

echo ""
echo "paridas-bootstrap sync"
echo "─────────────────────────────────────"
echo "Bootstrap version : $VERSION"
echo "Workspace version : ${SYNCED_VERSION:-not set}"
echo "Workspace         : $USER_DIR"
echo ""

if [ "$SYNCED_VERSION" = "$VERSION" ]; then
  echo "Workspace is already up to date with bootstrap $VERSION."
  echo ""
  exit 0
fi

UPDATED=0

# ─── sync commands ────────────────────────────────────────────────────────────
if [ -d "$TMPL/commands" ]; then
  mkdir -p "$USER_DIR/commands"
  for f in "$TMPL/commands/"*.md; do
    [ -f "$f" ] || continue
    fname=$(basename "$f")
    cp "$f" "$USER_DIR/commands/$fname"
    echo "  [sync] commands/$fname"
    UPDATED=1
  done
fi

# ─── sync persona examples ────────────────────────────────────────────────────
if [ -d "$TMPL/personas/examples" ]; then
  mkdir -p "$USER_DIR/personas/examples"
  for f in "$TMPL/personas/examples/"*.md; do
    [ -f "$f" ] || continue
    fname=$(basename "$f")
    cp "$f" "$USER_DIR/personas/examples/$fname"
    echo "  [sync] personas/examples/$fname"
    UPDATED=1
  done
fi

# ─── sync learning guides ─────────────────────────────────────────────────────
if [ -d "$REPO_DIR/learning-guides" ]; then
  mkdir -p "$AI_BASE/learning-guides"
  for f in "$REPO_DIR/learning-guides/"*.md; do
    [ -f "$f" ] || continue
    fname=$(basename "$f")
    cp "$f" "$AI_BASE/learning-guides/$fname"
    echo "  [sync] learning-guides/$fname"
    UPDATED=1
  done
fi

# ─── record synced version ────────────────────────────────────────────────────
echo "$VERSION" > "$SYNCED_VERSION_FILE"

echo ""
if [ "$UPDATED" -eq 1 ]; then
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo " Workspace synced to bootstrap $VERSION"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
  echo "Your custom files (commands, personas, plans, etc.) were not touched."
else
  echo "Nothing to sync."
fi
echo ""
