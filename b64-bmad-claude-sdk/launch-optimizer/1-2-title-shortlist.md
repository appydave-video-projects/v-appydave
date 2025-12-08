# Section 1, Step 2: Title Shortlist Selection

## Prompt Template

**File**: `/Users/davidcruwys/dev/ad/poem-os/poem/data/youtube-launch-optimizer/prompts/1-2-title-shortlist.hbs`

**Synopsis**: Presents AI-generated title ideas to user for selection. User can pick from numbered list, modify suggestions, or add their own. This is a human input checkpoint, not an LLM generation step.

---

## Inputs Used

| Input | Source |
|-------|--------|
| `titleIdeas` | `workflow-data.json` (from Step 1-1) |

---

## Outputs

### Title Ideas Shortlist

**Value**: See `workflow-data.json` → `titleIdeasShortlist` (3 items selected: 0, 2, 8)

**How derived**: Human selection from presented list.

**Selected titles**:
1. Build Self-Editing Apps with Claude Agent SDK
2. Create AI-Powered Web Apps Using Claude SDK
3. BMAD Method v4 Complete Development Tutorial

---

## Paige's Observations (Prompt Engineer Review)

### Output Quality Assessment

| Output | Quality | Notes |
|--------|---------|-------|
| `titleIdeasShortlist` | ⚠️ Struggles | None of the options really hit the mark - missing brand requirements |

### User Feedback

> "None of them really hit the mark because any title we're going to want for this video should have both the word BMAD and Claude Agent SDK, or at the very least Agent SDK in it. And potentially self-editing app."

### Prompt Refinement Hypotheses

**Why might the title options be underperforming?**

1. **Missing title constraints/requirements?**
   - The prompt doesn't know brand requirements (BMAD + SDK combo)
   - User has domain knowledge about what makes a good title for their channel
   - This knowledge can't be inferred from transcript alone

2. **Optional Custom Instruction pattern?**
   - Could add an optional input: "title requirements" or "must include keywords"
   - e.g., `titleRequirements: ["BMAD", "Claude Agent SDK", "self-editing"]`
   - This would be human-provided constraints fed into title generation

3. **Downstream context still missing?**
   - Even with shortlist, final title comes from Section 5 with more context
   - This step narrows options but doesn't produce final title

### Recommendation

**(A) Add optional "title requirements" input** - Allow user to specify must-have keywords or brand constraints that feed into title generation (Step 1-1 and Section 5).

**POEM Insight:** Some outputs need **human domain knowledge** that can't be inferred from content. The "Optional Custom Instruction" pattern allows users to provide constraints without making them mandatory.

---

### Pattern Analysis

| Pattern | Applies? | Notes |
|---------|----------|-------|
| **Flexible Selection** | ✅ Yes | User picks from list OR adds own ideas |
| **Manual Input Checkpoint** | ✅ Yes | Human provides selection - AI cannot proceed without it |
| **Optional Custom Instruction** | 🆕 Detected | User could provide title requirements as optional input |
| **Authoritative Framework** | ✅ Potential | Human-provided constraints (keywords) would improve AI accuracy |

---

### Questions for Future Investigation

1. Should "title requirements" be a workflow-level setting or per-video input?
2. Is this pattern (optional custom instructions) common across other steps?
3. Could brand requirements be stored in a profile/config that applies to all videos?
