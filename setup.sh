#!/usr/bin/env bash
# setup.sh — AI workspace bootstrap
# Usage: ./setup.sh [yourname]
# If yourname is not provided, you will be prompted.

set -e

# ─── resolve username ──────────────────────────────────────────────────────────
if [ -n "$1" ]; then
  YOURNAME="$1"
else
  printf "Enter your username (used for folder and file names): "
  read -r YOURNAME
fi

if [ -z "$YOURNAME" ]; then
  echo "Error: username is required."
  exit 1
fi

# ─── detect OS and set AI_BASE ─────────────────────────────────────────────────
OS_TYPE=$(uname -s 2>/dev/null || echo "Windows")

case "$OS_TYPE" in
  Darwin)
    AI_BASE=~/Desktop/ai
    ;;
  MINGW*|MSYS*|CYGWIN*)
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

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
USER_DIR="$AI_BASE/$YOURNAME"

echo ""
echo "Platform : $OS_TYPE"
echo "AI base  : $AI_BASE"
echo "Your dir : $USER_DIR"
echo "Repo     : $REPO_DIR"
echo ""

# ─── create directory structure ───────────────────────────────────────────────
mkdir -p "$AI_BASE/learning-guides"
mkdir -p "$USER_DIR/insights"
mkdir -p "$USER_DIR/learnings"
mkdir -p "$USER_DIR/personas"
mkdir -p "$USER_DIR/plans"
mkdir -p "$USER_DIR/commands"
mkdir -p "$USER_DIR/trackers"
mkdir -p "$USER_DIR/evolution"

# ─── copy learning guides ─────────────────────────────────────────────────────
if [ -d "$REPO_DIR/learning-guides" ]; then
  cp "$REPO_DIR/learning-guides/"*.md "$AI_BASE/learning-guides/" 2>/dev/null && \
    echo "  [ok] learning-guides copied from repo" || \
    echo "  [skip] no .md files found in repo learning-guides/"
else
  cat > "$AI_BASE/learning-guides/README.md" <<'EOF'
# Learning Guides

Place the following files here from the paridas-bootstrap repo:
- Claude-AI-Learning-Guide.md
- Claude-Professional-OS-Guide.md
- Cursor-AI-Learning-Guide.md
EOF
  echo "  [placeholder] learning-guides/README.md created"
fi

# ─── copy and personalise template files ──────────────────────────────────────
TMPL="$REPO_DIR/templates"

# PERSONA
PERSONA_SRC="$TMPL/PERSONA_USERNAME_GLOBAL.md"
PERSONA_DST="$USER_DIR/PERSONA_${YOURNAME}_GLOBAL.md"
if [ ! -f "$PERSONA_DST" ]; then
  sed "s/<yourname>/$YOURNAME/g; s/USERNAME/$YOURNAME/g" "$PERSONA_SRC" > "$PERSONA_DST"
  echo "  [ok] PERSONA_${YOURNAME}_GLOBAL.md created"
else
  echo "  [skip] PERSONA_${YOURNAME}_GLOBAL.md already exists"
fi

# MEMORY
MEMORY_SRC="$TMPL/MEMORY_USERNAME_GLOBAL.md"
MEMORY_DST="$USER_DIR/MEMORY_${YOURNAME}_GLOBAL.md"
if [ ! -f "$MEMORY_DST" ]; then
  sed "s/<yourname>/$YOURNAME/g; s/USERNAME/$YOURNAME/g" "$MEMORY_SRC" > "$MEMORY_DST"
  echo "  [ok] MEMORY_${YOURNAME}_GLOBAL.md created"
else
  echo "  [skip] MEMORY_${YOURNAME}_GLOBAL.md already exists"
fi

# CLAUDE.md
CLAUDE_SRC="$TMPL/CLAUDE.md"
CLAUDE_DST=~/.claude/CLAUDE.md
mkdir -p ~/.claude
if [ ! -f "$CLAUDE_DST" ]; then
  sed "s/<yourname>/$YOURNAME/g" "$CLAUDE_SRC" > "$CLAUDE_DST"
  echo "  [ok] ~/.claude/CLAUDE.md created"
else
  echo "  [skip] ~/.claude/CLAUDE.md already exists — review $CLAUDE_SRC manually and merge what you need"
fi

# ─── install Claude Code skill (if ~/.claude/skills exists or can be created) ──
SKILL_SRC="$REPO_DIR/claude-code/skills/ai-ready-setup"
SKILL_DST=~/.claude/skills/ai-ready-setup
if [ -d "$SKILL_SRC" ]; then
  mkdir -p ~/.claude/skills
  if [ ! -d "$SKILL_DST" ]; then
    cp -r "$SKILL_SRC" "$SKILL_DST"
    echo "  [ok] ai-ready-setup skill installed to ~/.claude/skills/"
  else
    echo "  [skip] ai-ready-setup skill already installed"
  fi
fi

# ─── write bootstrap marker ───────────────────────────────────────────────────
REPO_URL=$(git -C "$REPO_DIR" remote get-url origin 2>/dev/null || echo "unknown")
cat > "$USER_DIR/.bootstrap-source" <<EOF
repo=$REPO_URL
bootstrap_dir=$REPO_DIR
version=$(cat "$REPO_DIR/VERSION" 2>/dev/null | tr -d '[:space:]')
setup=$(date +%Y-%m-%d)
user=$YOURNAME
EOF
echo "  [ok] .bootstrap-source marker written"

# ─── install standalone sync launcher ─────────────────────────────────────────
sed \
  -e "s|__BOOTSTRAP_DIR__|$REPO_DIR|g" \
  -e "s|__BOOTSTRAP_REPO__|$REPO_URL|g" \
  -e "s|__YOURNAME__|$YOURNAME|g" \
  "$REPO_DIR/templates/sync-launcher.sh" > "$AI_BASE/sync.sh"
chmod +x "$AI_BASE/sync.sh"
echo "  [ok] standalone sync launcher written to $AI_BASE/sync.sh"

# ─── summary ──────────────────────────────────────────────────────────────────
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " AI workspace ready"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "  $AI_BASE/learning-guides/"
echo "  $USER_DIR/"
echo "    ├── insights/"
echo "    ├── learnings/"
echo "    ├── personas/"
echo "    ├── plans/"
echo "    ├── commands/"
echo "    ├── trackers/"
echo "    ├── evolution/"
echo "    ├── PERSONA_${YOURNAME}_GLOBAL.md"
echo "    └── MEMORY_${YOURNAME}_GLOBAL.md"
echo ""
if ! command -v claude &>/dev/null; then
  echo "Next step: install Claude Code — https://claude.ai/code"
  echo ""
fi

# ─── persona kickoff (if Claude Code is installed) ────────────────────────────
if command -v claude &>/dev/null; then
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo " Let's set up your first persona"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
  echo "A persona tells Claude how to think, communicate, and behave"
  echo "in a specific role — Debate Coach, Budget Planner, Language Tutor, etc."
  echo ""
  printf "What role would you like Claude to take on first? (press Enter to skip): "
  read -r PERSONA_ROLE
  if [ -n "$PERSONA_ROLE" ]; then
    echo ""
    echo "Starting Claude Code session for: $PERSONA_ROLE"
    echo ""
    claude "Create persona for: $PERSONA_ROLE"
  else
    echo ""
    echo "Skipped. When ready, open Claude Code and run:"
    echo "  /create-persona"
    echo ""
  fi
fi
