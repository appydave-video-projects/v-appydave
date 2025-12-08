# Content Analysis - AppyDave Video Notes

## Key Talking Points (when showing the wall of text)

### 1. Query Layer Positioning
"Section 4 extracts 12 data points from the transcript - mainTopic, keywords, statistics, audience insights. But it runs too late. These only need transcript as input. Move them earlier, right after abridgement, and suddenly every downstream prompt - titles, descriptions, social posts - has this intelligence available."

### 2. Predicate Prompt Principle
"Complex prompts have more ways to fail. If cost wasn't a factor, I'd do one prompt per metric. Simple prompts don't mess up. You also get precise control over data shape - CSV, key-value, JSON. When you bundle four extractions into one prompt, you lose that control."

### 3. The Redundancy Problem
"Keywords and search terms - same data, different names. Key takeaways and unique selling points - 80% overlap. This happens when you don't think about categorization upfront. Before asking for keywords, decide: YouTube tags? Description keywords? Twitter hashtags? Different purposes, different outputs."

### 4. Paige as Devil's Advocate
"Here's where the prompt engineer earns her money. You're writing a title prompt and Paige says 'It would be nice if we had audience segment data.' You ask where that comes from. She says 'We could extract that in the query layer.' That's the value - seeing missing inputs and suggesting where to extract them."

---

## Image Prompts for Jan

### Image 1: Query Layer Positioning

**Diagram Title**: MOVE EXTRACTION EARLIER

**Content to Draw**:
- Two workflow diagrams, top and bottom
- Top (Current): Transcript → Titles → Chapters → [gap] → Query → YouTube Title
- Bottom (Better): Transcript → Query → Titles → Chapters → YouTube Title
- Arrow showing query outputs flowing into multiple downstream boxes
- Action burst: "AVAILABLE EVERYWHERE!"

**Bottom Caption**: Query layer only needs transcript. Run it early, feed everything downstream.

---

### Image 2: Predicate Prompt Principle

**Diagram Title**: ONE PROMPT, ONE JOB

**Content to Draw**:
- Left side: Complex prompt (multiple paths, decision trees) with X marks showing failure points
- Right side: Four simple prompts, each with single arrow, checkmarks
- Labels: "mainTopic", "keywords", "statistics", "takeaways"
- Action burst: "DON'T MESS UP!"

**Bottom Caption**: Complex prompts have more failure paths. Simple prompts = reliable outputs.

---

### Image 3: Categorization Before Extraction

**Diagram Title**: DECIDE PURPOSE FIRST

**Content to Draw**:
- Top: Generic "keywords" box with question mark
- Below: Fork into four categories with platform icons:
  - YouTube tags (tag icon)
  - Description top 3 (document icon)
  - Twitter hashtags (Twitter/X icon)
  - LinkedIn terms (LinkedIn icon)
- Each category has different output format
- Action burst: "WHAT'S IT FOR?"

**Bottom Caption**: Before extracting keywords, decide the platform. Different purposes need different outputs.

---

### Image 4: Devil's Advocate Pattern

**Diagram Title**: PAIGE SPOTS MISSING INPUTS

**Content to Draw**:
- Scene: Working on "Title Prompt" (shown as document)
- Paige character saying: "This would work better with audience data"
- Arrow pointing back to Query Layer
- New extraction prompt being added
- Result: Title prompt now has audience input connected
- Action burst: "SUGGEST!"

**Bottom Caption**: Prompt engineer value: seeing missing inputs, suggesting where to extract them.

---

### Image 5: Human-in-the-Loop Curation

**Diagram Title**: EXTRACT → REVIEW → CURATE

**Content to Draw**:
- Three-stage flow:
  1. AI extracts list (robot icon, long list)
  2. Human reviews (eye icon, scanning)
  3. Curated output (shorter list with checkmarks, some items crossed out)
- Not fully automated pipeline
- Action burst: "REFINE!"

**Bottom Caption**: AI extracts everything. Human removes noise, highlights value. Guided refinement.
