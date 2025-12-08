# Section 10: Segment Extraction - Video Notes

## What Happened

Created a new section to extract structural segments from transcripts. Research-driven design based on analyzing 10+ existing video transcripts.

### Final Workflow
1. **10-1**: Extract intro segments (hook, promise, signOff, chapterMention, demoPreview)
2. **10-2**: Extract outro segments (recap, teaser, signOff)
3. **10-3**: Extract ALL CTAs with position
4. **10-4**: Extract breakout moments

### Two-Phase Architecture
Section 10 extracts → Section 11 analyzes. This separation allows validation and iteration at each phase.

---

## Key Discoveries

### 1. Research Before Design

Analyzed existing transcripts before creating prompts. Found:
- User's naming conventions (`01-1-intro`, `09-1-outro-RECAP`)
- Signal phrases ("I'm AppyDave, let's get into it")
- Four distinct segment types

**Why it matters:** Real data reveals categories better than assumptions.

### 2. Structure vs Content Type

Distinction emerged: intro/outro are **structural** (position-based), while demo/retrospective are **content types** (what it IS).

This led to different output formats:
- Intro/outro: `{ type, text }` - structural typing
- CTA/breakout: `{ text, position }` - position-based

### 3. Signal Phrases Are Reliable Anchors

Consistent verbal patterns mark transitions:
- "I'm AppyDave, let's get into it" = intro end
- "So there we have it" = outro start

More reliable than semantic detection.

### 4. Demo Preview Gap

Demo preview was caught by intro prompt but NOT breakout prompt. Demos are also breakouts with high repurposing value.

**Action needed:** Add "demo" to breakout detection.

---

## Output Fields

| Prompt | Output Field | Structure |
|--------|--------------|-----------|
| 10-1 | `videoIntroExtract` | `{ segments: [{ type, text }] }` |
| 10-2 | `videoOutroExtract` | `{ segments: [{ type, text }], ctasPresent }` |
| 10-3 | `videoCtaExtract` | `{ items: [{ text, position }] }` |
| 10-4 | `videoBreakoutExtract` | `{ items: [{ text, position }] }` |

---

## New Tips for Paige

1. **#18 Implicit Structure**: Examine user's existing artifacts for taxonomies
2. **#19 Structure vs Content Type**: These are orthogonal - don't conflate
3. **#20 Signal Phrases**: Document them - more reliable than meaning detection

---

## Files Created

### Prompts
- `10-1-extract-intro.hbs`
- `10-2-extract-outro.hbs`
- `10-3-extract-cta.hbs`
- `10-4-extract-breakout.hbs`

### Documentation
- `10-segment-extract.md` - Full analysis with 14 Paige tips
- `10-11-qa-session.md` - Q&A validation document

---

## Quotable Moments

> "Research existing content before designing prompts. Let the data reveal the categories."

> "Structure is position/role in the whole. Content type is what it IS. They need different prompts."

> "Signal phrases are more reliable than trying to detect meaning."
