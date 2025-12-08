# Refine Chapters - AppyDave Video Notes

## Key Talking Points (when showing the wall of text)

### 1. Data Loss Anti-Pattern
"V1 prompt took 16 chapters with quotes and produced 34 titles - but lost the quotes. That's a Data Loss Anti-Pattern. Refinement should add value, not drop context. V2 preserves the reference text because we need it for timestamp matching."

### 2. Platform-Specific Constraints
"I originally said 'SEO-friendly' titles. Wrong framing. YouTube chapters have a 49-character hover cutoff. That's not SEO - that's platform-specific. The prompt needs to encode the real constraint, not a generic goal."

### 3. Anchors vs Authorities
"Folder names are anchors, not authorities. They tell me where chapters are and roughly what they're called. But the AI still needs the transcript to understand what's actually said. Anchors guide - they don't dictate."

---

## Image Prompts for Jan

### Image 1: Data Loss Anti-Pattern

**Diagram Title**: REFINEMENT SHOULD ADD, NOT DROP

**Content to Draw**:
- Left: Input with "Title + Quote" (complete)
- Middle: V1 Prompt processing
- Right: Output with "Title only" (quote missing, crossed out)
- Below: V2 path showing "Title + Quote" preserved through
- Action burst: "PRESERVE!"

**Bottom Caption**: Refinement adds value. It shouldn't lose upstream context.

---

### Image 2: The 49-Character Rule

**Diagram Title**: YOUTUBE CHAPTER CONSTRAINTS

**Content to Draw**:
- YouTube chapter hover preview mockup
- Title getting cut off at 49 characters with "..."
- Two examples: Short title (fits) vs Long title (truncated)
- Action burst: "49 CHARS!"

**Bottom Caption**: Not "SEO-friendly" - YouTube has specific limits. Encode the real constraint.

---

### Image 3: Anchors vs Authorities

**Diagram Title**: FOLDER NAMES ARE ANCHORS

**Content to Draw**:
- Left column "ANCHORS": Folder names with labels "Boundaries", "Hints", "Order"
- Right column "AUTHORITIES": Would dictate final output (crossed out)
- Center: AI + Transcript → Final Title
- Arrow showing folders GUIDE the AI, not dictate
- Action burst: "GUIDE!"

**Bottom Caption**: Anchors guide the AI. The transcript provides the truth.
