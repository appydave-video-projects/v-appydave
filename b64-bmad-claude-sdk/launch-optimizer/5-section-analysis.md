# Section 5: Titles & Thumbnails - Combined Analysis

## Overview

Section 5 evolved significantly during execution. What started as a linear title → thumbnail flow became a three-step coordinated system with human curation at its center.

### Final Workflow

| Step | Prompt | Purpose |
|------|--------|---------|
| 5-1 | generate-title (v1/v2) | Generate 10+ title candidates with hook types |
| 5-2 | select-title-shortlist | Human-in-the-loop curation → 2-4 titles for A/B |
| 5-3 | generate-thumbnail-text | Coordinated thumbnail text per shortlisted title |

### What Changed

- **5-2 + 5-3 merged** → became just 5-3 (thumbnail text)
- **New 5-2 created** → title shortlist selection (didn't exist before)
- **5-4, 5-5 skipped** → visual/Leonardo prompts are a separate project

---

## 5-1: Title Generation

### V1 vs V2 Comparison

| Aspect | V1 | V2 |
|--------|----|----|
| Framework | Generic guidance | Jake Thomas "Three Emotions" |
| Char targets | "Under 70" | 40-50 optimal, 50 mobile-safe |
| Output structure | Array of strings | Objects with category, emotion, chars |
| Inputs | 3 basic fields | 6 fields via dot notation |

### Key Improvements in V2

1. **Research-informed**: Looked up YouTube title psychology before designing
2. **Hook type categorization**: bmad+sdk, bmad-only, sdk-only, concept, number-hook
3. **Variety by design**: Prompt asks for distribution across hook types
4. **Structured output**: Enables downstream coordination

### The "Hook Type" Concept

This was a breakthrough. Instead of generating 10 similar titles, categorize by strategy:

| Hook Type | Title Focus | Thumbnail Fills Gap With |
|-----------|-------------|--------------------------|
| bmad+sdk | Both keywords | Emotional payoff |
| bmad-only | BMAD | Agent SDK / Claude |
| sdk-only | Agent SDK | BMAD methodology |
| concept | Neither (self-editing, vibe coding) | Keywords or amplifier |
| number-hook | Statistics | Keywords or outcome |

This creates **implicit thumbnail guidance** from the title choice.

### Learnings

- "Agent SDK" is fine without "Claude" prefix (Claude goes on thumbnail)
- "BMAD Method" can drop "Method" to save characters
- Variety requires explicit prompting - otherwise AI converges on similar patterns

---

## 5-2: Title Shortlist Selection

### Why This Step Was Added

Original workflow jumped from generation → thumbnail text with no selection. But:
- 10 candidates is too many
- A/B testing needs 2-4 titles
- Human curation adds "slight touch" that improves quality
- Different titles need different thumbnail strategies

### Human-in-the-Loop Curation Pattern

**This was a major discovery.** Instead of AI auto-selecting, use Claude Code's `AskUserQuestion` tool to:

1. Present candidates with analysis
2. Ask clarifying questions (keyword priority, preferences)
3. Get specific selections and tweaks
4. Apply human input to create final shortlist

**The pattern works because:**
- AI can analyze and present options systematically
- Human brings gut feel, brand knowledge, specific angles
- Combined output is better than either alone
- Captured preferences (`davidInput`) document the reasoning

### Prompt Design

The 5-2 prompt is structured as a **facilitation guide**, not an automation:

```
Step 1: Present Analysis
Step 2: Ask David (5 specific questions)
Step 3: Create Shortlist (based on input)
```

### Output Structure

```json
{
  "shortlist": [{ "title", "hookType", "chars", "rationale", "gapFilled" }],
  "davidInput": { "keywordPriority", "hookPreference", "customTweaks" }
}
```

The `davidInput` field is important - it captures WHY these titles were selected, not just WHAT.

---

## 5-3: Thumbnail Text Generation

### Research Findings Applied

| Finding | Source | Application |
|---------|--------|-------------|
| 1-4 words ideal | CustomThumbnails.com | All outputs ≤12 chars |
| Complementary, not reinforcing | VideoTap | Hook type coordination |
| ≤20 characters | Multiple sources | Strict constraint |
| Emotional hooks | Research | "It Works!", "Wait...", "Really?" |

### The Coordination Rule

Thumbnail text fills whatever gap the title leaves:

| If Title Has | Thumbnail Adds |
|--------------|----------------|
| Both keywords | Emotional payoff |
| BMAD only | Agent SDK / Claude |
| SDK only | BMAD / methodology |
| Concept hook | Missing keywords |
| Number hook | Keywords or emotion |

### Output Per Title

Each shortlisted title gets 3 thumbnail text options with:
- The text itself
- Part 1/2 split (for multi-line display)
- Character count
- What gap it fills (complements field)

---

## Key Discoveries

### 1. Human-in-the-Loop Curation

**Pattern name**: Human-in-the-Loop Curation

**When to use**: Any creative/selection task where AI generates options but human taste matters.

**How it works**:
1. AI generates candidates with structured metadata
2. AI presents analysis and asks clarifying questions via `AskUserQuestion`
3. Human selects favorites and provides tweaks
4. AI applies input to create curated output
5. Human input is captured for future reference

**Why it matters for POEM**: This pattern could apply to many prompt types - title selection, image choice, tone selection, etc. The AI doesn't replace human judgment; it **facilitates** it.

### 2. Hook Type as Coordination Mechanism

The `category`/`hookType` field created unexpected value:
- Enabled variety in generation
- Implied thumbnail strategy
- Made selection more systematic
- Could extend to image concepts

### 3. Research Before Design (Validated Again)

V2 prompts consistently outperformed V1 because we researched:
- YouTube title psychology (Jake Thomas framework)
- Thumbnail text best practices (word count, relationship to title)
- Character limits (40-50 optimal, not just "under 70")

### 4. Complementary vs Reinforcing

Critical insight: **Thumbnail text should NOT repeat the title.**

| Wrong | Right |
|-------|-------|
| Title: "7 Agents Build..." / Thumb: "7 Agents" | Title: "7 Agents Build..." / Thumb: "Agent SDK" |

They work together to tell a complete story, each adding what the other lacks.

---

## Tips for Paige (New)

### 15. Human-in-the-Loop Curation
**Source**: Section 5-2 (Title Shortlist)

For creative/selection tasks, don't auto-select. Instead:
1. Generate structured candidates
2. Present with analysis
3. Ask clarifying questions (use AskUserQuestion)
4. Apply human input
5. Capture reasoning in output

**Trigger**: Any task with "select", "choose", "pick", "shortlist" in the goal.

**Anti-pattern**: AI making final creative decisions without human input.

---

### 16. Coordination Fields Enable Downstream Intelligence
**Source**: Section 5-1/5-3 (Hook Types)

Adding metadata like `hookType` or `category` to generated content enables:
- Variety in generation
- Implicit guidance for next steps
- Systematic selection criteria
- Cross-asset coordination (title ↔ thumbnail)

**Principle**: Structured output isn't just for storage - it's for coordination.

---

### 17. Complementary Not Reinforcing
**Source**: Section 5-3 (Thumbnail Text Research)

When two assets work together (title + thumbnail, heading + subheading):
- Each should add what the other lacks
- Never repeat the same words
- Together they tell a complete story

**Test**: If you removed one, would you lose information? If yes, they're complementary. If no, they're redundant.

---

## Prompt Files

| File | Status | Purpose |
|------|--------|---------|
| 5-1-generate-title-v1.hbs | Active | Basic title generation |
| 5-1-generate-title-v2.hbs | Active | Research-informed, hook types |
| 5-2-select-title-shortlist.hbs | Active | Human-in-the-loop curation |
| 5-3-generate-thumbnail-text.hbs | Active | Coordinated thumbnail text |
| 5-2-generate-thumbnail-text.hbs | Deleted | Merged into 5-3 |
| 5-3-generate-thumbnail-text-csv.hbs | Deleted | Was reformatting step |
| 5-4-thumbnail-visual-elements.hbs | Skipped | Future project |
| 5-5-thumbnail.hbs | Skipped | Future project |

---

## Workflow Data Fields

| Field | Source | Purpose |
|-------|--------|---------|
| generate_title_v1 | 5-1 | 10 basic titles |
| generate_title_v2 | 5-1 | 10 titles with hook types |
| title_shortlist | 5-2 | 3 curated titles with rationale |
| davidInput | 5-2 | Captured curation preferences |
| thumbnail_text_for_shortlist | 5-3 | 3 options per shortlisted title |
| generate_thumbnail_text_archive | - | Earlier generation (archived) |

---

## Future Improvements

1. **Parallel hook type generation**: Run separate prompts for each hook type (curiosity-only, desire-only, etc.)
2. **Ranking agent**: After parallel generation, consolidate and rank
3. **Title-Thumbnail-Image coordination**: Full system where all three assets are generated together
4. **A/B testing integration**: Output format specifically for YouTube's multi-title feature
5. **Framework library**: Multiple title frameworks selectable per-run (Jake Thomas, VidIQ, etc.)

---

## Session Notes

This section was executed in a single extended session with significant iteration:
- Started with existing 5-2/5-3 prompts
- Discovered missing selection step
- Restructured workflow mid-execution
- Applied Human-in-the-Loop Curation pattern
- Research conducted live (thumbnail text best practices)

The AskUserQuestion tool proved particularly valuable for:
- Clarifying requirements before prompt design
- Gathering selection criteria
- Getting specific tweaks and preferences
- Making the interaction feel collaborative rather than automated
