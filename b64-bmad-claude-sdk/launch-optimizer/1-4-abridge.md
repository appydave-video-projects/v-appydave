# Section 1, Step 4: Abridge

## Prompt Template

**Files**:
- `/Users/davidcruwys/dev/ad/poem-os/poem/data/youtube-launch-optimizer/prompts/1-4-abridge-v1.hbs` (Original)
- `/Users/davidcruwys/dev/ad/poem-os/poem/data/youtube-launch-optimizer/prompts/1-4-abridge-v2.hbs` (Improved)

**Synopsis**: Condenses the full transcript while preserving meaningful information. The goal is near-lossless compression - smaller but retaining all educational value.

---

## Inputs Used

| Input | Source |
|-------|--------|
| `transcript` | `/Users/davidcruwys/dev/video-projects/v-appydave/b64-bmad-claude-sdk/final/b64-bmad-claude-sdk.mp4.txt` (~12,000 words) |

---

## Outputs

### Transcript Abridgement V1 (Original Prompt)

**Value**: See `workflow-data.json` → `transcriptAbridgement_v1` (~500 words)

**How derived**: Generic prompt asking to "condense while preserving narrative, key themes, original tone"

### Transcript Abridgement V2 (MUST/MAY Prompt)

**Value**: See `workflow-data.json` → `transcriptAbridgement_v2` (~2,000 words)

**How derived**: Structured prompt with MUST preserve (named entities, numbers, problems/solutions) and MAY remove (filler, repeated explanations) rules. JPEG compression analogy.

---

## Paige's Observations (Prompt Engineer Review)

### Output Quality Assessment

| Output | Quality | Notes |
|--------|---------|-------|
| `transcriptAbridgement_v1` | ⚠️ Struggles | ~60-65% information preserved. Too lossy for educational repurposing. |
| `transcriptAbridgement_v2` | ✅ Good | ~90-95% information preserved. Near-lossless, suitable for downstream content. |

### Comparative Analysis

| Metric | V1 | V2 |
|--------|----|----|
| **Word count** | ~500 | ~2,000 |
| **Compression ratio** | ~96% smaller | ~83% smaller |
| **Information preserved** | ~60-65% | ~90-95% |
| **Could recreate project?** | ❌ No | ✅ Mostly yes |
| **Named entities preserved** | 6/7 agents | 7/7 agents |
| **Story numbers preserved** | 0/14 | 14/14 |
| **Commands preserved** | 0/10 | 10/10 |
| **Problems & solutions** | 3 (vague) | 6 (detailed) |

### Downstream Usage

The abridgement is the **source of truth** for all repurposing:
- Skool educational documents
- LinkedIn articles
- Blog posts
- Video descriptions
- Chapters

**If the abridgement loses information, every downstream output loses it too.**

### User Feedback

- Voice/personality does NOT need to be preserved
- Goal is to convey **information and education**
- V2 approach (MUST/MAY structure) is correct for this use case

---

## POEM Insight: Research Before Design

### The Problem

V2 was created by asking an LLM to improve V1. This is **iteration without research**.

A smarter approach: **Research how others have solved similar problems first.**

### Prior Art to Study

1. **Claude Code's context compaction algorithm** - Kicks in when context window gets too long. Likely lossy, but designed by expert prompt engineers.

2. **Extractive vs Abstractive Summarization** - Academic NLP research on compression techniques.

3. **Other prompt engineers' published techniques** - Web search, deep research on "near-lossless transcript compression."

### Paige's Capability Gap

The Prompt Engineer agent (Paige) should have this built-in:

> **Research before design, not just iterate.**

When improving a prompt, Paige should:
1. Identify the problem domain (e.g., "transcript compression")
2. Research existing solutions (web search, deep research, documentation)
3. Understand patterns/principles from prior art
4. THEN design the prompt informed by that research

This is NOT what happened with V2. V2 was "talk to LLM → get improvement." Better than nothing, but not optimal.

### Action for Paige

Add to Paige's capabilities:
- [ ] Research existing solutions before designing prompts
- [ ] Study prior art (Claude Code compression, academic NLP, published techniques)
- [ ] Document research findings alongside prompt iterations

---

## Pattern Analysis

| Pattern | Applies? | Notes |
|---------|----------|-------|
| **Multiple Variants** | ✅ Yes | V1 (lossy) vs V2 (near-lossless) serve different purposes |
| **Quality Gate** | ✅ Yes | Next step (1-5) is QA specifically for abridgement |
| **Sequential Refinement** | ✅ Yes | V1 → V2 is prompt refinement; V2 should inform future iterations |
| **Parallel Execution** | ✅ Yes | Summary (1-3) and Abridge (1-4) can run in parallel - both only need transcript |

---

## Recommendation

**V2 should be the default.** V1 could be deprecated or kept only for "quick summary" edge cases.

The MUST/MAY structure in V2 is the right approach for educational content repurposing.

---

## Questions Deferred

1. Should the 40-60% target length in V2 prompt be adjusted? (Current output is ~17%)
2. Is markdown structure (headers, sections) the right output format for downstream repurposing?
