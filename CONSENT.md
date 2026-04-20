# Implied Consent & Data Use Notice

**Read this before using paridas-bootstrap.**

---

## What this bootstrap does

paridas-bootstrap sets up a personal AI workspace on your machine and installs tools that help Claude Code maintain context about how you work. Over time, your workspace accumulates commands, personas, plans, and other structured content that you build through your sessions.

---

## What you are consenting to

By running `setup.sh` and typing **"I agree"**, you acknowledge and accept the following:

### 1. Workspace content can be read by Claude Code

The bootstrap configures Claude Code to read files in your workspace (`~/Desktop/ai/<yourname>/`) at the start of every session. This is how Claude maintains context about you across sessions. These files live on your machine and are not transmitted anywhere automatically.

### 2. The `/contribute-to-bootstrap` command can extract and generalize workspace content

This bootstrap includes a command (`/contribute-to-bootstrap`) that, when explicitly run by you, will:
- Scan your workspace for commands, personas, and other reusable content you have built
- Propose genericized versions of that content (personal names, specifics, and identifying information removed)
- Require your explicit approval for each file before anything is contributed
- Open a draft pull request to the public paridas-bootstrap GitHub repository

**This command only runs when you invoke it. Nothing is extracted or contributed automatically.**

### 3. Approved contributions open a draft PR — the maintainer decides what gets merged

Any content you approve through `/contribute-to-bootstrap` is submitted as a **draft pull request** to the public paridas-bootstrap repository (`https://github.com/vmohapatra/paridas-bootstrap`). The repository maintainer reviews every PR independently and may merge, request changes, or close it. Nothing is merged automatically.

### 4. You are responsible for what you contribute

Before approving any contribution, verify that:
- No personal names, private details, or identifying information remain
- No confidential, proprietary, or sensitive content is included
- You have the right to contribute the content

The bootstrap makes a best effort to generalize content, but you are the final reviewer before the PR is opened.

---

## What this bootstrap does NOT do

- It does not automatically transmit any data from your workspace
- It does not collect usage analytics or telemetry
- It does not access your workspace without Claude Code being explicitly invoked
- It does not contribute anything without your explicit per-file approval

---

## If you do not agree

Do not proceed with `setup.sh`. You are free to review the source code of this repository and use its components manually without running the automated setup.

---

## Questions

Review the source code at `https://github.com/vmohapatra/paridas-bootstrap` or open an issue if you have questions about how the bootstrap handles your data.
