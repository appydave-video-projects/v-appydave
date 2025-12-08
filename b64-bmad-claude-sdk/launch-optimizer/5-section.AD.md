# Section 5: Titles & Thumbnails - Video Notes

## What Happened

Section 5 was restructured during execution. Original prompts assumed linear flow; we discovered a missing selection step and added human curation.

### Final Workflow
1. **5-1**: Generate title candidates (V1/V2)
2. **5-2**: Human-in-the-loop title shortlist (NEW)
3. **5-3**: Thumbnail text for shortlisted titles

### Skipped
- 5-4 (visual elements) and 5-5 (Leonardo AI) - separate project

---

## Key Discoveries

### 1. Human-in-the-Loop Curation Pattern

Used Claude Code's `AskUserQuestion` tool for title selection instead of auto-selecting.

**How it works:**
- AI presents candidates with analysis
- AI asks clarifying questions
- Human selects favorites, provides tweaks
- AI applies input, captures reasoning

**Why it matters:** Best titles have a "slight human touch" - AI facilitates, doesn't replace.

**How to invoke:** Say "ask me questions before proceeding" or "use the question picker"

### 2. Hook Type Coordination

Added `hookType` field to titles: bmad+sdk, bmad-only, sdk-only, concept, number-hook.

This enabled:
- Variety in generation (not 10 similar titles)
- Implicit thumbnail guidance
- Systematic selection

### 3. Complementary Not Reinforcing

Research finding: Thumbnail text should NOT repeat the title.

| Wrong | Right |
|-------|-------|
| Title: "7 Agents" / Thumb: "7 Agents" | Title: "7 Agents" / Thumb: "Agent SDK" |

Together they tell a complete story.

### 4. "Method" Can Be Dropped

BMAD is known enough that "BMAD Method" can become just "BMAD" to save characters.

---

## Research Applied

### Title Generation (5-1)
- Jake Thomas "Three Emotions" framework (Curiosity, Desire, Fear)
- 40-50 chars optimal for CTR
- 70 chars max for SEO
- Front-load keywords (mobile truncation)

### Thumbnail Text (5-3)
- 1-4 words ideal, max 6
- ≤20 characters
- Complementary to title, not reinforcing
- Sans-serif fonts, 75pt+

---

## Final Outputs

### Title Shortlist (A/B Ready)

1. **BMAD + Agent SDK: Self-Editing Apps Made** (40 chars)
   - Hook: bmad+sdk
   - Thumbnail: "Live" / "Watch It Build" / "No Code"

2. **BMAD: 7 Agents Build Your Entire App** (36 chars)
   - Hook: bmad-only
   - Thumbnail: "Agent SDK" / "Claude" / "Self-Editing"

3. **I Built an App That Edits Itself Live | BMAD + SDK** (50 chars)
   - Hook: concept
   - Thumbnail: "Just Talk" / "It Generates" / "Zero Code"

---

## New Tips for Paige

1. **#15 Human-in-the-Loop Curation**: For creative tasks, ask questions instead of auto-selecting
2. **#16 Coordination Fields**: Add metadata (hookType) for downstream intelligence
3. **#17 Complementary Not Reinforcing**: Two assets should add what the other lacks

---

## Files Changed

### Created
- `5-2-select-title-shortlist.hbs` - New curation prompt
- `5-3-generate-thumbnail-text.hbs` - Renamed from 5-2-v2

### Deleted
- `5-2-generate-thumbnail-text-v1.hbs` - Merged
- `5-3-generate-thumbnail-text-csv.hbs` - Was just reformatting

### Skipped
- `5-4-thumbnail-visual-elements.hbs`
- `5-5-thumbnail.hbs`

---

## Quotable Moments

> "The best title often has a slight human touch. Your job is to facilitate that curation, not replace it."

> "Ask me questions before proceeding" - how to invoke Human-in-the-Loop Curation

> "Complementary not reinforcing" - the thumbnail text rule
