# Changelog

All notable changes to paridas-bootstrap are documented here.
Format: version · date · what changed.

---

## [0.0.2-SNAPSHOT] - 2026-04-19

### Added
- Auto version bump GitHub Actions workflow — reads checked bump type from PR body, bumps VERSION once per PR, commits back to branch
- PR description template with Description, Summary, What Changed, and Version Bump sections
- Squash-only merge enforced on main
- Branch protection on main — PRs required, no direct pushes

---

## [0.0.1-SNAPSHOT] - 2026-04-19

### Added
- `setup.sh` — cross-platform workspace bootstrap (macOS, Windows, WSL, Linux)
- `update.sh` — checks local bootstrap version against GitHub, pulls on confirmation
- `sync.sh` — syncs bootstrap-managed files into user workspace without touching user files
- `VERSION` file for semver tracking
- Templates: PERSONA, MEMORY, CLAUDE.md starters
- Commands: create-persona, create-plan, create-tracker, articulate, visualize-evolution
- Persona examples: Debate Coach, Mandarin Teacher (genericized for reuse)
- Learning guides: Claude AI, Claude Professional OS, Cursor AI
- Claude Code skill: ai-ready-setup

---
