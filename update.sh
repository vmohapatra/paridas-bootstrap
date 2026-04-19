#!/usr/bin/env bash
# update.sh — check for and apply updates to paridas-bootstrap
# Run from anywhere: ~/Desktop/ai/paridas-bootstrap/update.sh

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
VERSION_FILE="$REPO_DIR/VERSION"

# ─── verify this is a git repo ────────────────────────────────────────────────
if [ ! -d "$REPO_DIR/.git" ]; then
  echo "Error: $REPO_DIR is not a git repository."
  echo "Clone the repo first: git clone https://github.com/vmohapatra/paridas-bootstrap"
  exit 1
fi

# ─── read local version ───────────────────────────────────────────────────────
LOCAL_VERSION=$(cat "$VERSION_FILE" 2>/dev/null | tr -d '[:space:]')
if [ -z "$LOCAL_VERSION" ]; then
  LOCAL_VERSION="unknown"
fi

echo ""
echo "paridas-bootstrap updater"
echo "─────────────────────────────────────"
echo "Local version : $LOCAL_VERSION"
echo "Repo          : $REPO_DIR"
echo ""

# ─── fetch remote ─────────────────────────────────────────────────────────────
echo "Checking for updates..."
cd "$REPO_DIR"
git fetch origin --quiet

REMOTE_VERSION=$(git show origin/main:VERSION 2>/dev/null | tr -d '[:space:]')
if [ -z "$REMOTE_VERSION" ]; then
  echo "Could not read remote version. Check your internet connection."
  exit 1
fi

echo "Remote version: $REMOTE_VERSION"
echo ""

# ─── compare versions ─────────────────────────────────────────────────────────
if [ "$LOCAL_VERSION" = "$REMOTE_VERSION" ]; then
  echo "Already up to date. Nothing to do."
  echo ""
  exit 0
fi

# ─── show what changed ────────────────────────────────────────────────────────
echo "New version available: $LOCAL_VERSION → $REMOTE_VERSION"
echo ""
echo "Changes since $LOCAL_VERSION:"
git log --oneline HEAD..origin/main
echo ""

# ─── confirm and pull ─────────────────────────────────────────────────────────
printf "Apply update? [y/N] "
read -r CONFIRM
if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
  echo "Update cancelled."
  exit 0
fi

echo ""
echo "Pulling latest..."
git pull origin main --quiet

NEW_VERSION=$(cat "$VERSION_FILE" | tr -d '[:space:]')
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " paridas-bootstrap updated to $NEW_VERSION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Your workspace files are unchanged."
echo "New templates and commands are available in:"
echo "  $REPO_DIR/templates/"
echo ""
echo "To apply new templates to your workspace, re-run:"
echo "  ./setup.sh <yourname>"
echo "(Existing files are skipped — only new additions are created.)"
echo ""
