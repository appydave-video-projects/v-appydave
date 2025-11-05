# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with this video project.

---

## Project Overview

**b64-bmad-claude-sdk**: A video project (AppyDave brand) documenting the development of a **self-editing web application** that demonstrates the integration of Claude Agent SDK with BMAD Method v6.

**Video Focus**: Building an application that modifies itself through conversational AI, showcasing how to combine agentic AI capabilities with structured development methodology.

**Related Code Project**: `/Users/davidcruwys/dev/ad/appydave-app-a-day/007-bmad-claude-sdk/`

**Content Pillar**: BMAD Method (Critical Priority)

---

## Video Project Purpose

This project is a **FliVideo workflow** video that demonstrates:

1. How Claude Agent SDK enables applications to modify themselves through tools
2. How BMAD Method v6 provides structure and quality gates for development
3. Progressive enhancement of self-editing capabilities
4. Integration of AI agents with traditional web development patterns

**Target Length**: ~36 minutes

**Video Narrative Arc**:
1. Introduction: BMAD + Claude SDK = self-editing application
2. Phase 1: Use BMAD to plan the self-editing application
3. Phase 2: Code the 200-line core (server + tools + client)
4. Phase 3: Context switch to browser - use the application
5. Demo: Application adds features to itself
6. Progressive BMAD: Manual update → auto-update → self-validation
7. Conclusion: Recursive BMAD demonstration

---

## Key Concepts

### Self-Editing Application (Core Concept)

**What We're Building**: An application that starts minimal and evolves itself through conversation, NOT a "framework that builds apps".

**Pattern**:
- User: "Create a product listing"
- Agent: Uses tools to create data/products.json and public/products.html
- User: "Add a blog section"
- Agent: Adds data/blog.json and updates navigation

**Key Insight**: Everything beyond the 200-line core happens via conversational interface using custom tools.

### Claude Agent SDK (Technical Foundation)

**What It Is**: Anthropic's production-oriented toolkit for building agents with:
- Context management
- Custom tools for file/data operations
- Hookable control points for safety/validation
- SSE streaming for real-time responses

**Based On**: The same "agent harness" that powers Claude Code (IDE integration, git workflows, terminal interaction)

**Key Features**:
- Authentication via CLI OAuth (no API credits consumed)
- Tool safety through sandboxing
- Before/after hooks for quality gates
- Type-safe TypeScript support

**SDK Location**: `/Users/davidcruwys/dev/js_3rd/anthropic-sdk-typescript`

### BMAD Method v6 (Methodology)

**What It Is**: A human-AI collaboration framework with four modules:
- **CORE**: Foundational orchestration engine
- **BMM** (BMAD Method): Software development lifecycle management
- **CIS**: Creative Intelligence Suite for innovation
- **BMB**: Builder for custom agents and workflows

**Key Workflow**: Analysis → Planning → Solutioning → Implementation

**In This Project**: Used as quality gates and guardrails:
- Active story requirement before code changes
- PRD-driven development (self-documenting)
- Progressive enhancement (manual → automatic → self-validating)

**v6 Changes from v4**:
- Module structure under `bmad/` folder
- Four-phase workflow (explicit)
- JIT tech specs (just-in-time during implementation)
- Install: `npm run install:bmad`

---

## Architecture Overview

### Three-Layer System

```
Frontend (Static HTML)
  ↓ HTTP POST /chat
Backend (Express + Claude Agent SDK)
  ↓ File I/O via custom tools
Data Layer (/data/*.json, /public/*.html)
```

### Core Components

**Backend (`server.ts`, ~200 LOC)**:
- Express server with single `/chat` endpoint
- Claude Agent SDK integration
- Three custom tools for file operations
- BMAD quality gate hooks
- SSE streaming for real-time responses

**Three Custom Tools**:
1. `read_json(filepath)` - Read any JSON from `/data`
2. `write_json(filepath, content)` - Create or update JSON in `/data`
3. `write_file(filepath, content)` - Create or update HTML/CSS/JS in `/public`

**Tool Sandboxing**:
```typescript
const safe = (p) => {
  const full = path.resolve(p);
  if (!full.startsWith(PUB) && !full.startsWith(DATA_DIR)) {
    throw new Error('Blocked: only /public and /data writable');
  }
  return full;
};
```

**Frontend (`public/index.html`)**:
- Single page with Tailwind-styled text box
- Conversational interface to the agent
- Dynamically populated navigation
- Empty until agent populates it

**Quality Gate Hook (BMAD)**:
```typescript
const hooks = {
  async beforeToolCall(ctx) {
    if (ctx.toolName === 'write_file') {
      const active = 'bmad/bmm/stories/ACTIVE_STORY.md';
      try {
        await fs.access(active);
      } catch {
        throw new Error('No ACTIVE_STORY - set story first');
      }
    }
  }
};
```

This enforces story-driven development even during conversational building.

---

## Project Structure (Code Project)

**Location**: `/Users/davidcruwys/dev/ad/appydave-app-a-day/007-bmad-claude-sdk/`

```
007-bmad-claude-sdk/
├── .archive/              # Research notes and exploration
├── CLAUDE.md              # Project documentation (this type)
├── cleanup.md             # Complete project specification
├── outline-comparison.md  # Document structure analysis
├── server.ts              # Express + Agent SDK (to be created)
├── package.json           # Dependencies (to be created)
├── tsconfig.json          # TypeScript config (to be created)
├── public/
│   └── index.html         # Chat interface (to be created)
├── data/                  # Agent-created JSON files
└── bmad/
    └── bmm/
        ├── docs/          # PRD, architecture
        └── stories/       # Story files + ACTIVE_STORY.md
```

---

## Development Workflow (Video Demonstration)

### Phase 1: Planning with BMAD (4 min)
- Use BMAD Analyst agent to create PRD
- Generate architecture documentation
- Create initial story files in `bmad/bmm/stories/`
- Use Claude Code for planning in VSCode

### Phase 2: Build Framework (12 min)
- Set active story before coding
- Install dependencies: `npm install express @anthropic-ai/claude-agent-sdk`
- Code the 200-line backend with three tools
- Authenticate: `claude auth login`
- Create frontend chat interface with Tailwind
- Run: `npm run dev` or `tsx watch server.ts`
- Server runs on http://localhost:3000

### Phase 3: Use the Application (12 min) - The Pivot
**Context Switch**: Leave VSCode entirely. Everything now happens in browser.

**Example Conversation Flow**:
```
User → "Create a products system with 5 items"
Agent → Reads PRD, creates data/products.json

User → "Generate a beautiful product listing page"
Agent → Creates public/products.html with Tailwind styling

User → "Add a blog with featured posts"
Agent → Creates data/blog.json and public/blog.html

User → "Update the PRD to reflect these new features"
Agent → Updates docs/prd.md automatically
```

### Phase 4: Progressive BMAD Enhancement (3 min)
1. **Manual Updates**: User asks agent to update PRD
2. **Automatic Updates**: System prompt enables auto-PRD-updates
3. **Self-Validation**: Agent validates its own code quality
4. **Self-Documentation**: Agent creates its own story files
5. **Recursive BMAD**: BMAD building a self-editing application that enforces BMAD

---

## Technology Stack

### Backend
- **Language**: TypeScript/Node.js
- **Framework**: Express.js
- **AI**: Claude Agent SDK (`@anthropic-ai/claude-agent-sdk`)
- **Authentication**: Claude CLI OAuth (no API key needed)
- **Runtime**: tsx or ts-node for development

### Frontend
- **HTML**: Single-page application (index.html)
- **CSS**: Tailwind CDN (no build required)
- **JavaScript**: Fetch API for HTTP POST to `/chat`
- **Streaming**: Server-Sent Events (SSE) for real-time responses

### BMAD Integration
- **Version**: v6
- **Structure**: `bmad/bmm/docs/` and `bmad/bmm/stories/`
- **Quality Gates**: Active story requirement
- **Automation**: Hooks in Agent SDK before/after tool calls

### Why JavaScript over Python?
1. **Browser-first**: Works seamlessly with web frontend
2. **SDK maturity**: Claude Agent SDK is newer in TypeScript
3. **Deployment**: Easy containerization and cloud hosting
4. **Developer experience**: Same language for full-stack (optional)

---

## Key Technical Patterns

### Authentication (No API Credits)
```bash
claude auth login  # One-time setup
```
Uses Claude CLI OAuth. SDK automatically uses this session.

### Tool Safety (Sandboxing)
Tools can only write to `/public` and `/data` directories. Prevents accidental file corruption or security issues.

### BMAD Quality Gates
Before tool calls (especially writes), verify that `bmad/bmm/stories/ACTIVE_STORY.md` exists. This enforces story-driven development during conversational building.

### System Prompt Strategy
The agent's system prompt:
- Explains self-editing capabilities
- Lists available tools
- Enforces directory constraints
- Encourages PRD updates
- Emphasizes building ONE evolving application

Can be updated at runtime to enable new features (e.g., automatic PRD generation, code quality validation).

---

## Success Criteria

### Code Quality
- Backend under 200 lines
- Generic tools (no domain knowledge)
- Type-safe TypeScript
- Clean separation of concerns

### BMAD Alignment
- PRD defines self-editing application (not specific features)
- Stories guide framework development
- Active story enforced by hooks
- Application updates its own PRD
- Code quality validation using Claude Code agent

### Demo Value
- Shows self-editing application in action
- Demonstrates progressive BMAD enhancement
- Application validates and documents itself
- Works for any domain (products, blog, etc.)
- BMAD discipline maintained recursively

---

## Related Projects & References

### Code Project
- **Location**: `/Users/davidcruwys/dev/ad/appydave-app-a-day/007-bmad-claude-sdk/`
- **Status**: Planning & specification phase
- **Key Files**:
  - `CLAUDE.md` - Detailed technical documentation
  - `cleanup.md` - Complete project specification
  - `.archive/` - Research notes

### BMAD Method
- **Content Pillar**: `/Users/davidcruwys/dev/ad/content-pillars/01-bmad-method.md`
- **Repository**: https://github.com/bmad-code-org/BMAD-METHOD (v6-alpha)
- **Documentation**: Stored in `/Users/davidcruwys/dev/ad/appydave.com/.bmad-core`

### Claude Agent SDK
- **Third-party Source**: `/Users/davidcruwys/dev/js_3rd/anthropic-sdk-typescript`
- **Official Docs**: anthropic.mintlify.app
- **GitHub**: Anthropic's official SDK repository
- **Used In**: Claude Code (IDE integration reference)

### Related Video Projects
- **b61-kdd-bmad**: BMAD overview video
- **b62-remotion-overview**: Remotion framework (previous project)
- **b63-remotion-tutorial**: Remotion advanced patterns (previous project)

---

## Recording & Assets

### Directory Structure
```
b64-bmad-claude-sdk/
├── recordings/          # Individual chapter recordings (gitignored)
│   ├── 01-1-*.mov       # Chapter 1: Introduction
│   ├── 02-1-*.mov       # Chapter 2: Phase 1 Planning
│   ├── 03-1-*.mov       # Chapter 3: Phase 2 Building
│   ├── 04-1-*.mov       # Chapter 4: Phase 3 Using
│   ├── 05-1-*.mov       # Chapter 5: Phase 4 BMAD
│   └── 06-1-*.mov       # Chapter 6: Conclusion
├── assets/              # Design documents, references
│   └── [design files]
└── b64-bmad-claude-sdk.srt  # Transcript (tracked)
```

### Recording Tips
- Screen recording: Code demos and development phases
- Terminal: Node.js startup, Tailwind compilation (if needed)
- Browser: Agent responses, self-editing in action
- Editor: PRD and story files being created/updated

---

## Future Vision (Not in v1)

### Self-Healing Applications
When an exception occurs in production:
1. Application captures error context and stack trace
2. Sends to backend Claude agent
3. Agent analyzes and fixes the bug
4. User approves fix or creates bug report
5. Application heals itself automatically

This opens possibilities for applications that debug and improve themselves over time.

### Front-End to BMAD Integration (Version 2)
Current: User conversation → Claude SDK → Direct code changes

Advanced: User conversation → Claude SDK → Creates BMAD story/epic → BMAD agents execute → Code changes

Could include:
- **Kanban Dashboard**: Show stories, epics, status
- **Story Detail View**: Acceptance criteria, architecture, status
- **Progress Tracking**: BMAD artifact generation in real-time

---

## Important Reminders

1. **Self-Editing, Not Domain-Specific**: This is about teaching how applications modify themselves, not about building product catalogs
2. **200-Line Core**: The entire framework should fit in ~200 lines of TypeScript
3. **Conversational Interface**: Everything after coding happens in the browser text box
4. **BMAD Throughout**: Method is demonstrated suggestively, not prescriptively
5. **Progressive Enhancement**: Start simple (manual PRD updates) → become automatic → self-validating
6. **Authentication**: Uses CLI OAuth (free, no API credits consumed)
7. **Recursive Demonstration**: BMAD builds a self-editing app that enforces BMAD

---

## Quick Links

- **Code Project**: `/Users/davidcruwys/dev/ad/appydave-app-a-day/007-bmad-claude-sdk/`
- **Video Metadata**: `/Users/davidcruwys/dev/video-projects/v-appydave/b64-bmad-claude-sdk/`
- **BMAD Docs**: `/Users/davidcruwys/dev/ad/appydave.com/.bmad-core`
- **SDK Reference**: `/Users/davidcruwys/dev/js_3rd/anthropic-sdk-typescript`
- **Content Pillar**: `/Users/davidcruwys/dev/ad/content-pillars/01-bmad-method.md`

---

**Video Project**: b64-bmad-claude-sdk (AppyDave Brand)
**Created**: 2025-10-27
**Status**: Planning Phase
**Workflow**: FliVideo (Sequential chapter-based recording)
**Target Duration**: ~36 minutes
**Priority**: High (BMAD Method Content Pillar)
