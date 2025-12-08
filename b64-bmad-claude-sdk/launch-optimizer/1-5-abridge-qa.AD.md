# Abridge QA - AppyDave Video Notes

## Key Talking Points (when showing the wall of text)

### 1. QA Exposed the Problem
"V1 QA found 12 issues with V1 abridgement. But that's not a win for QA - it's a failure of the upstream prompt. If QA is constantly catching problems, you're fixing the wrong thing."

### 2. Invest Upstream, Not Downstream
"Here's the prompt engineering insight: don't build better QA to catch bad output. Build better prompts that produce good output. V2 abridge is well-designed, so V2 QA just says 'yep, looks good.'"

### 3. QA Becomes Optional
"Once your upstream prompt is solid, QA shifts from critical gate to safety net. Run it occasionally. Run it when the prompt changes. But don't rely on it to fix design problems."

---

## Image Prompts for Jan

### Image 1: Wrong vs Right Approach

**Diagram Title**: WHERE TO INVEST PROMPT ENGINEERING

**Content to Draw**:
- Top path (crossed out, red): "BAD PROMPT" → "BAD OUTPUT" → "QA CATCHES 12 ISSUES" → "FIX OUTPUT?" (labeled "WRONG")
- Bottom path (highlighted, green): "GOOD PROMPT" → "GOOD OUTPUT" → "QA CONFIRMS" (labeled "RIGHT")
- Action bursts: "UPSTREAM!" "NOT DOWNSTREAM!"

**Bottom Caption**: Fix the prompt, not the output. Invest upstream.

---

### Image 2: QA Role Shift

**Diagram Title**: QA: FROM GATE TO SAFETY NET

**Content to Draw**:
- Left side (before): Heavy gate/barrier labeled "QA" with warning signs, "MUST PASS", catching lots of bugs
- Right side (after): Light net labeled "QA" as optional safety net, few/no bugs to catch
- Arrow between them labeled "IMPROVE UPSTREAM PROMPT"
- Action burst: "SHIFT!"

**Bottom Caption**: Good design makes QA a formality, not a necessity.

---

### Image 3: The V1 vs V2 Story

**Diagram Title**: WHAT QA RESULTS REALLY MEAN

**Content to Draw**:
- Two columns
- Left: "V1" with sad face, "12 ISSUES FOUND" → Arrow pointing to "PROMPT NEEDS WORK" (not "QA SAVED US")
- Right: "V2" with happy face, "ALL CLEAR" → Arrow pointing to "PROMPT IS SOLID"
- Action bursts: "DIAGNOSE!" "DON'T CELEBRATE!"

**Bottom Caption**: QA catching issues = upstream failure, not QA success.
