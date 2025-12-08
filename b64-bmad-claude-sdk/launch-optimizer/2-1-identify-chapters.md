# Section 2, Step 1: Identify Chapters

## Prompt Template

**File**: `/Users/davidcruwys/dev/ad/poem-os/poem/data/youtube-launch-optimizer/prompts/2-1-identify-chapters.hbs`

**Synopsis**: Generates initial chapter suggestions from transcript with reference quotes.

---

## Inputs Used

| Input | Source |
|-------|--------|
| `transcript` | Original transcript (~12,000 words) |

---

## Output

**Value**: See `workflow-data.json` → `identifyChapters`

**Result**: 16 chapters identified with reference quotes

### Chapters Generated

1. Introduction
2. Project Setup
3. The First Story (Story 1)
4. Adding Features
5. Testing the Agent
6. Debugging and Troubleshooting
7. Agent Workflow Builder Demo
8. Adding New Capabilities
9. Tool Configuration
10. Parallel Processing
11. Error Handling
12. Final Implementation
13. Code Review
14. Best Practices
15. Future Improvements
16. Conclusion

---

## Paige's Observations (Prompt Engineer Review)

### Output Quality Assessment

| Aspect | Rating | Notes |
|--------|--------|-------|
| **Main chapter structure** | Good | Captures major topic transitions well |
| **Story identification** | Poor | Only captured "Story 1" explicitly, missed Stories 2-6+ |
| **Technical detail** | Medium | General terms like "Adding Features" lack specificity |
| **Reference quotes** | Good | Each chapter has supporting transcript quote |

### Key Gap: Story Numbers

The transcript uses explicit story numbering throughout:
- Story 1: Initial agent setup
- Story 2: File discovery issues
- Story 3: Tool configuration
- Story 4+: Progressive improvements

The prompt instruction "Use simple, general terms; minimize detail" actively works against capturing these story markers. The LLM followed the instruction correctly - the instruction itself is the problem.

### Prompt Analysis

**Current prompt weaknesses:**

1. **Overly minimal**: Just 22 lines including sample format
2. **Conflicting goals**: "minimize detail" conflicts with need to capture story numbers
3. **No MUST/MAY guidance**: Unlike V2 abridge, no clear preservation rules
4. **Broken placeholder**: `[x-transcript-abridgement]` at end does nothing
5. **Sample format errors**: Inconsistent numbering style ("2" vs "2.")

### Improvement Recommendations

**Option A: MUST/MAY Structure** (like V2 abridge)

Add explicit preservation rules:
```
MUST preserve in chapter names:
- Story numbers (Story 1, Story 2, etc.)
- Named tools or features
- Problem/solution pairs

MAY simplify:
- Generic transitions
- Repeated explanations
```

**Option B: Two-Pass Approach**

1. First pass: Identify all story/segment markers
2. Second pass: Group into chapters

**Option C: Hint at Detail Level**

Replace "minimize detail" with:
```
Use clear, scannable terms. Include story numbers
and named tools when they mark significant transitions.
```

### Workflow Design Insight

**This prompt's output isn't final** - Step 2-2 uses `chapterFolderNames` as authoritative structure. The AI suggestions are just input for alignment.

This changes the improvement calculus:
- If author always provides folder names → This prompt is just "rough suggestion"
- If author sometimes skips folder names → This prompt becomes authoritative

**Question**: Does the author always have folder names ready, or sometimes work from transcript alone?

---

## Pattern Analysis

| Pattern | Applies? | Notes |
|---------|----------|-------|
| **Multi-Pass Refinement** | Yes | 2-1 suggests → 2-2 aligns with folders → 2-3 finalizes |
| **Authority Hierarchy** | Yes | Folder names > AI suggestions |
| **Structured Output** | Partial | Has format, but minimal structure |
| **MUST/MAY** | No | Could benefit from this pattern |

---

## POEM Insights

### 1. Instructions That Conflict With Goals

The instruction "minimize detail" directly undermines capturing story numbers. When a prompt produces incomplete output, check if the instructions themselves are causing the problem.

**Principle**: Review prompt instructions for internal conflicts with desired outcomes.

### 2. Context Beyond Text

The user noted: "it would learn a lot if it had access to the file names I use."

For video content, the creator's file organization often encodes:
- Intended chapter structure
- Key topic names
- Story/segment boundaries

**Principle**: Consider what contextual artifacts (file names, folder structure, timestamps) encode author intent.

### 3. Rough Draft vs Final Output

This prompt exists in a pipeline where its output is refined. Knowing the downstream use (alignment with folder names) changes how we evaluate and improve it:
- If rough draft: Recall matters more than precision
- If final: Both matter equally

**Principle**: Evaluate prompts in their pipeline context, not isolation.

---

## Questions for User

1. Do you always have folder names ready before running this workflow, or sometimes work transcript-only?

2. Should story numbers be required in chapter identification, or is the current "general terms" approach correct for the rough draft stage?

3. Would adding the `transcriptAbridgement` as input help (since abridgement preserves story numbers)?
