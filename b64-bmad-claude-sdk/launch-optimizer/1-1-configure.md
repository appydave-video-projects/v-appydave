# Section 1, Step 1: Configure

## Prompt Template

**File**: `/Users/davidcruwys/dev/ad/poem-os/poem/data/youtube-launch-optimizer/prompts/1-1-configure.hbs`

**Synopsis**: Extracts project code from project folder name, generates a short working title, and produces a list of 3-7 word title suggestions based on the transcript content.

---

## Inputs Used

| Input | Source |
|-------|--------|
| `projectFolder` | `b64-bmad-claude-sdk` |
| `transcript` | `/Users/davidcruwys/dev/video-projects/v-appydave/b64-bmad-claude-sdk/final/b64-bmad-claude-sdk.mp4.txt` |

---

## Outputs

### Project Code

**Value**: `b64`

**How derived**: Extracted from project folder name `b64-bmad-claude-sdk` - the prompt looks for a letter followed by two numbers.

---

### Short Title

**Value**: `BMAD Claude SDK`

**How derived**: Generated from project folder name by removing the project code prefix and converting to title case.

---

### Title Ideas

**Value**: See `workflow-data.json` → `titleIdeas` (10 items)

**How derived**: Read the full transcript and extracted key themes/topics to generate YouTube-optimized titles (3-7 words each). Key themes identified: self-editing applications, Claude Agent SDK, BMAD method, context engineering, vibe coding, web development.

---

## Paige's Observations (Prompt Engineer Review)

### Output Quality Assessment

| Output | Quality | Notes |
|--------|---------|-------|
| `projectCode` | ✅ Good | Straightforward extraction - letter + two digits from folder name |
| `shortTitle` | ✅ Good | Simple derivation from folder name, works reliably |
| `titleIdeas` | ⚠️ Struggles | Consistently misses the mark across videos - likely too early in workflow (missing upstream context) |

### Prompt Refinement Hypotheses

**Why might `titleIdeas` be underperforming?**

1. **Missing downstream context?**
   - At this stage, we only have raw transcript
   - Better titles might need: `transcriptSummary`, `videoKeywords`, `contentHighlights`
   - These are generated in later steps (downstream) but needed here

2. **Workflow sequencing issue?**
   - Section 5 has a dedicated title generation step with more context
   - Perhaps `titleIdeas` here should be acknowledged as "starter titles" not "final titles"

### Recommendation

**(B) Acknowledge as starter titles** - These are rough suggestions to frame discussions. Final titles come from Section 5 with more context. Add a follow-up step for human shortlist selection.

**POEM Insight:** Some outputs need downstream context that doesn't exist yet. The workflow should distinguish between "draft/working" outputs vs "final" outputs.

---

### Pattern Analysis

| Pattern | Applies? | Notes |
|---------|----------|-------|
| **Flexible Selection** | ✅ Yes | User picks from numbered list but can also add own inspiration |
| **Parallel Execution** | ✅ Yes | Next steps (Summary, Abridge) can run in parallel - both only need transcript |
| **Sequential Refinement** | ✅ Yes | titleIdeas → titleIdeasShortlist (new step) → final titles (Section 5) |
| **Manual Input Checkpoint** | ✅ Yes | Shortlist selection requires human choice |

### Action Taken

Created new Step 1-2 (Title Shortlist Selection) as a Flexible Selection checkpoint. Renumbered subsequent prompts.
