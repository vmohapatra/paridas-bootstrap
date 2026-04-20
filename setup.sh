#!/usr/bin/env bash
# setup.sh — AI workspace bootstrap
# Usage: ./setup.sh [yourname]
# If yourname is not provided, you will be prompted.

set -e

REPO_DIR_EARLY="$(cd "$(dirname "$0")" && pwd)"

# ─── consent gate ─────────────────────────────────────────────────────────────
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " IMPORTANT — Implied Consent & Data Use Notice"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "This bootstrap includes a /contribute-to-bootstrap command that,"
echo "when explicitly run by you, can scan your workspace, propose"
echo "genericized versions of your commands and personas, and open a"
echo "pull request to the public paridas-bootstrap repository."
echo ""
echo "Nothing is extracted or contributed automatically — every file"
echo "requires your explicit approval before it is submitted."
echo ""
echo "By continuing you acknowledge this capability exists and accept"
echo "responsibility for reviewing any content before contributing it."
echo ""
echo "Full notice: $REPO_DIR_EARLY/CONSENT.md"
echo ""
printf "Press Enter to accept and continue, or Ctrl+C to exit: "
read -r _
echo ""

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

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

# Derive AI_BASE from repo location — this is always correct regardless of
# whether the repo was cloned to OneDrive Desktop, local Desktop, or elsewhere.
AI_BASE="$(dirname "$REPO_DIR")"
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
mkdir -p "$USER_DIR/projects"
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
  sed "s|~/Desktop/ai/|$AI_BASE/|g; s/<yourname>/$YOURNAME/g; s/USERNAME/$YOURNAME/g" "$PERSONA_SRC" > "$PERSONA_DST"
  echo "  [ok] PERSONA_${YOURNAME}_GLOBAL.md created"
else
  echo "  [skip] PERSONA_${YOURNAME}_GLOBAL.md already exists"
fi

# MEMORY
MEMORY_SRC="$TMPL/MEMORY_USERNAME_GLOBAL.md"
MEMORY_DST="$USER_DIR/MEMORY_${YOURNAME}_GLOBAL.md"
if [ ! -f "$MEMORY_DST" ]; then
  sed "s|~/Desktop/ai/|$AI_BASE/|g; s/<yourname>/$YOURNAME/g; s/USERNAME/$YOURNAME/g" "$MEMORY_SRC" > "$MEMORY_DST"
  echo "  [ok] MEMORY_${YOURNAME}_GLOBAL.md created"
else
  echo "  [skip] MEMORY_${YOURNAME}_GLOBAL.md already exists"
fi

CLAUDE_SRC="$TMPL/CLAUDE.md"
CLAUDE_DST=~/.claude/CLAUDE.md
mkdir -p ~/.claude

# ─── copy commands and personas from templates ────────────────────────────────
TMPL_USER="$TMPL/username"

if [ -d "$TMPL_USER/commands" ]; then
  for f in "$TMPL_USER/commands/"*.md; do
    [ -f "$f" ] || continue
    sed "s|~/Desktop/ai/<yourname>/|$AI_BASE/$YOURNAME/|g" "$f" > "$USER_DIR/commands/$(basename "$f")"
  done
  echo "  [ok] commands/ populated from templates"
fi

if [ -d "$TMPL_USER/personas" ]; then
  [ -f "$TMPL_USER/personas/PERSONA_ROLE.md" ] && \
    sed "s|~/Desktop/ai/<yourname>/|$AI_BASE/$YOURNAME/|g" "$TMPL_USER/personas/PERSONA_ROLE.md" > "$USER_DIR/personas/PERSONA_ROLE.md"
  if [ -d "$TMPL_USER/personas/examples" ]; then
    for f in "$TMPL_USER/personas/examples/"*.md; do
      [ -f "$f" ] || continue
      sed "s|~/Desktop/ai/<yourname>/|$AI_BASE/$YOURNAME/|g" "$f" > "$USER_DIR/personas/$(basename "$f")"
    done
    echo "  [ok] personas/ populated with examples"
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

# Write bootstrap version so sync.sh knows setup already ran at this version
cat "$REPO_DIR/VERSION" 2>/dev/null | tr -d '[:space:]' > "$USER_DIR/.bootstrap-version"
echo "  [ok] .bootstrap-version written"

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
echo "    ├── projects/"
echo "    ├── commands/"
echo "    ├── trackers/"
echo "    ├── evolution/"
echo "    ├── PERSONA_${YOURNAME}_GLOBAL.md"
echo "    └── MEMORY_${YOURNAME}_GLOBAL.md"
echo ""
# ─── Claude Code integration ──────────────────────────────────────────────────
if command -v claude &>/dev/null; then

  # Import ai-ready-setup skill
  SKILLS_SRC="$REPO_DIR/claude-code/skills"
  if [ -d "$SKILLS_SRC" ]; then
    mkdir -p ~/.claude/skills
    for skill_dir in "$SKILLS_SRC"/*/; do
      [ -d "$skill_dir" ] || continue
      skill_name=$(basename "$skill_dir")
      cp -r "$skill_dir" ~/.claude/skills/
      echo "  [ok] skill imported: ~/.claude/skills/$skill_name"
    done
  fi

  # Update ~/.claude/CLAUDE.md with bootstrap template (dedup)
  if [ ! -f "$CLAUDE_DST" ]; then
    sed "s|~/Desktop/ai/|$AI_BASE/|g; s/<yourname>/$YOURNAME/g" "$CLAUDE_SRC" > "$CLAUDE_DST"
    echo "  [ok] ~/.claude/CLAUDE.md created"
  elif ! grep -q "## Session Start" "$CLAUDE_DST"; then
    echo "" >> "$CLAUDE_DST"
    sed "s|~/Desktop/ai/|$AI_BASE/|g; s/<yourname>/$YOURNAME/g" "$CLAUDE_SRC" >> "$CLAUDE_DST"
    echo "  [ok] ~/.claude/CLAUDE.md updated with bootstrap template"
  else
    echo "  [skip] ~/.claude/CLAUDE.md already contains bootstrap template"
  fi

  # Persona kickoff
  echo ""
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

else

  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo " Claude Code not detected"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
  echo "Install Claude Code with:"
  echo ""
  echo "  curl -fsSL https://claude.ai/install.sh | sh"
  echo ""
  echo "Then re-run this script to import the skill and complete setup:"
  echo ""
  echo "  ./setup.sh $YOURNAME"
  echo ""

fi
