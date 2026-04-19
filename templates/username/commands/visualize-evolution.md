# /visualize-evolution

Generate an HTML dashboard visualizing goal tracker progress and persona evolution history.
Reads all files in `trackers/` and `evolution/` and produces a single self-contained HTML file.

---

## When to Use

- Retrospective sessions or end-of-quarter reviews
- Before updating persona files — see the full arc before proposing changes
- Any time you want a visual overview instead of reading individual markdown files

---

## Instructions

### Step 1 — Locate the user directory

Determine `<yourname>` from the loaded MEMORY file or from `~/Desktop/ai/` directory listing.
Set `USER_DIR=~/Desktop/ai/<yourname>/`.

### Step 2 — Read all source files

Read every `.md` file in:
- `$USER_DIR/trackers/` — skip `.gitkeep` and sample files
- `$USER_DIR/evolution/` — skip `.gitkeep` and sample files

If a directory is empty or has only sample files, render a placeholder card for that section.

### Step 3 — Generate the HTML

Produce a single self-contained HTML file. No external CSS or JS dependencies — everything inline.

**Page structure:**

```
Header: "Progress Dashboard — <yourname>" + generation date

Section 1: Goal Trackers
  One card per tracker file:
  - Goal name (from file title)
  - Status badge: in-progress (blue) / blocked (red) / complete (green)
  - Phase progress bar: completed phases / total phases
  - Current phase label and next action
  - Blockers list (if any)
  - Last updated date

Section 2: Persona Evolution
  One block per evolution file:
  - Persona name (derived from filename)
  - Horizontal timeline of Evolution Log entries, oldest → newest
    Each node: date · what changed · section affected
    Color-code: added (green) · corrected (amber) · removed (red)
  - Snapshot count (number of dated snapshots in the file)
```

**Style guidelines:**
- Clean, minimal — white background, clear typography, subtle borders
- Status badges and timeline nodes use color sparingly; everything else is greyscale
- Readable at normal browser zoom without horizontal scrolling
- No dark mode toggle needed — keep it simple

### Step 4 — Save and report

Save to: `$USER_DIR/YYYY-MM-DD-visual-report.html`
(use today's date for YYYY-MM-DD)

Print the full file path so the user can open it directly.

---

## Output

A single line after saving:

```
Saved: ~/Desktop/ai/<yourname>/YYYY-MM-DD-visual-report.html
```

Do not summarise the content — let the HTML speak for itself.
