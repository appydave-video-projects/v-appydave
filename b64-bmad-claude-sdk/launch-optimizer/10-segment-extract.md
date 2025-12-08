# Section 10: Transcript Segmentation Analysis

## Purpose

Analyze video transcripts to identify structural segments (intro, outro, CTAs, breakouts) for content understanding and repurposing opportunities.

## Prompts in This Section

| File | Purpose | Input | Output Field |
|------|---------|-------|--------------|
| 10-1-extract-intro.hbs | Extract intro segments | Transcript | `videoIntroExtract` |
| 10-2-extract-outro.hbs | Extract outro segments | Transcript | `videoOutroExtract` |
| 10-3-extract-cta.hbs | Find ALL CTAs with position | Transcript | `videoCtaExtract` |
| 10-4-extract-breakout.hbs | Find emergent learnings | Transcript | `videoBreakoutExtract` |

### Output Structures

**Intro/Outro** (structural typing):
```json
{ "segments": [{ "type": "hook", "text": "..." }] }
```

**CTA/Breakout** (position-based):
```json
{ "items": [{ "text": "...", "position": "intro" }] }
```

---

## Tips for Paige (Domain-Agnostic Learnings)

### 1. Research Existing Content Before Designing Prompts

**What we did:** Before creating the Section 10 prompts, we analyzed 10+ existing transcripts to identify real patterns.

**The transferable principle:** When designing prompts for ANY domain:
- Ask: "Do we have existing examples to analyze?"
- Look for patterns across multiple instances
- Let the data reveal the categories, don't assume them

**Anti-pattern:** Creating prompts based on assumptions without examining real examples.

---

### 2. User's Content Has Implicit Structure

**What we discovered:** The user already had naming conventions in their files (`01-1-intro`, `09-1-outro-RECAP`, `09-2-outro-ENDCARD`) that revealed their mental model.

**The transferable principle:** Before designing prompts:
- Ask: "What naming conventions or structures does the user already use?"
- Examine existing artifacts (file names, folder structures, templates)
- The user's implicit taxonomy is often better than an invented one

**How to invoke:** "What existing naming or organizational patterns do you already use for [this content type]?"

---

### 3. Distinguish Structure from Content Type

**What we learned:** "Breakouts" emerged as a structural category (divergence from main flow), while "talking head vs screen share" is a content type.

**The transferable principle:** When categorizing:
- **Structure** = position/role in the whole (intro, chapter, tangent)
- **Content type** = what it IS (demo, explanation, code walkthrough)
- Don't conflate these - they're orthogonal dimensions

**How to invoke:** "Is this a structural segment or a content type? They may need different prompts."

---

### 4. Emergent Categories Are Often the Most Valuable

**What we discovered:** "Breakouts" weren't in the original analysis plan. They emerged from examining real transcripts and noticing patterns like "second brain consultations" and "on-the-fly agent creation."

**The transferable principle:**
- Initial categories are hypotheses
- Real data reveals what actually exists
- Be willing to add/merge/discard categories based on evidence

**How to invoke:** "What patterns are we seeing that weren't in our original plan?"

---

### 5. The "Could This Stand Alone?" Test

**What we applied:** For breakouts, we asked whether content could become a standalone video/short.

**The transferable principle:** When identifying valuable content segments:
- Ask: "Does this have standalone value?"
- This question applies to any content: blog posts, documentation, training materials
- High standalone value = high repurposing potential

**How to invoke:** "Could this segment stand alone, or does it require context from the surrounding content?"

---

### 6. Signal Phrases Reveal Structure

**What we found:** Patterns like "I'm AppyDave, let's get into it" consistently mark intro endings. "So there we have it" marks outro beginnings.

**The transferable principle:** Most content creators have unconscious verbal patterns that signal transitions:
- Document these signal phrases
- Use them in prompts for reliable detection
- They're often more reliable than trying to detect "meaning"

**How to invoke:** "What phrases does [creator/user] consistently use to signal [transition type]?"

---

### 7. Separate "What Exists" from "What Should Exist"

**What we did:** Section 10 identifies what's IN the transcript. It doesn't judge whether the intro was good or suggest improvements.

**The transferable principle:**
- Extraction prompts should extract, not evaluate
- Evaluation prompts should evaluate, not extract
- Mixing these creates confusion and unreliable outputs

**How to invoke:** "Is this prompt extracting what exists, or evaluating quality? These should be separate."

---

---

## Software Architecture Principles for Prompt Engineering

These principles transfer directly from software architecture to prompt engineering. Paige should recognize and apply them.

### 8. Single Responsibility Principle (SRP)

**In software:** A class should have one reason to change.

**In prompts:** A prompt should do ONE thing well.

- Extract OR evaluate, not both
- Generate OR rank, not both
- One metric per predicate prompt

**Anti-pattern:** "Extract keywords, analyze sentiment, generate titles, and rank them" - too many responsibilities.

**How to invoke:** "Is this prompt doing more than one thing? Should we split it?"

---

### 9. DRY (Don't Repeat Yourself)

**In software:** Every piece of knowledge should have a single, authoritative source.

**In prompts:**
- Don't duplicate context across prompts (use shared variables)
- Don't have two prompts extracting the same thing differently
- Avoid "pale imitations" where one prompt's output conflicts with another's

**Anti-pattern:** `keywords` in one prompt, `searchTerms` in another, both extracting similar concepts with different shapes.

**How to invoke:** "Do we already extract this elsewhere? Can we reuse that output?"

---

### 10. Composition Over Inheritance

**In software:** Favor object composition over class inheritance.

**In prompts:**
- Build workflows from small, composable prompts
- Chain outputs rather than creating one "master" prompt
- Each prompt in the chain has a clear input→output contract

**Anti-pattern:** One massive prompt trying to do everything the workflow needs.

**Better:** `extract_hook` → `classify_hook_type` → `evaluate_hook_quality` (three composable prompts)

**How to invoke:** "Can this be broken into smaller prompts that chain together?"

---

### 11. Separation of Concerns

**In software:** Different concerns should be handled by different modules.

**In prompts:**
- Extraction prompts extract (what exists)
- Evaluation prompts evaluate (quality assessment)
- Generation prompts generate (new content)
- Transformation prompts transform (format conversion)

**How to invoke:** "What concern does this prompt address? Is it mixing concerns?"

---

### 12. Interface Segregation

**In software:** Many specific interfaces are better than one general-purpose interface.

**In prompts:**
- Output schemas should be focused, not monolithic
- Downstream prompts should only receive the data they need
- Don't pass the entire workflow context when a subset suffices

**How to invoke:** "Does this prompt need ALL this context, or just a subset?"

---

### 13. Loose Coupling

**In software:** Modules should have minimal dependencies on each other.

**In prompts:**
- Prompts should be runnable independently where possible
- Avoid deep chains where failure cascades
- Design for parallel execution when prompts don't depend on each other

**How to invoke:** "Can this prompt run without waiting for X? Can we parallelize?"

---

### 14. Fail Fast

**In software:** Detect and report errors as early as possible.

**In prompts:**
- Validate inputs early in the chain
- Use predicate prompts to check preconditions
- Don't let bad data propagate through expensive operations

**How to invoke:** "What could go wrong? Can we detect it earlier in the chain?"

---

## YouTube Launch Optimizer Context

### Why This Section Exists

The initial Sections 1-2 process transcripts for launch optimization (titles, descriptions, chapters). Section 10 was created because:

1. **Different purpose**: Understanding video structure for repurposing, not launch optimization
2. **Independent execution**: Can run without titles/descriptions
3. **Emergent need**: Intro/outro analysis grew more sophisticated than 1-6's basic extraction

### Relationship to Other Sections

| Section | Purpose | Depends On |
|---------|---------|------------|
| 1 | Initial transcript processing | Raw transcript |
| 2 | Chapter identification | Processed transcript |
| 10 | Structural segmentation | Raw transcript (independent) |

Section 10 could inform:
- **Section 6 (Description)**: Use intro hook in description
- **Section 7 (Social)**: Use breakouts for short-form content
- **Shorts workflow**: Identify breakout candidates

---

## Research Performed

### Data Sources Analyzed

1. **b75-vibe-code-whisper-ai-opus-4.5**: Segmented transcripts with clear naming
2. **b71-bmad-poem**: Multiple intro takes
3. **b64-bmad-claude-sdk**: Full final transcript (1,215 lines)
4. **a71, a98**: Archived full transcripts with intro/outro patterns

### Patterns Discovered

**Intro patterns:**
- Hook types: imagination, story, direct, excitement
- Consistent sign-off: "I'm AppyDave. Let's get into it."
- Optional: series context, chapter mentions, demo preview

**Outro patterns:**
- RECAP segment (what was covered)
- ENDCARD segment (teaser, CTAs, sign-off)
- Consistent sign-off: "I'm AppyDave. See you in the next video."

**Breakout patterns:**
- Problem-solving tangents (new conversation opened)
- On-the-fly creations (SAT agent)
- Second brain consultations
- Retrospectives/postmortems

---

## Open Questions

1. Should breakout detection include a "shorts candidate" flag with duration estimate?
2. Should we store intro/outro alongside workflow-data.json or separately?
3. How do these segments feed into the thumbnail/title workflow?

---

## Q&A Session Learnings (2025-12-03)

### Confirmed Prompt Gap

**Demo Preview in Intro but not Breakouts**: The intro extraction captured a demo preview segment, but the breakout prompt did not. This is a gap - demos ARE a form of breakout with high standalone/repurposing value.

**Action needed**: Update 10-4-extract-breakout.hbs to explicitly include "demo" as a breakout type to catch.

### Predicate vs Extract Pattern

**Insight from Q&A**: Some checks work better as boolean predicates than extraction items.

**Example**: "Check chapter links in description" was classified as a CTA. But it's really navigation guidance. A better approach might be:
- Boolean flag: `hasChapterMention: true` on intro extract
- Predicate prompt: "Does video have monetizable CTA?" (yes/no)

**Transferable principle**: Not everything needs full extraction. Simple presence checks can be predicates.

### Improvement Suggestion Pattern

**Insight from Q&A**: When analysis finds "standard" or "common" patterns (like "See you in the next video"), a good prompt engineering agent might ask:

> "Do you want suggestions for more effective [sign-off/hook/CTA] patterns?"

This is a potential Paige capability: After analysis, offer improvement options for items rated as "standard" rather than "strong".

---

## Version History

- **v1 (2025-12-03)**: Initial creation based on transcript analysis research
