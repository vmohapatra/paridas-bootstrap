#!/usr/bin/env bash
# contribute.sh — contribute genericized workspace improvements back to paridas-bootstrap
# Called by the /contribute-to-bootstrap Claude command after files are written to the repo.
# Usage: ./contribute.sh <yourname> <contrib-slug>

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
YOURNAME="${1:-contributor}"
SLUG="${2:-$(date +%Y%m%d)}"
BRANCH="contrib/${YOURNAME}-${SLUG}"

# ─── verify git repo and clean state ─────────────────────────────────────────
if [ ! -d "$REPO_DIR/.git" ]; then
  echo "Error: must be run from within the paridas-bootstrap repo."
  exit 1
fi

cd "$REPO_DIR"

if ! git diff --quiet || ! git diff --cached --quiet; then
  STAGED=$(git diff --cached --name-only)
  if [ -z "$STAGED" ]; then
    echo "Error: no staged files found. Stage the contributed files first."
    exit 1
  fi
fi

# ─── check for staged files ───────────────────────────────────────────────────
STAGED=$(git diff --cached --name-only)
if [ -z "$STAGED" ]; then
  echo "Error: no staged files to contribute. Nothing to do."
  exit 1
fi

echo ""
echo "paridas-bootstrap contribution"
echo "─────────────────────────────────────"
echo "Contributor : $YOURNAME"
echo "Branch      : $BRANCH"
echo ""
echo "Files to contribute:"
echo "$STAGED" | sed 's/^/  /'
echo ""

# ─── create branch ────────────────────────────────────────────────────────────
if git show-ref --verify --quiet "refs/heads/$BRANCH"; then
  echo "Branch $BRANCH already exists — switching to it."
  git checkout "$BRANCH"
else
  git checkout -b "$BRANCH"
fi

# ─── commit ───────────────────────────────────────────────────────────────────
FILE_COUNT=$(echo "$STAGED" | wc -l | tr -d ' ')
FIRST_FILE=$(echo "$STAGED" | head -1 | xargs basename)

git commit -m "contrib($YOURNAME): add $FILE_COUNT genericized file(s) from workspace

Files contributed:
$(echo "$STAGED" | sed 's/^/- /')

Genericized from $YOURNAME's workspace for reuse across bootstrap workspaces."

# ─── push and open PR ─────────────────────────────────────────────────────────
git push origin "$BRANCH"

CHANGED_LIST=$(echo "$STAGED" | sed 's/^/- /')
EXTRA=""
[ "$FILE_COUNT" -gt 1 ] && EXTRA=" + $((FILE_COUNT - 1)) more"
PR_TITLE="contrib($YOURNAME): $FIRST_FILE$EXTRA"

PR_BODY="## Description

Contribution from \`$YOURNAME\`'s workspace — genericized for reuse across bootstrap workspaces.

---

## Summary

$FILE_COUNT file(s) contributed. Each has been reviewed and genericized (personal names and specifics replaced with placeholders).

---

## What Changed

$CHANGED_LIST

---

## Contributor checklist

- [ ] Personal names and specifics replaced with generic placeholders
- [ ] File tested in a workspace session before contributing
- [ ] Naming convention matches existing bootstrap files

---

## Version Bump

- [ ] \`patch\` — bug fixes, small updates
- [ ] \`minor\` — new features, non-breaking
- [ ] \`major\` — breaking changes
- [x] \`none\` — docs, chore, no version change needed"

gh pr create \
  --title "$PR_TITLE" \
  --draft \
  --body "$PR_BODY"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " Draft PR opened — review and update version bump before merging"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
