# 5-1 Generate Title - Video Notes

## What Happened

Ran title generation with two prompt versions:
- **V1**: Basic prompt with generic guidance
- **V2**: Research-informed prompt using Jake Thomas "Three Emotions" framework

## V1 vs V2 Results

V1 averaged 57 characters (too long for mobile). V2 averaged 47 characters with 9/10 in the optimal 40-50 range.

V2 added structured output with emotion tags (curiosity/desire/fear) and character counts as numbers, not strings.

## Research Applied

Looked up YouTube title best practices. Found:
- 40-50 chars optimal for CTR
- 70 chars max for SEO
- Front-load keywords (mobile truncation)
- Jake Thomas framework: Curiosity, Desire, Fear emotions

## Key Discussion Points

### Multiple Frameworks
Jake Thomas is one framework. Future: support multiple frameworks as options.

### Parallel Generation
Instead of 1 prompt → 10 titles, run 10-12 prompts with different focuses:
- Curiosity-only
- Desire-only
- Fear-only
- Number hooks
- Question format
- David's custom angles

### Ranking Agent
Need a consolidation step to:
- Take all candidates from parallel runs
- Rank by David's criteria
- Output top 3 for A/B testing

### BMAD vs Claude Agent SDK
Both matter but serve different roles:
- BMAD = what they'll learn (methodology)
- Claude Agent SDK = what they'll build (application)

Note: "Claude Agent SDK" not "Claude SDK" - different concept. BUT title can just say "Agent SDK" - "Claude" can go on thumbnail.

### Variety Through Hook Types
First attempt was too strict - forced both keywords in every title. Better approach: categorize by "hook type":

| Hook Type | What's in Title | What's on Thumbnail |
|-----------|-----------------|---------------------|
| bmad+sdk | Both keywords | Reinforcing phrase |
| bmad-only | BMAD | Agent SDK / Claude |
| sdk-only | Agent SDK | BMAD Method |
| concept | Neither (self-editing, vibe coding) | Both keywords |
| number-hook | Stats (7 agents, 200 lines) | One keyword |

This gives variety AND implicit thumbnail guidance.

### Title/Thumbnail/Text Coordination
These three elements should work together:
- Title handles one keyword
- Thumbnail text handles another
- Image reinforces visually

Future insight: Each hook type implies what goes on thumbnail. A future system could output title + thumbnail text + image concept as coordinated package.

This is its own project - not just a prompt.

### A/B Testing
YouTube now/soon allows 3 titles for A/B testing. Changes output requirements from "pick 1" to "pick 3 with rationale".

## Output Stored

- `generate_title_v1`: Array of 10 strings (both BMAD + Agent SDK in most)
- `generate_title_v2`: Array of 10 objects `{category, emotion, chars, title}`
  - `category`: hook type (bmad+sdk, bmad-only, sdk-only, concept, number-hook)
  - `emotion`: curiosity/desire/fear
  - `chars`: character count
  - `title`: the title text

## Tips for Paige

1. **Parallel Prompt Execution**: Same task, different variable inputs, merge results
2. **Ranking as Distinct Step**: Generation ≠ selection; separate prompts
3. **Cross-Asset Coordination**: Title + thumbnail + text work together
4. **Framework Library**: Build collection of frameworks, select per-run
