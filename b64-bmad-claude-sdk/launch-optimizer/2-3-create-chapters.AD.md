# Create Chapters - AppyDave Video Notes

## Key Talking Points (when showing the wall of text)

### 1. The Manual Verification Problem
"Timestamp matching is the longest part of my process. Two-hour videos are brutal. The prompt found 44% of timestamps - that's a starting point, not an answer. Every timestamp needs manual verification."

### 2. First Match ≠ Right Match
"The phrase 'React application as the front end' appears twice - once when describing the epic, once when building it. The prompt found the first one. Wrong context. Same words, different meaning, different timestamp."

### 3. Reference Text Quality Matters
"Chapters with verbatim transcript quotes found their timestamps. Chapters with paraphrased summaries failed. If you need exact matching downstream, preserve exact text upstream."

### 4. The Future: Anchor Text at Recording Time
"Here's the real solution. When I record, I already know when a chapter starts - I press a button. If I capture the first sentence of each chapter at that moment, I have ground truth. Then matching is trivial - search for that exact opening line in the final SRT. 44% becomes 95%."

---

## Image Prompts for Jan

### Image 1: The 44% Problem

**Diagram Title**: TIMESTAMP MATCHING REALITY

**Content to Draw**:
- Pie chart showing 44% "Found" and 56% "Estimated"
- Arrow pointing to "Found" section with checkmark
- Arrow pointing to "Estimated" section with question mark
- Below: Person manually checking timestamps
- Action burst: "VERIFY!"

**Bottom Caption**: Less than half verified means every timestamp needs manual checking.

---

### Image 2: First Match Trap

**Diagram Title**: SAME PHRASE, WRONG TIMESTAMP

**Content to Draw**:
- Timeline showing video from 0:00 to 2:00:00
- Phrase "React application" appears at two points:
  - 31:01 (describing epic) - marked with X
  - 1:45:00 (building epic) - marked with checkmark
- Arrow showing search finding first match (wrong one)
- Action burst: "CONTEXT!"

**Bottom Caption**: The first match isn't always the right match. Context matters.

---

### Image 3: Upstream Determines Downstream

**Diagram Title**: VERBATIM TEXT ENABLES MATCHING

**Content to Draw**:
- Two paths:
  - Top: "Exact quote" → Search → "Found at 53:37" (checkmark)
  - Bottom: "Paraphrased summary" → Search → "Not found" (X)
- Action burst: "PRESERVE!"

**Bottom Caption**: If downstream needs exact matching, upstream must preserve exact text.

---

### Image 4: Anchor Text Strategy

**Diagram Title**: CAPTURE GROUND TRUTH AT RECORDING

**Content to Draw**:
- Left: Recording button being pressed, "Chapter 7 starts"
- Middle: Whisper transcribes → "Now we're going to use the analyst agent..."
- Right: Store as anchor text
- Below: Final SRT → Search for anchor → "Found at 41:37"
- Action burst: "GROUND TRUTH!"

**Bottom Caption**: Capture the first sentence when recording. Match against final SRT. 95% accuracy.
