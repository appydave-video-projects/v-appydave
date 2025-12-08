# Tips for Paige

Consolidated prompt engineering insights from Scout's analysis of the YouTube Launch Optimizer workflow.

**Video**: b64-bmad-claude-sdk (BMAD Claude SDK Tutorial)
**Date**: December 2025
**Purpose**: These tips become Paige's knowledge base for building and improving prompts.

---

## Prompt Design Principles

### 1. Predicate Prompt Principle
**Source**: Section 4 Q&A

Complex prompts have more ways to fail. If cost wasn't a factor, do one prompt per metric.

- Simple prompts don't mess up
- Fewer decision paths = fewer failure modes
- Precise control over data shape (CSV, key-value, JSON)

**Anti-pattern**: Bundling 4 extractions into one prompt loses shape control.

---

### 2. Data Loss Anti-Pattern
**Source**: Section 2-2 (Refine Chapters)

When a refinement step processes data, it should **preserve or enhance context**, not drop it.

**Example**: V1 chapter refinement took "Title + Quote" and output "Title only" - losing the quote needed for timestamp matching.

**Principle**: Refinement adds value without losing upstream context.

---

### 3. Categorization Before Extraction
**Source**: Section 4 Q&A

Before asking for generic data (e.g., "keywords"), decide the purpose.

| Wrong | Right |
|-------|-------|
| "Extract keywords" | "Extract YouTube tags (long phrases, variations)" |
| "List statistics" | "List hook stats for thumbnails (impressive, simple numbers)" |

**Principle**: Platform/purpose determines output format.

---

### 4. Query Layer Positioning
**Source**: Section 4 Q&A

Extraction prompts only need transcript. Run them early so outputs are available for all downstream prompts.

**Current problem**: Section 4 (Content Analysis) runs after titles, but `mainTopic` captures concepts titles missed.

**Fix**: Move query/extraction prompts to run immediately after transcript processing.

---

### 5. First Match ≠ Right Match
**Source**: Section 2-3 (Create Chapters)

When matching text to timestamps, the first occurrence isn't always correct.

**Example**: "React application as the front end" appeared at 31:01 (describing the epic) AND at 1:45:00 (building the epic). First match was wrong context.

**Principle**: Need context-aware matching or chronological validation.

---

### 6. Reference Text Quality Determines Success
**Source**: Section 2-3 (Create Chapters)

Chapters with verbatim transcript quotes found timestamps. Chapters with summarized reference text failed.

**Principle**: If downstream steps need exact matching, upstream steps must preserve verbatim text, not paraphrase.

---

### 7. Anchor vs Authority
**Source**: Section 2-2 (Refine Chapters)

Inputs can be **anchors** (guide the AI) or **authorities** (dictate output).

| Anchors | Authorities |
|---------|-------------|
| Provide boundaries, hints, order | Dictate final output |
| AI still needs to do work | AI just formats |
| Example: Folder names | Example: Exact timestamps |

**Principle**: Clarify which type each input is in the prompt.

---

### 8. Platform-Specific Constraints
**Source**: Section 2-2 (Refine Chapters)

"SEO-friendly" is too generic. Each platform has specific constraints.

| Platform | Constraint |
|----------|-----------|
| YouTube chapters | 49-char hover cutoff |
| YouTube tags | Long phrases, variations |
| Twitter | Hashtags, 280 chars |

**Principle**: Encode platform-specific rules, not generic optimization goals.

---

### 9. Research Before Design
**Source**: Section 1-4 (Abridge)

V2 prompt was created by asking LLM to improve V1. This is iteration without research.

**Better approach**:
1. Identify problem domain ("transcript compression")
2. Research existing solutions (Claude Code compression, academic NLP)
3. Understand patterns from prior art
4. THEN design the prompt

**Principle**: Research before design, not just iterate.

---

## Prompt Types

When analyzing or creating prompts, identify the type:

| Type | Purpose | Data Shape | Example |
|------|---------|------------|---------|
| **Predicate** | Yes/no, exists/not | Boolean | "Does this video have a CTA?" |
| **Extraction** | Pull specific value | String, number | "What is the main topic?" |
| **List** | Extract multiple items | Array, CSV | "List all keywords" |
| **Categorization** | Group items by type | Keyed object | "Categorize statistics by intent" |
| **Observation** | Note patterns | Prose, notes | "Assess the tone" |
| **Transformation** | Convert format | Varies | "Convert chapters to YouTube format" |

---

## Human-in-the-Loop Patterns

| Pattern | Description | When to Apply |
|---------|-------------|---------------|
| **AI Extracts, Human Curates** | AI produces complete list, human removes/highlights | Any list for downstream use |
| **Auto-Categorize, Human Reviews** | AI assigns categories, human adjusts | Categorization prompts |
| **Suggest, Don't Dictate** | AI provides options, human chooses | Titles, thumbnails, creative |

---

## Missing Input Detection (Devil's Advocate)

When working on any prompt, ask:

> "What inputs would make this prompt work better?"

### Identified Missing Inputs

| Prompt | Missing Input | Where to Extract |
|--------|---------------|------------------|
| Title generation | `mainTopic` | Query layer (4-1) |
| Title generation | `audienceInsights` | Query layer (4-2) |
| Chapter timestamps | `anchorText` | Recording time (future) |
| Chapter refinement | Platform constraints | Research / constants |

---

## Redundancy Detection

Overlapping outputs that could be merged:

| Output A | Output B | Resolution |
|----------|----------|------------|
| `keywords` | `searchTerms` | Merge into categorized keywords |
| `keyTakeaways` | `uniqueSellingPoints` | Clarify distinction or merge |

---

## Data Shape Guidelines

| Use Case | Shape | Why |
|----------|-------|-----|
| YouTube tags | Comma-separated list | Direct paste into YouTube |
| Timestamps | `M:SS Title` per line | YouTube chapter format |
| Statistics for thumbnails | Short phrases | Quick scanning |
| Analytics over time | JSON with consistent keys | Cross-video comparison |

---

## Workflow Insights

### 1. Section 3 (Design Briefs) is Deprecated
Not used in current workflow. Skip entirely.

### 2. Query Layer Should Run Early
Move Section 4 prompts to run after transcript processing, before title generation.

### 3. Anchor Text Strategy (Future)
For timestamp matching, capture first sentence of each chapter at recording time. Match against final SRT from Gling.ai. Should achieve ~95% accuracy vs current 44%.

---

### 10. Parallel Prompt Execution
**Source**: Section 5-1 (Generate Title)

Instead of one prompt generating all variations, run multiple specialized prompts with different variable inputs.

**Example**: Title generation could run 10-12 prompts:
- Curiosity-only titles
- Desire-only titles
- Fear-only titles
- Number-hook focused
- Question format
- David's custom angles

**Principle**: Same task + different inputs = diverse, focused outputs.

---

### 11. Ranking as Distinct Step
**Source**: Section 5-1 (Generate Title)

Generation and selection are different tasks. Don't combine them.

| Step | Purpose | Output |
|------|---------|--------|
| Generation | Create many options | Candidate list |
| Ranking | Evaluate against criteria | Top N with rationale |

**Principle**: Separate prompts for generation vs. selection.

---

### 12. Cross-Asset Coordination
**Source**: Section 5-1 (Generate Title)

Title, thumbnail image, and thumbnail text work as a system. Optimize the system, not individual parts.

**Example**: If title uses "BMAD Method", thumbnail text can use "Claude Agent SDK" - keywords distributed across assets.

**Principle**: Delegate keyword responsibility across title + thumbnail + text.

---

### 13. Framework Library
**Source**: Section 5-1 (Generate Title)

Build a collection of frameworks (Jake Thomas, VidIQ, Brian Dean, etc.) and select per-run.

**Principle**: Multiple frameworks as selectable options, not hardcoded single approach.

---

### 14. A/B Testing Output Format
**Source**: Section 5-1 (Generate Title)

YouTube now supports A/B testing with multiple titles. Output format should support "Top 3 with rationale" not just "pick 1".

---

### 15. Human-in-the-Loop Curation
**Source**: Section 5-2 (Title Shortlist)

For creative/selection tasks, don't auto-select. Instead:
1. Generate structured candidates
2. Present with analysis
3. Ask clarifying questions (use AskUserQuestion tool in Claude Code)
4. Apply human input
5. Capture reasoning in output

**Trigger**: Any task with "select", "choose", "pick", "shortlist" in the goal.

**Anti-pattern**: AI making final creative decisions without human input.

**How to invoke**: Say "ask me questions before proceeding" or "use the question picker".

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

## Section 10-11: Transcript Segmentation Insights

### 18. User's Content Has Implicit Structure
**Source**: Section 10 Research

Before designing prompts, examine existing artifacts for implicit taxonomies:
- File naming conventions reveal mental models (`01-1-intro`, `09-1-outro-RECAP`)
- Folder structures show categorization thinking
- The user's implicit taxonomy is often better than an invented one

**How to invoke**: "What naming or organizational patterns do you already use for this content type?"

---

### 19. Distinguish Structure from Content Type
**Source**: Section 10 Research

Don't conflate these orthogonal dimensions:
- **Structure** = position/role in the whole (intro, chapter, tangent)
- **Content type** = what it IS (demo, explanation, code walkthrough)

**Anti-pattern**: A "demo chapter" - is it structural (a chapter) or content (a demo)? These need different prompts.

---

### 20. Signal Phrases Reveal Structure
**Source**: Section 10 Research

Most content creators have unconscious verbal patterns that signal transitions:
- "I'm AppyDave, let's get into it" = intro ending
- "So there we have it" = outro beginning

**Principle**: Document signal phrases. They're more reliable than meaning detection.

---

### 21. Extract vs Analyze is Two-Phase Design
**Source**: Section 11 Design

- Phase 1: Extract (what exists) - minimal interpretation
- Phase 2: Analyze (what it means) - classification, evaluation

**Benefits**:
- Extraction can be validated independently
- Analysis can evolve without re-extracting
- Easier to debug which phase has issues

---

### 22. Classification Vocabularies Should Be Explicit
**Source**: Section 11 Design

Define the vocabulary in the prompt:
- `hookType`: imagination | story | direct | excitement
- `ctaType`: subscribe | community | video | repository

**Anti-pattern**: Open-ended classification ("describe the type") produces inconsistent outputs.

---

### 23. Quality Scales Should Be Actionable
**Source**: Section 11 Design

Use 3-point scales where each level suggests different actions:
- **high/strong**: Keep as-is
- **medium/moderate**: Consider improvements
- **low/weak**: Needs rework

**Anti-pattern**: 5-point or 10-point scales where middle values are ambiguous.

---

### 24. Analysis Should Surface Actionable Insights
**Source**: Section 11 Design

Good analysis answers: "So what? What do I do with this?"

**Example**: Breakout analysis includes `potentialFormats` and `keyLesson` - not just classification but guidance.

---

### 25. Validation Through Q&A
**Source**: Section 10-11 Q&A Session

After running prompts, create Q&A documents with:
1. The extracted text
2. The analysis values
3. Reasoning/opinion
4. Question for user

**Purpose**: Validates both extraction AND analysis prompts.

---

### 26. "Standard" Ratings Are Improvement Opportunities
**Source**: Section 10-11 Q&A Session

When analysis returns "standard", "moderate", or "typical":

> "The sign-off was rated 'standard'. Would you like suggestions for more memorable alternatives?"

**Principle**: Don't just report - offer to improve.

---

### 27. Predicate vs Extract Pattern
**Source**: Section 10-11 Q&A Session

Some checks work better as boolean predicates than extraction items:
- "Does video have monetizable CTA?" (yes/no predicate)
- vs. extracting all CTAs and analyzing each

**When to use predicates**: Simple presence checks, binary decisions, precondition validation.

---

## Paige Capabilities (Confirmed)

Based on Scout's analysis, Paige needs these capabilities:

- [ ] Identify prompt type (predicate, extraction, list, etc.)
- [ ] Detect data loss in refinement chains
- [ ] Suggest missing inputs (devil's advocate)
- [ ] Research before designing new prompts
- [ ] Encode platform-specific constraints
- [ ] Distinguish anchors from authorities
- [ ] Recommend prompt splitting when too complex
- [ ] Identify redundant outputs for merging
- [ ] Suggest appropriate data shapes
- [ ] Offer improvement suggestions for "standard" ratings
- [ ] Distinguish structure from content type
- [ ] Validate prompts through Q&A sessions
- [ ] Know when to use predicates vs extraction

---

## How This Document Grows

Each video run through the workflow should:

1. **Add new tips** discovered during analysis
2. **Validate existing tips** - mark as confirmed across multiple videos
3. **Identify patterns** that appear repeatedly
4. **Surface new missing inputs** for the devil's advocate list
5. **Refine prompt type classifications** as we see more examples

This is POEM in action: the system improves itself through use.
