#!/usr/bin/env bash
# auto-contribute.sh — silently contribute new workspace files back to bootstrap
# Run in background by Claude at session start when a completed tracker is detected.
# Usage: ./auto-contribute.sh <workspace_dir>
#
# What it does:
#   1. Reads .bootstrap-source to find the bootstrap repo and username
#   2. Finds new command files in the workspace not yet in bootstrap templates
#   3. Mechanically generalizes each file (sed substitutions)
#   4. Stages them in the bootstrap repo
#   5. Calls contribute.sh to open a draft PR
#
# What it does NOT do:
#   - Contribute personal persona files (PERSONA_<yourname>_GLOBAL.md)
#   - Contribute plans, projects, trackers, learnings, or memory files
#   - Notify or interrupt the active Claude session
#   - Require any user interaction

set -e

WORKSPACE_DIR="${1:-}"

# ─── resolve workspace ────────────────────────────────────────────────────────
if [ -z "$WORKSPACE_DIR" ]; then
  echo "[auto-contribute] Error: workspace directory required." >&2
  exit 1
fi

if [ ! -d "$WORKSPACE_DIR" ]; then
  echo "[auto-contribute] Error: workspace not found at $WORKSPACE_DIR" >&2
  exit 1
fi

# ─── read .bootstrap-source ───────────────────────────────────────────────────
SOURCE_FILE="$WORKSPACE_DIR/.bootstrap-source"
if [ ! -f "$SOURCE_FILE" ]; then
  echo "[auto-contribute] No .bootstrap-source found — skipping." >&2
  exit 0
fi

BOOTSTRAP_DIR=$(grep '^bootstrap_dir=' "$SOURCE_FILE" | cut -d= -f2-)
YOURNAME=$(grep '^user=' "$SOURCE_FILE" | cut -d= -f2-)

if [ -z "$BOOTSTRAP_DIR" ] || [ ! -d "$BOOTSTRAP_DIR/.git" ]; then
  echo "[auto-contribute] Bootstrap repo not found at $BOOTSTRAP_DIR — skipping." >&2
  exit 0
fi

# ─── find new commands ────────────────────────────────────────────────────────
WORKSPACE_CMDS="$WORKSPACE_DIR/commands"
BOOTSTRAP_CMDS="$BOOTSTRAP_DIR/templates/username/commands"

if [ ! -d "$WORKSPACE_CMDS" ]; then
  echo "[auto-contribute] No commands directory found — nothing to contribute." >&2
  exit 0
fi

CANDIDATES=()
for f in "$WORKSPACE_CMDS"/*.md; do
  [ -f "$f" ] || continue
  fname=$(basename "$f")
  if [ ! -f "$BOOTSTRAP_CMDS/$fname" ]; then
    CANDIDATES+=("$f")
  fi
done

if [ "${#CANDIDATES[@]}" -eq 0 ]; then
  echo "[auto-contribute] No new commands to contribute — skipping." >&2
  exit 0
fi

# ─── generalize and stage each candidate ──────────────────────────────────────
STAGED=0
for f in "${CANDIDATES[@]}"; do
  fname=$(basename "$f")
  dst="$BOOTSTRAP_CMDS/$fname"

  # Mechanical generalization: replace username and common personal patterns
  sed \
    -e "s|$YOURNAME|<yourname>|g" \
    -e "s|~/Desktop/ai/$YOURNAME/|~/Desktop/ai/<yourname>/|g" \
    -e "s|PERSONA_${YOURNAME}_GLOBAL|PERSONA_<yourname>_GLOBAL|g" \
    -e "s|MEMORY_${YOURNAME}_GLOBAL|MEMORY_<yourname>_GLOBAL|g" \
    "$f" > "$dst"

  git -C "$BOOTSTRAP_DIR" add "templates/username/commands/$fname"
  STAGED=$((STAGED + 1))
done

if [ "$STAGED" -eq 0 ]; then
  exit 0
fi

# ─── open draft PR via contribute.sh ─────────────────────────────────────────
SLUG="commands-$(date +%Y%m%d)"
bash "$BOOTSTRAP_DIR/contribute.sh" "$YOURNAME" "$SLUG" \
  >> "/tmp/paridas-bootstrap-contribute-$(date +%Y%m%d).log" 2>&1

echo "[auto-contribute] Draft PR opened for $STAGED new command(s). Log: /tmp/paridas-bootstrap-contribute-$(date +%Y%m%d).log" >&2
