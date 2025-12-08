# Section 2, Step 2: Refine Chapters

## Prompt Templates

**Files**:
- `/Users/davidcruwys/dev/ad/poem-os/poem/data/youtube-launch-optimizer/prompts/2-2-refine-chapters-v1.hbs` (Original)
- `/Users/davidcruwys/dev/ad/poem-os/poem/data/youtube-launch-optimizer/prompts/2-2-refine-chapters-v2.hbs` (Improved)

**Synopsis**: Aligns AI-suggested chapters with author's folder names to create refined chapter titles with reference text for timestamp matching.

---

## Inputs Used

| Input | Source |
|-------|--------|
| `identifyChapters` | Step 2-1 output (16 chapters with reference quotes) |
| `transcript` | Original transcript (used V2 abridgement as proxy due to size) |
| `chapterFolderNames` | User-provided folder names (34 folders) |

---

## Outputs

### V1 Output

**Value**: See `workflow-data.json` → `refineChapters_v1`

**Format**: Title only (no reference text)

**Sample**:
```
Introduction to Self-Editing Apps
Application Demo Preview
Project Scenario Overview
...
```

### V2 Output

**Value**: See `workflow-data.json` → `refineChapters_v2`

**Format**: Number + Title + Reference text

**Sample**:
```
00. Intro: Self-Editing Apps
    "Imagine building a self-editing application where you talk to it..."

01. Demo: What We're Building
    "So our Agent SDK application is built and this is what it can do..."
```

---

## V1 vs V2 Comparison

### Structural Differences

| Aspect | V1 | V2 |
|--------|----|----|
| **Output format** | Title only | Number + Title + Reference text |
| **Character limit** | Not specified | Under 49 characters |
| **Reference text** | ❌ Lost | ✅ Preserved |
| **Timestamp matching** | ❌ Impossible | ✅ Enabled |

### Quality Assessment

| Dimension | V1 | V2 | Verdict |
|-----------|----|----|---------|
| **Reference text preservation** | ❌ | ✅ | **Significant improvement** |
| **Character limits** | Reasonable | Explicit 49-char | Minor improvement |
| **Title clarity** | Good | Good | Similar |
| **Completeness** | Limited by input | Limited by input | Same |

### Missing Stories (Input Data Issue)

Both V1 and V2 are missing stories because the **folder input** was incomplete:

| Story | Description | In Folders? |
|-------|-------------|-------------|
| 2.1 | SDK installation | ✅ Folder 20 exists but unlabeled |
| 2.7 | Conversational memory | ❌ Missing folder |
| 3.4 | Light/dark mode + polish | ❌ Missing folder |

**Root cause**: Input data gap, not prompt issue. The "Manual Input Checkpoint" pattern applies - human must ensure folder list is complete.

### Verdict

**V2 is meaningfully better** because it preserves reference text (critical for downstream timestamp matching). The Data Loss Anti-Pattern identified in V1 is fixed in V2.

---

## Paige's Observations (Prompt Engineer Review)

### Output Quality Assessment

| Aspect | Quality | Notes |
|--------|---------|-------|
| **Folder alignment** | ✅ Good | 34 titles match 34 folders |
| **Title quality** | ⚠️ Struggles | Some titles may be too long for YouTube |
| **Reference text** | ❌ Missing | Lost the transcript quotes from Step 2-1 |

### Critical Gap: Lost Reference Text

**Step 2-1 output HAD the text:**
```
1. Introduction
  "Imagine building a self-editing application..."
```

**Step 2-2 output LOST it:**
```
Introduction to Self-Editing Apps
```

This is a **Data Loss Anti-Pattern**. The reference text is critical because:
1. Later steps need to match chapter → timestamp
2. Timestamps can only be found by knowing what text was spoken
3. The text anchors the chapter to a specific transcript location

### YouTube Chapter Title Best Practices

Research from [YouTube Help](https://support.google.com/youtube/answer/9884579?hl=en), [tubics](https://www.tubics.com/blog/youtube-chapters), and [Wyzowl](https://wyzowl.com/add-chapters-to-youtube/) reveals:

| Constraint | Value | Implication |
|------------|-------|-------------|
| Max characters | 120 | Hard limit |
| Hover-over cutoff | **49 characters** | Real practical limit |
| Recommended chapters | ~10 | Tutorial videos may have more |
| Format | `0:00 Title` | Timestamp + space + title |

**Key insight**: Titles over 49 characters get truncated in YouTube's hover preview. Aim for **under 49 characters**.

### Terminology Correction

**Wrong**: "SEO-friendly chapter titles" (implies blog-length)
**Right**: "YouTube chapter titles" - compressed, informative, scannable

---

## Pattern Analysis

| Pattern | Applies? | Notes |
|---------|----------|-------|
| **Flexible Selection** | ✅ Yes | Chapters should be editable, replaceable, removable, insertable |
| **Manual Input Checkpoint** | ✅ Yes | Folder names are human-sourced (copy/paste from filesystem) |
| **Authoritative Framework** | ✅ Yes | Folders provide: boundaries, hints, order. NOT: timestamps, exact text |
| **Data Loss Anti-Pattern** | ❌ Violated | Reference text was dropped during refinement |
| **Quality Gate** | ⚠️ Needed | Undefined, but refinement step needed |

---

## What Folder Names Actually Provide

| Provides | Doesn't Provide |
|----------|-----------------|
| Where chapters are (boundaries) | Timestamps |
| What user thinks they're called (hints) | Exact transcript text |
| Chapter order | Final polished title |

**Insight**: Folders are anchors for building quality titles, not the titles themselves. The AI still needs the transcript to understand what's actually being said in each section.

---

## Proposed Rewritten Prompt

```handlebars
You are creating YouTube chapter titles for a video. Your goal is to produce titles that are:
- **Compressed**: Under 49 characters (hover preview cutoff)
- **Informative**: Clearly describe what happens in that section
- **Scannable**: Viewers skim chapters to find what they need

## Inputs

### AI-Suggested Chapters (with reference quotes)
<identify_chapters>
{{identifyChapters}}
</identify_chapters>

### Author's Folder Names (authoritative structure)
<chapter_folder_names>
{{chapterFolderNames}}
</chapter_folder_names>

### Transcript
<transcript>
{{transcript}}
</transcript>

## Instructions

1. **Match folder count exactly**: Produce exactly one chapter per folder name
2. **Preserve folder order**: Do not add, remove, or reorder chapters
3. **Use folders as anchors**: Folder names indicate boundaries and topic hints
4. **Find the matching transcript text**: For each folder, identify what text was spoken
5. **Create compressed titles**: Under 49 characters, informative, scannable

## Output Format

For each chapter, output:
- Chapter number (matching folder)
- Chapter title (under 49 characters)
- Reference text (the transcript excerpt that matches this chapter)

```
Chapters:

00. [Title under 49 chars]
    "[Matching transcript text - first sentence or key quote]"

01. [Title under 49 chars]
    "[Matching transcript text]"

...
```

## Quality Checklist

Before outputting, verify:
- [ ] Each title is under 49 characters
- [ ] Each chapter has matching reference text
- [ ] Folder order is preserved exactly
- [ ] Titles are informative (viewer knows what section contains)
```

---

## POEM Insights

### 1. Data Loss Anti-Pattern

When a refinement step processes data, it should **preserve or enhance context**, not drop it. The original reference quotes were lost, making downstream timestamp matching impossible.

**Principle**: Refinement should add value without losing upstream context.

### 2. Platform-Specific Constraints

"SEO-friendly" is too generic. YouTube chapters have specific constraints (49-char hover cutoff) that differ from blog titles. The prompt should encode platform-specific rules.

**Principle**: Prompts should include platform constraints, not generic optimization goals.

### 3. Anchor vs Authority

Folder names are **anchors** (boundaries, hints, order) not **authorities** (final titles). The distinction matters because:
- Anchors guide → AI still needs to do work
- Authorities dictate → AI just formats

**Principle**: Clarify whether inputs are anchors or authorities.

---

## Questions for User

1. Should the 49-character limit be a hard constraint or a soft guideline?

2. For very long sections, should the reference text be truncated or include multiple quotes?

3. Should we add a character count validation step (Quality Gate)?

---

## Sources

- [YouTube Help - Video Chapters](https://support.google.com/youtube/answer/9884579?hl=en)
- [tubics - YouTube Chapters Ultimate Guide](https://www.tubics.com/blog/youtube-chapters)
- [Wyzowl - How to Add Chapters](https://wyzowl.com/add-chapters-to-youtube/)
- [VdoCipher - Video Chapters Guide](https://www.vdocipher.com/blog/youtube-video-chapters-with-timestamp/)
