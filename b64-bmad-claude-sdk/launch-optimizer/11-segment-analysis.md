# Section 11: Transcript Segment Analysis

## Purpose

Analyze extracted segments from Section 10 to classify, evaluate, and identify repurposing opportunities.

## Relationship to Section 10

Section 10 **extracts** segments from raw transcript.
Section 11 **analyzes** those extractions for quality, classification, and actionable insights.

```
Transcript → [Section 10: Extract] → Raw Segments → [Section 11: Analyze] → Classified Data
```

## Prompts in This Section

| File | Purpose | Input | Output Field |
|------|---------|-------|--------------|
| 11-1-analyze-intro.hbs | Classify intro segments | `videoIntroExtract` | `videoIntroAnalysis` |
| 11-2-analyze-outro.hbs | Classify outro segments | `videoOutroExtract` | `videoOutroAnalysis` |
| 11-3-analyze-cta.hbs | Classify CTAs | `videoCtaExtract` | `videoCtaAnalysis` |
| 11-4-analyze-breakout.hbs | Evaluate breakout potential | `videoBreakoutExtract` | `videoBreakoutAnalysis` |

---

## Analysis Output Summary (b64)

### Intro Analysis (5 items)

| Type | Key Finding | Quality |
|------|-------------|---------|
| hook | Imagination hook ("Imagine building...") | strong |
| promise | Clear, specific (Agent SDK + BMAD method) | clear/specific |
| signOff | Brand-consistent ("I'm AppyDave, let's get into it") | consistent |
| chapterMention | Appropriate for 2-hour video | appropriate |
| demoPreview | High intrigue, shows-don't-tell | high |

### Outro Analysis (3 items)

| Type | Key Finding | Quality |
|------|-------------|---------|
| recap | Comprehensive, reinforces intro promise | comprehensive |
| teaser | High curiosity (POEM acronym reveal) | high |
| signOff | Brand-consistent, standard effectiveness | standard |

### CTA Analysis (5 items)

| Position | Type | Directness | Notes |
|----------|------|------------|-------|
| intro | description | soft | Chapter links (borderline CTA) |
| early | community | soft | Skool community |
| middle | video | soft | VOZ cross-promotion |
| middle | repository | soft | GitHub repo |
| outro | repository | direct | Repo + community combined |

**Pattern**: All soft except outro (direct). Intentional style.

### Breakout Analysis (3 items)

| Type | Standalone Value | Potential Formats |
|------|------------------|-------------------|
| problem-solving | medium | short, snippet |
| creation | high | video, short, blog |
| retrospective | high | video, short, blog, tweet |

**Gap identified**: Demo preview (in intro) not captured as breakout.

---

## Tips for Paige (Domain-Agnostic Learnings)

### 15. Extract vs Analyze is Two-Phase Design

**What we did:** Section 10 extracts raw segments. Section 11 analyzes them separately.

**The transferable principle:**
- Phase 1: Extract (what exists) - minimal interpretation
- Phase 2: Analyze (what it means) - classification, evaluation

**Benefits:**
- Extraction can be validated independently
- Analysis can evolve without re-extracting
- Different analysis prompts can run on same extraction
- Easier to debug which phase has issues

**How to invoke:** "Should we extract first, then analyze? Or is this simple enough for one prompt?"

---

### 16. Classification Vocabularies Should Be Explicit

**What we did:** Each analysis prompt defines explicit taxonomies:
- `hookType`: imagination | story | direct | excitement
- `ctaType`: subscribe | like | community | video | repository | product
- `breakoutType`: demo | problem-solving | creation | research | retrospective

**The transferable principle:**
- Define the vocabulary in the prompt
- Constrain outputs to known categories
- Makes downstream processing predictable
- Easier for users to understand and validate

**Anti-pattern:** Open-ended classification ("describe the type of hook") produces inconsistent outputs.

---

### 17. Quality Scales Should Be Actionable

**What we did:** Used scales like:
- `strength`: strong | moderate | weak
- `standaloneValue`: high | medium | low
- `directness`: direct | soft | implied

**The transferable principle:**
- 3-point scales are usually sufficient
- Each level should suggest different actions:
  - **high/strong**: Keep as-is, feature prominently
  - **medium/moderate**: Consider improvements
  - **low/weak**: Needs rework or removal

**Anti-pattern:** 5-point or 10-point scales where middle values are ambiguous.

---

### 18. Analysis Should Surface Actionable Insights

**What we did:** Breakout analysis includes:
- `standaloneValue`: Could this be repurposed?
- `potentialFormats`: What could it become?
- `keyLesson`: What's the transferable insight?

**The transferable principle:**
- Analysis isn't just classification
- Good analysis answers: "So what? What do I do with this?"
- Include fields that drive decisions

**How to invoke:** "What action would the user take based on this analysis?"

---

### 19. Validation Through Q&A

**What we did:** Created a Q&A document presenting:
1. The extracted text
2. The analysis values
3. Our opinion/reasoning
4. A question for the user

**The transferable principle:**
- Q&A validates both extraction AND analysis prompts
- User feedback reveals prompt gaps and misclassifications
- Opinions make the agent's reasoning transparent
- Questions target specific areas of uncertainty

**How to invoke:** After running prompts, ask: "Want to do a Q&A session to validate the outputs?"

---

### 20. "Standard" Ratings Are Improvement Opportunities

**Insight from Q&A:** When analysis returns values like:
- `memorability: standard`
- `strength: moderate`
- `effectiveness: typical`

A good prompt engineering agent might offer:

> "The sign-off was rated 'standard'. Would you like suggestions for more memorable alternatives?"

**The transferable principle:**
- "Good enough" is an opportunity for "better"
- Don't just report - offer to improve
- This is a potential Paige capability

---

## Execution Results

### b64-bmad-claude-sdk Analysis

**Ran:** 2025-12-03
**Input:** Extraction data from Section 10
**Output:** Stored in `workflow-data.json`

**Key Findings:**
1. Strong intro structure (imagination hook + clear promise)
2. Comprehensive outro with high-curiosity teaser
3. Consistent soft CTA style (except outro)
4. Two high-value breakout candidates (Second Brain, Postmortems as AI Training)

**Prompt Gap Identified:**
- Demo preview appears in intro but NOT in breakouts
- Breakout prompt should explicitly catch demos

---

## Q&A Session Summary

**Document:** `10-11-qa-session.md`
**Items Reviewed:** 16 (5 intro + 3 outro + 5 CTA + 3 breakout)
**Questions Asked:** 20

**Key User Feedback:**
1. Analysis generally accurate - prompts working well
2. Demo preview gap confirmed - needs fix
3. Chapter links classification ambiguous (CTA vs navigation)
4. Soft CTA style is intentional
5. "Standard" ratings → opportunity for improvement suggestions

**Meta-Learnings for Paige:**
- Q&A validates prompt quality, not just output quality
- Some checks work better as predicates than extractions
- Offer improvements when analysis shows "standard" patterns

---

## Version History

- **v1 (2025-12-03)**: Initial creation based on Section 10 extraction and Q&A session
