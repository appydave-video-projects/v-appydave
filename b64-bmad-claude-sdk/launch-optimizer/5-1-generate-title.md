# 5-1 Generate Title - Analysis

## Prompt Versions

### V1: Basic Prompt
- **Input**: `short_title`, `video_topic_theme`, `content_highlights`
- **Output**: Array of 10 title strings
- **Guidance**: Generic ("under 70 chars", "use action verbs", "avoid clickbait")

### V2: Research-Informed Prompt
- **Input**: `shortTitle`, `analyzeContentEssence.mainTopic`, `analyzeContentEssence.statistics`, `analyzeCtaCompetitors.catchyPhrases`, `analyzeAudienceEngagement.audienceInsights`, `titleIdeas`
- **Output**: Array of objects `{emotion, chars, title}`
- **Framework**: Jake Thomas "Three Emotions" (Curiosity, Desire, Fear)
- **Character targets**: 40-50 optimal CTR, 70 max SEO, 50 mobile-safe

## Output Comparison

| Metric | V1 | V2 |
|--------|----|----|
| Avg char count | 57 | 47 |
| In optimal range (40-50) | 0/10 | 9/10 |
| Mobile-safe | 0/10 | 9/10 |
| Front-loaded hooks | Weak | Strong |
| Emotion tagged | No | Yes |
| Structured output | No | Yes |

## Key Findings

### 1. Research Before Design Validated
V2 performed better because we researched YouTube title psychology (Jake Thomas framework) before designing the prompt. Generic guidance in V1 produced generic results.

### 2. Input Richness Matters
V2 accessed 6 inputs vs V1's 3. More context from Section 4 (analyzeContentEssence, analyzeAudienceEngagement, analyzeCtaCompetitors) produced better titles.

### 3. Structured Output Enables Downstream Processing
V2's object format `{emotion, chars, title}` is queryable and sortable. V1's flat strings require parsing.

### 4. Dot Notation Works
Using `analyzeContentEssence.mainTopic` to access nested Section 4 data worked well in Handlebars.

## Missing Input Identified

Neither prompt used `analyzeAudienceEngagement.emotionalTriggers` - could improve emotion targeting.

## Future Architecture Insights

### Framework Pluralism
Jake Thomas is one framework among many. System should support multiple frameworks (VidIQ, TubeBuddy, Brian Dean, etc.) as selectable options.

### Parallel Generation Strategy
Instead of one prompt generating 10 titles, run multiple specialized prompts:

| Prompt Variant | Focus |
|----------------|-------|
| Jake Thomas - Curiosity only | Gap-opening titles |
| Jake Thomas - Desire only | Achievement/gain titles |
| Jake Thomas - Fear only | FOMO/mistake-avoidance |
| Number-hook focused | "7 Agents", "200 Lines" |
| Question format | "What if...?", "How do...?" |
| David's custom angles | Specific ideas to test |

Could be 10-12 parallel runs with different variable inputs.

### Consolidation/Ranking Agent
After parallel generation, need a ranking prompt that:
- Takes all candidate titles
- Applies David's selection criteria
- Outputs top 3 with reasoning
- Considers A/B testing requirements

### Keyword Responsibility Distribution

**Critical insight**: BMAD ≠ Claude Agent SDK

| Keyword | Role |
|---------|------|
| BMAD | What they'll learn (methodology) |
| Claude Agent SDK | What they'll build (application) |

**Note**: "Claude Agent SDK" not "Claude SDK" - different concepts.

This creates a delegation problem across:
- **Title** (limited chars)
- **Thumbnail image**
- **Thumbnail text overlay**

Example strategy:
- Title: "Build Self-Editing Apps with BMAD"
- Thumbnail text: "Claude Agent SDK"
- Thumbnail image: Claude logo/mascot

### Title/Thumbnail/Text as Unified Project
This is its own full project - not just a prompt but a coordinated system:
- Title generation
- Thumbnail concept generation
- Text overlay generation
- Cross-element keyword balancing
- Visual + text harmony

### A/B Testing Changes Output Requirements
- Previously: Generate many, pick 1
- Now/Soon: Generate many, pick **3** for A/B testing
- Output format needs "Top 3 with rationale"

## Prompt Improvements for V3

1. Add `emotionalTriggers` from analyzeAudienceEngagement
2. Allow framework selection parameter
3. Add David's custom angle input
4. Support single-emotion mode for parallel runs
5. Output includes A/B testing rationale

---

## Future Insight: Title-Thumbnail Coordination

### The "Hook Type" Concept

V2 introduced a `category` field to track what strategy each title uses. Better name might be `hook_type` or `keyword_strategy` since "category" is too generic.

Current hook types identified:
- `bmad+sdk` - Both keywords in title
- `bmad-only` - BMAD in title, SDK deferred to thumbnail
- `sdk-only` - SDK in title, BMAD deferred to thumbnail
- `concept` - Neither keyword, pure hook (self-editing, vibe coding)
- `number-hook` - Statistical hook (7 agents, 200 lines)

### Implicit Thumbnail Guidance

Each hook type implies what should go on the thumbnail:

| Hook Type | Title Has | Thumbnail Text Should Have | Thumbnail Image |
|-----------|-----------|---------------------------|-----------------|
| bmad+sdk | Both | Reinforcing phrase | Concept visual |
| bmad-only | BMAD | "Agent SDK" or "Claude" | Claude logo? |
| sdk-only | Agent SDK | "BMAD Method" | Workflow visual? |
| concept | Neither | Both keywords or key stat | Demo screenshot |
| number-hook | Stats | One keyword | Before/after? |

### Why This Matters (Future System)

A title generation system could output not just titles, but **title + thumbnail text + image concept** as a coordinated package. Each title would come with guidance for the other assets.

**Not implementing now** - this is a full title/thumbnail system refactor. Documenting for Paige's future work.
