# Section 2, Step 3: Create Chapters

## Prompt Template

**File**: `/Users/davidcruwys/dev/ad/poem-os/poem/data/youtube-launch-optimizer/prompts/2-3-create-chapters.hbs`

**Synopsis**: Matches chapter reference text to SRT timestamps to produce final YouTube chapter format.

---

## Inputs Used

| Input | Source |
|-------|--------|
| `srt` | SRT file with timestamps (~170KB, ~1:54:34 video) |
| `transcript` | Original transcript (used abridgement as proxy due to size) |
| `chapters` | `refineChapters_v2` (34 chapters with reference text) |

---

## Output

**Value**: See `workflow-data.json` → `createChapters`

**Format**: YouTube chapter format (`M:SS Title` or `H:MM:SS Title`)

**Sample**:
```
0:00 Intro: Self-Editing Apps
0:24 Demo: What We're Building
1:38 Installing BMAD Method v4
5:24 Claude Code Setup
...
```

---

## Paige's Observations (Prompt Engineer Review)

### Output Quality Assessment

| Aspect | Quality | Notes |
|--------|---------|-------|
| **Verified timestamps** | ⚠️ Partial | 15/34 (44%) found via SRT search |
| **Estimated timestamps** | ❌ Unreliable | 19/34 (56%) are guesses |
| **Chronological order** | ❌ Broken | Epic 3 Introduction at 1:31:01 is wrong |
| **Format correctness** | ✅ Good | Proper YouTube chapter format |

### Timestamps Found via SRT Search

| Chapter | Timestamp | Search Phrase |
|---------|-----------|---------------|
| Intro | 0:00 | "Imagine building a self editing" |
| Installing BMAD | 1:38 | "version four, which is the current" |
| Claude Code Setup | 5:24 | "start with our terminal" |
| Skool Community | 18:29 | "SKOOL community" |
| PRD with PM Agent | 18:41 | "new agent...project manager" |
| VOZ Boy Baker | 27:16 | "Baker by Voz" |
| Epic 3 Introduction | 31:01 | "React application as the front end" |
| Architecture Document | 41:37 | "architecture agent" |
| Solutioning | 52:26 | "alignment between PRD" |
| Sharding | 53:37 | "sharding is the idea" |
| Story 1.1 | 55:49 | "mono repo set up" |
| Custom SAT Agent | 1:04:05 | "second brain" |
| Story 1.4 Socket.IO | 1:14:31 | "Socket.io" |
| Story 3.1 React | 1:47:59 | "Hello World" |
| Story 3.3 | 1:49:21 | "everything changed" |

### Timestamps Not Found (Estimated)

These chapters required estimation based on chronological position:
- Demo: What We're Building
- Project Scenario
- Project Brief with Analyst
- VOZ Boy Baker Continued
- Epic and Story Planning
- System Prompt Cleanup
- Story 1.2: Express Server
- Story 1.3: HTML Client
- Development Retrospective
- Recap and Next Steps
- Claude SDK Configuration
- Stories 2.2-2.6
- Story 3.2
- Bookstore Demo
- Outro

### Critical Issue: Chronological Order

The output has timestamps out of order:
```
1:42:00 Story 2.6: HTML Tools
1:31:01 Epic 3 Introduction  ← WRONG - should be ~1:45:00
1:47:59 Story 3.1: React Setup
```

This happened because "React application as the front end" was found at 31:01 (the epic MENTION in the PRD section), not the actual Epic 3 development section.

**Root cause**: The same phrase can appear multiple times in a transcript. The first match isn't always the right one.

---

## Pattern Analysis

| Pattern | Applies? | Notes |
|---------|----------|-------|
| **Multi-Source Matching** | ✅ Attempted | Used SRT + transcript + chapters |
| **Fuzzy Matching** | ❌ Not implemented | Exact phrase search only |
| **Quality Gate** | ⚠️ Needed | Should validate chronological order |
| **Manual Input Checkpoint** | ✅ Yes | Human verification of timestamps needed |

---

## Approach Analysis

### Current Approach: Phrase Search in SRT

**How it works**:
1. Extract key phrase from chapter reference text
2. Grep for phrase in SRT file
3. Extract timestamp from matching line

**Problems**:
1. **Text splits** - SRT breaks sentences across blocks
2. **Formatting differences** - "self-editing" vs "self editing"
3. **Multiple matches** - Same phrase appears in different contexts
4. **Large file** - Can't read full SRT into context
5. **No fuzzy matching** - Exact phrases only

### Why 56% of Timestamps Were Estimated

| Reason | Example |
|--------|---------|
| **No distinctive phrase** | "Server setup with basic endpoints" - too generic |
| **Phrase not in SRT** | Reference text was summarized, not verbatim |
| **Text split across blocks** | Sentence broken mid-way in SRT |
| **Different wording** | Transcript says it differently than reference |

---

## POEM Insights

### 1. First Match ≠ Right Match

The phrase "React application as the front end" appears when describing the Epic (at 31:01) AND when starting Epic 3 development (~1:45:00). The first match was wrong.

**Principle**: When matching text to timestamps, consider that phrases may repeat. Need context-aware matching or chronological validation.

### 2. Reference Text Quality Determines Success

Chapters with verbatim transcript quotes found timestamps. Chapters with summarized reference text failed.

**Principle**: If downstream steps need exact matching, upstream steps should preserve verbatim text, not paraphrase.

### 3. SRT Structure Fights Sentence Matching

SRT splits text into ~5-second blocks. Sentences span multiple blocks. This makes phrase searching fragile.

**Principle**: SRT files need pre-processing into sentence-level or paragraph-level chunks for reliable matching.

### 4. The 44% Accuracy Problem

When less than half of timestamps are verified, the output isn't production-ready. Users must manually verify every timestamp.

**Principle**: This step needs a fundamentally different approach to achieve acceptable accuracy.

---

## Future Strategy: Anchor Text from Recording Time

### The Problem with Current Approach

Matching arbitrary reference text against SRT is fragile because:
- Text splits across SRT blocks
- Same phrases appear multiple times
- Reference text may be paraphrased, not verbatim

### The Solution: Capture Opening Lines at Recording Time

**Key insight**: The first sentence of each chapter recording = the first sentence of that chapter in the final video. Even with editing cuts, chapter openings remain intact.

### How It Works

```
Recording lands → Whisper transcribes → Capture first sentence
                                              ↓
                                        Store as chapter anchor
                                              ↓
Final SRT from Gling → Search for anchor text → Extract timestamp
```

### Why This Works

| Current Approach | Anchor Text Approach |
|------------------|---------------------|
| Match arbitrary reference text | Match chapter's opening line |
| Reference text may be paraphrased | Opening line is verbatim from Whisper |
| Same phrase appears multiple times | Opening line appears once (chapter start) |
| 44% accuracy | Should be ~95%+ |

### Data Structure Per Chapter

```json
{
  "chapter": 7,
  "name": "mary-analyst",
  "anchor_text": "Now we're going to use the analyst agent Mary to create our project brief",
  "clips": ["07-1-mary-analyst.mov", "07-2-mary-analyst.mov", ...]
}
```

### Integration with Recording Namer Tool

The user's existing tooling (Recording Namer) already:
- Assigns chapter numbers and names at recording time
- Watches for incoming recordings
- Organizes clips by chapter

Future enhancement:
- Run Whisper on each recording as it lands
- Extract first sentence from `{chapter}-1-{name}.mov`
- Store as `anchor_text` for that chapter

### SRT Source

Final SRT comes from **Gling.ai** (editing software), which provides:
- Accurate transcription
- Post-edit timing (matches final video)
- User can improve text during editing

### Why Other Approaches Are Less Suitable

| Approach | Issue |
|----------|-------|
| **Pre-process SRT** | Still matching arbitrary text |
| **Time-window chunking** | Imprecise, doesn't solve matching |
| **LLM with full context** | Expensive, still matching arbitrary text |
| **Two-pass matching** | More complex, still arbitrary text |
| **Timestamps in folder names** | Manual effort, error-prone |

**Anchor text approach** solves the root problem: we match text we **know** marks the chapter start, captured at the moment of recording.

---

## Questions for User

1. **Accuracy threshold**: What percentage of verified timestamps would make this output "good enough"? 80%? 95%?

2. **Manual verification**: Are you currently manually verifying/fixing timestamps anyway? If so, is ~44% accuracy useful as a starting point?

3. **Folder name timestamps**: Would you consider adding rough timestamps to your folder names (e.g., `14-55m-develop.1.1-setup-monorepo`)?

4. **Alternative approaches**: Which of the approaches above (A-E) seems most practical for your workflow?

5. **SRT availability**: Do you always have an SRT file, or sometimes only the transcript?

---

## Recommendations

1. **Don't use this output as-is** - The 56% estimated timestamps and chronological errors make it unreliable

2. **Add chronological validation** - Quality gate that rejects out-of-order timestamps

3. **Improve reference text** - V2 chapters should use exact transcript quotes, not summaries

4. **Explore Approach D** - Two-pass matching seems most practical without major workflow changes

5. **Consider Approach E** - If timestamp accuracy is critical, human-provided rough timestamps upstream would solve the problem

---

## Sources

- SRT file: `/Users/davidcruwys/dev/video-projects/v-appydave/b64-bmad-claude-sdk/transcripts/b64-bmad-claude-sdk.srt`
- YouTube chapters documentation researched in Step 2-2
