# Cursor AI Learning Guide
*Based on Intro to Cursor Session (February 11, 2026)*

## Table of Contents
1. [Getting Started](#getting-started)
2. [Understanding Core Concepts](#understanding-core-concepts)
3. [Configuration: Rules, Skills, and Commands](#configuration)
4. [Working Modes](#working-modes)
5. [Plan Mode and Multi-Agent Workflows](#plan-mode)
6. [MCP Integrations](#mcp-integrations)
7. [CLI Usage](#cli-usage)
8. [Best Practices](#best-practices)
9. [Advanced Tips](#advanced-tips)

---

## Getting Started

### Step 1: Installation and Version Check
1. Download Cursor from cursor.com
2. Verify you're on the latest version:
   - Go to **Cursor** → **About Cursor**
   - Ensure you're on version **2.4.3** or later
   - This version includes: skills, sub-agents, and latest composer model

### Step 2: Enable Models
1. Go to **Settings** → **Cursor Settings** → **Models**
2. Turn on the models you want to use
3. Note: Admins can whitelist/blacklist certain models
4. Not all models are enabled by default - you need to enable them manually

### Step 3: Get Support
If you encounter issues:
- Copy version info from **Cursor** → **About**
- Copy request ID: Click three dots → **Copy Request ID**
- Email: hi@cursor.com

---

## Understanding Core Concepts

### The Two Pillars of AI Coding Performance

**1. Model (75% of performance)**
- The underlying AI model (GPT, Claude, Gemini, etc.)
- Performance is locked in based on training
- Cannot be modified

**2. Context (25% of performance)**
- This is what you can control
- Critical for reducing hallucinations and improving code understanding
- Delivered through multiple methods

### How Context Works in Cursor

#### Automated Context
- **Code Indexing**: Cursor automatically indexes all code in your sidebar
- **Semantic Search**: When you ask questions, relevant code chunks are automatically added to context
- Works even on large codebases

#### Manual Context Addition
1. **@ Symbol**: Add files directly
   - Type `@filename.py` to add specific files
2. **Drag and Drop**: Drag files into the chat
3. **Right-Click**: Right-click file → **Add file to chat**
4. **Images**: Upload images to the chat

---

## Configuration

### Understanding Rules, Skills, and Commands

#### Rules
**When to use:** Guide agent behavior that should ALWAYS or CONDITIONALLY apply

**Types:**
1. **Always Apply Rules**: Content always in context
2. **Glob Pattern Rules**: Apply when specific file types are in context (e.g., `*.ts`, `*.js`)

**Best Practices:**
- Start with existing documentation (coding standards, best practices, testing procedures)
- Add what you'd give to a new engineer onboarding
- Keep concise - rules use tokens from context window
- Add rules to fix recurring mistakes

**Location:**
```
.cursor/
  └── rules/
      └── your-rule.mdc
```

**Format (MDC file):**
```markdown
---
description: "Always use npm, never yarn"
alwaysApply: true
---

Project uses npm as package manager. Never use yarn or pnpm.
```

**Glob pattern example:**
```markdown
---
description: "React best practices"
globs: ["*.tsx", "*.jsx"]
---

Use functional components with hooks. Avoid class components.
```

**Scopes:**
1. **User Rules**: Personal, on your machine only
2. **Project Rules**: Committed to source control (in `.cursor/` folder)
3. **Enterprise Rules**: Set by admins at cursor.com/dashboard → Shared Knowledge

---

#### Skills
**When to use:** Reusable workflows that can be invoked manually OR automatically by the agent

**Key Difference from Rules:**
- Skills use "progressive disclosure" - only description/name is always visible
- Full content loaded only when skill is invoked
- Saves context window space

**Create a Skill:**
```bash
# Press / in chat
/create skill
```

**Skill Structure (MDC file):**
```markdown
---
name: "run-linter"
description: "Run project linter and fix issues"
---

Run the appropriate linter for this project (eslint, pylint, etc.)
and automatically fix issues where possible.
```

**Manual-Only Skills:**
Add `disableModelInvocation: true` to make skills only callable by user:
```markdown
---
name: "jira-ticket"
description: "Pull Jira ticket details"
disableModelInvocation: true
---

Use MCP to fetch the Jira ticket information...
```

**Skills Can Include:**
- Script folders
- Assets
- Additional files the agent might need

---

#### Commands (Legacy)
- Commands are being replaced by Skills
- Use `/migrate` to convert existing commands to skills
- Only rules with `alwaysApply: true` or glob patterns remain as rules

---

### Setting Up Your .cursor Folder

**Initial Setup:**
```bash
# Create the folder (not created automatically)
mkdir .cursor
mkdir .cursor/rules
mkdir .cursor/skills
```

**Nested Rules (for monorepos):**
```
project/
├── .cursor/
│   └── rules/
│       └── general.mdc
├── backend/
│   └── .cursor/
│       └── rules/
│           └── python.mdc
└── frontend/
    └── .cursor/
        └── rules/
            └── typescript.mdc
```

---

## Working Modes

### Agent Mode (Default)
**Capabilities:** Read AND Write
- Creates/modifies files
- Runs commands
- Makes code changes

**When to use:** Implementing features, fixing bugs, refactoring

---

### Ask Mode
**Capabilities:** Read ONLY
- No file creation or modification
- Perfect for exploration and learning

**When to use:**
- Researching technologies: "Should I use duck DB or Postgres?"
- Discussing architecture decisions
- Learning about codebase
- Creating diagrams (renders in chat directly)
- Comparing options before implementing

**Example:**
```
I am using modal for deployment, it has 24 gigs and my data
will be used for analytics. What DB do you recommend?
Do some web research.
```

---

### Plan Mode
**Purpose:** Create detailed implementation plan before coding

**Workflow:**
1. Switch to **Plan Mode**
2. Enter your task
3. Agent explores codebase and creates plan
4. Review the plan (it's a markdown file - you can edit it)
5. Click **Build** to execute

**Why Use Plan Mode:**
- Puts compute upfront in planning phase
- Creates explicit, reviewable implementation steps
- Enables parallelization with sub-agents
- Reduces wasted effort

**Pro Tip:**
- Use a "thinking model" (Claude Opus, GPT-4) for planning
- Switch to faster/cheaper model before clicking "Build"
- Detailed plans allow any model to execute successfully

---

### Debug Mode
**Purpose:** Automated debugging with AI

**How it works:**
1. Agent hypothesizes about bug causes
2. Adds logs to your system
3. Asks you to reproduce the bug
4. Tests hypotheses
5. Identifies the bug
6. Removes logs when done

**When to use:** When you have a bug but unsure of root cause

---

## Plan Mode and Multi-Agent Workflows

### Creating Plans with Parallelization

**Step 1: Create Plan with Parallel Structure**

Use a skill to guide parallel planning:
```markdown
# Create this as a skill
---
name: "parallel-guidance"
description: "Structure plan for parallel execution"
---

Structure the plan in a way that maximizes parallelism so multiple
devs can work on different parts. If possible include a DAG or
dependency tree at the end so I know exactly what order I can run
these. Prefix the To Do List at the bottom so I know exactly how
to distribute each task.
```

**Step 2: Review the Plan**
- Plan includes To Do List
- Shows task dependencies
- Identifies parallel vs sequential work

**Step 3: Execute**

**Option A: Linear Execution**
- Click **Build** at bottom of plan
- Agent works through To Do List top to bottom

**Option B: Parallel Execution**
1. Click icon next to any task in To Do List
2. Select "Build new agent"
3. Creates new tab with clean context
4. Task runs in parallel
5. Repeat for other independent tasks

**Important:**
- Only parallelize tasks that don't depend on each other
- Tasks touching same files will conflict
- Check dependency tree before parallelizing

---

### Sub-Agents

**What are Sub-Agents:**
- Independent agent instances
- Clean context window
- Only has access to the plan and assigned tasks
- No knowledge of parent conversation

**When to use:**
- Breaking down large features
- Parallel development
- Isolating context for specific tasks

**How to create:**
1. From To Do List in plan
2. Group related tasks
3. Click "Build new agent"
4. Agent works independently

---

## MCP Integrations

### What is MCP (Model Context Protocol)
- APIs that the agent can access
- Third-party integrations (Jira, Confluence, GitHub, etc.)
- Custom MCPs can be created

### Finding and Installing MCPs

**Step 1: Browse Available MCPs**
1. Go to **Cursor Docs** → **Model Context Protocol** → **Directory**
2. Browse available integrations
3. Note: Admins can whitelist/blacklist MCPs

**Step 2: Install an MCP**
1. Click **Add to Cursor** on desired MCP
2. Click **Install**
3. Authenticate (SSO or access token)
4. Grant necessary permissions

**Example: Atlassian MCP**
- Provides access to Jira and Confluence
- ~28 tools available
- Requires SSO authentication
- Check permissions for Jira, Confluence, Compass

### Creating Custom MCPs

**Components:**
1. **Configuration**: Tells agent how to connect
2. **Server**: API endpoint (you must host it)

**Add Custom MCP:**
1. Settings → MCPs
2. Click **New MCP Server**
3. Add configuration

**Third-party MCPs:**
- Third parties host the server
- You just add configuration

---

### Using MCPs

**In Chat:**
```
@atlassian What tickets do I have open?
```

The agent will:
1. Recognize the MCP
2. Call appropriate API
3. Return results

**Troubleshooting:**
If MCP doesn't work:
1. Go to terminal (toggle icon)
2. Select **Output** dropdown
3. Choose **Log**
4. Check for errors (often firewall/permissions issues)

---

## CLI Usage

### Why Use the CLI
- Use Cursor with ANY IDE (IntelliJ, PyCharm, etc.)
- Keep your preferred debugger/tools
- Access same features as Cursor IDE

### Installation

1. Go to **Cursor Docs** → **CLI** → **Overview**
2. Follow installation instructions
3. Invoke with `agent` command

### Using the CLI

**Start Agent:**
```bash
agent
```

**Available Commands:**
```bash
/model          # Select model
/mcp            # Access MCPs
/rules          # Create/manage rules
/plan           # Enter plan mode
```

**Features Available:**
- All agent capabilities
- Rules
- Skills
- Sub-agents
- Plan mode
- MCP integrations

**Workflow Example:**
1. Open your preferred IDE (IntelliJ, PyCharm)
2. Open terminal
3. Run `agent`
4. Work through tasks in terminal
5. See diffs in terminal
6. Use IDE for debugging, navigation, etc.

**Viewing Diffs:**
- Standard diff view in terminal
- Press `Ctrl+R` for full-screen view
- Press `Escape` to go back

---

## Best Practices

### Context Management

**Monitor Context Usage:**
- Check percentage indicator in chat (e.g., "34.1%")
- At 100%, conversation auto-summarizes (loses fidelity)

**Proactive Summarization:**
```
Summarize what you did and focus on any bugs or edge cases.
Save as markdown.
```

**Reducing Context:**
1. Save summary to file
2. Start new chat
3. Add only the summary
4. Result: Preserve information, reduce tokens

**Golden Rule:**
- One chat = One task
- New task = New chat
- Never have one chat doing multiple unrelated things

---

### Navigation and Shortcuts

**Code Navigation:**
1. Press `Cmd+Shift+P` (Mac) or `Ctrl+Shift+P` (Windows/Linux)
2. Search for "keyboard shortcuts"
3. Look for:
   - Go to Definition
   - Go to Type Definition
   - Go to Implementation

**Custom Shortcuts:**
- All VS Code shortcuts work
- Import IntelliJ shortcuts if needed
- Set your preferred navigation keys

**Language Server Protocol (LSP):**
- Install LSP extensions for your languages:
  - Java: Java LSP
  - C#: C# LSP
  - Python: Pylance
- Provides IntelliSense and code navigation

---

### Rules Best Practices

**What to Include:**
- Coding standards and style guides
- Testing procedures
- Package manager preferences (npm vs yarn)
- Architectural patterns
- Common error fixes

**What NOT to Include:**
- Obvious information
- Extremely verbose documentation
- Information not specific to your project

**Remember:**
- Rules use context tokens
- More rules = less space for agent reasoning
- Quality > Quantity

---

### Skill Creation Tips

**Good Skill Descriptions:**
- Clear, specific descriptions
- Helps agent decide when to invoke
- Include key trigger words

**Example:**
```markdown
---
name: "lint-and-fix"
description: "Run project linter and automatically fix code style issues"
---
```

**Skills vs Rules Decision Matrix:**
| Scenario | Use |
|----------|-----|
| Always needed | Rule |
| Context-dependent | Skill |
| Manual trigger only | Skill with `disableModelInvocation: true` |
| Specific file types | Rule with glob pattern |

---

## Advanced Tips

### Working with Plans

**Guide Agent Behavior:**
- To Do List IS the agent's instruction set
- Want agent to stop after step 1? Add "Stop" as step 2
- Want explicit testing? Add "Create unit test" and "Run unit test" steps
- Agent follows To Do List literally

**Customizing Plans:**
You can modify plans manually:
- Edit the markdown directly
- Add/remove steps
- Reorganize order
- Add specific instructions

---

### Creating Diagrams

**Mermaid Diagrams:**
Use Ask Mode for rendered diagrams:
```
Create a mermaid diagram showing how the backend and frontend interact
```

Agent Mode creates markdown file (must render separately)
Ask Mode renders directly in chat (faster for visualization)

---

### Web Research

**Enhanced Context:**
```
What database should I use for analytics workload
with 24GB RAM? Do some web research.
```

Agent will:
1. Search the web
2. Gather current information
3. Provide recommendations with sources

---

### Parallel Workflows

**Skill for Parallel Planning:**

Save this skill for consistent parallel plans:
```markdown
---
name: "parallel-guidance"
description: "Create plan optimized for parallel execution"
---

Structure the plan in a way that maximizes parallelism so
multiple developers can work on different parts simultaneously.

Include:
1. Clear task dependencies (DAG or dependency tree)
2. Grouping of parallel tasks (A, B, C groups)
3. Execution order with dependencies marked
4. Prefixed To Do List for easy distribution
```

**Execution Strategy:**
1. Identify independent task groups
2. Start all tasks in group A
3. Once A completes, start B tasks (if they depend on A)
4. Continue through dependency tree

---

### Debugging Strategies

**Agentic Debugging (New Way):**
Use Debug Mode - let AI add logs and identify issues

**Traditional Debugging (Old Way):**
1. Install debugger extension
2. Use built-in VS Code debugger
3. Or use CLI with IntelliJ debugger

**Keyboard Shortcuts:**
- Set breakpoints: Click line number gutter
- Configure: `Cmd+Shift+P` → "Debug"

---

### MCP Advanced Usage

**Custom MCP Creation:**
If you need integration not in directory:
1. Create API server
2. Host it (internal server or cloud)
3. Add configuration to Cursor
4. Agent can now access your custom API

**OAuth and Authentication:**
- Public MCPs: Use SSO
- Private instances: Use access tokens
- Configure in MCP settings

**Troubleshooting MCPs:**
Common issues:
- Firewall blocks
- Missing permissions
- Incorrect scope selection
- Check logs: Terminal → Output → Log

---

## Quick Reference Card

### Essential Commands
```
/create skill    - Create new skill
/create rule     - Create new rule
/migrate         - Convert commands to skills
/model           - Select AI model
/plan            - Enter plan mode
/mcp             - Manage MCPs
```

### Context Addition
```
@filename        - Add file to context
Drag & drop      - Add file to context
Right-click      - Add file to chat
```

### Keyboard Shortcuts to Set
```
Go to Definition
Go to Type Definition
Go to Implementation
```

### Important Locations
```
.cursor/rules/     - Project rules
.cursor/skills/    - Project skills
~/cursor/          - User settings
cursor.com/dashboard - Enterprise settings
```

### Support
```
Email: hi@cursor.com
Include:
- Version info (Cursor → About)
- Request ID (3 dots → Copy Request ID)
- Screenshot of issue
```

---

## Learning Path

### Week 1: Fundamentals
- [ ] Install Cursor 2.4.3+
- [ ] Enable models you want to use
- [ ] Try Agent Mode: simple code changes
- [ ] Try Ask Mode: ask questions about codebase
- [ ] Add files with @ symbol
- [ ] Create your first user rule

### Week 2: Configuration
- [ ] Create .cursor folder in project
- [ ] Write 2-3 project-specific rules
- [ ] Convert any commands to skills with /migrate
- [ ] Create one custom skill
- [ ] Practice glob patterns for conditional rules

### Week 3: Advanced Workflows
- [ ] Use Plan Mode for feature implementation
- [ ] Try parallel execution with sub-agents
- [ ] Install and use an MCP (Jira/Linear/GitHub)
- [ ] Practice context management and summarization
- [ ] Set up keyboard shortcuts for navigation

### Week 4: Mastery
- [ ] Create skill library for common workflows
- [ ] Set up CLI for alternate IDE if needed
- [ ] Establish team rules in source control
- [ ] Create parallel planning workflow
- [ ] Share best practices with team

---

## Troubleshooting

### "Agent not following my rules"
- Check if rule has `alwaysApply: true` or appropriate glob
- Verify file is in .cursor/rules/
- Check context percentage - might be summarized out
- Rule description should be clear and specific

### "MCP not connecting"
- Check logs: Terminal → Output → Log
- Verify authentication completed
- Check firewall settings
- Ensure correct permissions granted
- Try reinstalling MCP

### "Context window too high"
- Summarize conversation proactively
- Start new chat for new tasks
- Remove unnecessary files from context
- Review rules - might be too verbose

### "Can't find keyboard shortcut"
- Press `Cmd+Shift+P` → "Keyboard Shortcuts"
- Search for command (e.g., "Go to Definition")
- Set custom keybinding
- Import from previous IDE if available

### "Skills not being invoked"
- Check skill description - needs to match task
- Try invoking manually with /skillname
- Ensure skill doesn't have `disableModelInvocation: true`
- Verify skill name is clear and descriptive

---

## Resources

- **Documentation**: cursor.com/docs
- **Support**: hi@cursor.com
- **Skills Documentation**: cursor.com/docs/skills
- **MCP Directory**: cursor.com/docs/mcp/directory
- **CLI Guide**: cursor.com/docs/cli

---

## Changelog

**Version 2.4.3+ Features:**
- Skills (replacement for commands)
- Sub-agents
- Latest composer model
- Progressive disclosure for skills
- Enhanced plan mode
- Improved MCP integration

---

*This guide is based on the Cursor training session from February 11, 2026, delivered by Joel (Field Engineering), Dan, and Matthew (AI Deployment) from Cursor.*
