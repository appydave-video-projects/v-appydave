# Section 1, Step 3: Script Summary

## Prompt Template

**File**: `/Users/davidcruwys/dev/ad/poem-os/poem/data/youtube-launch-optimizer/prompts/1-3-summarize-video.hbs`

**Synopsis**: Condenses the full video transcript to essential points and main ideas using NLP analysis. Extracts pivotal information while maintaining original intent and tone.

---

## Inputs Used

| Input | Source |
|-------|--------|
| `transcript` | `/Users/davidcruwys/dev/video-projects/v-appydave/b64-bmad-claude-sdk/final/b64-bmad-claude-sdk.mp4.txt` |

---

## Outputs

### Transcript Summary

**Value**: See `workflow-data.json` → `transcriptSummary`

**How derived**: Analyzed ~1000 lines of transcript to extract:
- Core concept (self-editing applications)
- Technical stack (Express, React, Socket.IO, Claude SDK)
- BMAD workflow steps (7 agents demonstrated)
- Three epics implemented
- Notable features built
- Key insights

---

## Paige's Observations (Prompt Engineer Review)

### Output Quality Assessment

| Output | Quality | Notes |
|--------|---------|-------|
| `transcriptSummary` | ✅ Good (for purpose) | Technically accurate; used for tweets/short-form. Narrative gaps may not matter. |

### Q&A Session

**User Feedback:**

- Summary is used for **short-form content** (tweets, social posts)
- User prefers **abridgment** over summary - will clarify distinction at Step 1-4
- Summary was "technically accurate, narratively incomplete" but that may be acceptable for its purpose

**Open Questions (now answered after Abridgment step):**

1. ~~Should summary capture narrative elements?~~ → **No.** Summary is for short-form (tweets). Abridgment captures narrative.
2. ~~What's the distinction between summary vs abridgment?~~ → **Summary = lossy (highlights). Abridgment = near-lossless (educational source of truth).**
3. ~~Does the prompt need improvement?~~ → **Probably not for its purpose.** Summary feeds tweets/social. Abridgment feeds articles/docs.

**Clarified Roles:**
- **Summary**: Short-form outputs (tweets, social posts) - OK to be lossy
- **Abridgment**: Source of truth for repurposing (Skool docs, LinkedIn, blog) - must be near-lossless

---

### Pattern Analysis

| Pattern | Applies? | Notes |
|---------|----------|-------|
| **Review & Approve** | ✅ Yes | AI generates summary → Human reviews → Approve or refine |
| **Multiple Variants** | 🤔 Potential | Could generate multiple compression levels (short/medium/detailed) |
| **Parallel Execution** | ✅ Yes | Can run in parallel with Abridge (both only need transcript) |

---

### Prompt Assessment

The current prompt is simple and generic:
- "Condense the text to its essential points or main ideas"
- "Capture the core meaning or highlights"

**Potential improvements:**
1. Add structure guidance (categories to extract)
2. Specify output format (bullet points, paragraphs, sections)
3. Define target length
4. Include context about downstream usage (this summary feeds into title/description generation)
