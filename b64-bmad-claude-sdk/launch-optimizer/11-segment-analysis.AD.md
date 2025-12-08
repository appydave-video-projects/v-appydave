# Section 11: Segment Analysis - Video Notes

## What Happened

Created analysis prompts that classify and evaluate the extractions from Section 10. Two-phase architecture: extract first, analyze second.

### Final Workflow
1. **11-1**: Analyze intro segments (hook strength, promise clarity)
2. **11-2**: Analyze outro segments (recap completeness, teaser curiosity)
3. **11-3**: Analyze CTAs (type, directness, naturalness)
4. **11-4**: Analyze breakouts (standalone value, repurposing potential)

---

## Key Discoveries

### 1. Extract vs Analyze is Two-Phase Design

Separation benefits:
- Extraction validated independently
- Analysis can evolve without re-extracting
- Different analyses can run on same extraction
- Easier to debug which phase has issues

### 2. Classification Vocabularies Must Be Explicit

Defined taxonomies in each prompt:
- `hookType`: imagination | story | direct | excitement
- `ctaType`: subscribe | community | video | repository | product
- `breakoutType`: demo | problem-solving | creation | retrospective

**Anti-pattern:** Open-ended "describe the type" produces inconsistent outputs.

### 3. Quality Scales Should Be Actionable

Used 3-point scales where each level suggests action:
- **high/strong**: Keep as-is
- **medium/moderate**: Consider improvements
- **low/weak**: Needs rework

5-point scales have ambiguous middle values.

### 4. "Standard" Ratings Are Opportunities

When analysis returns "standard" or "moderate", a good agent offers:

> "The sign-off was rated 'standard'. Want suggestions for more memorable alternatives?"

---

## Q&A Session Learnings

Validated 16 items across all 4 categories. Key findings:

### Confirmed Working Well
- Hook detection (strong imagination hook)
- Promise clarity (clear, specific)
- Brand consistency (sign-offs match)
- Breakout standalone value assessment

### Identified Gaps
- Demo preview not caught by breakout prompt
- Chapter links ambiguous (CTA vs navigation guidance)
- Some checks better as predicates than full extraction

### Pattern Discovery
- All CTAs rated "soft" except outro ("direct") - intentional style
- Comprehensive recap that callbacks to intro promise

---

## Output Fields

| Prompt | Output Field | Key Classifications |
|--------|--------------|---------------------|
| 11-1 | `videoIntroAnalysis` | hookType, strength, clarity |
| 11-2 | `videoOutroAnalysis` | completeness, curiosityLevel |
| 11-3 | `videoCtaAnalysis` | ctaType, directness, naturalness |
| 11-4 | `videoBreakoutAnalysis` | standaloneValue, potentialFormats |

---

## New Tips for Paige

1. **#21 Two-Phase Design**: Extract vs Analyze as separate prompts
2. **#22 Explicit Vocabularies**: Define classification options in prompt
3. **#23 Actionable Scales**: 3-point scales with clear actions per level
4. **#24 Surface Insights**: Analysis should answer "so what?"
5. **#25 Q&A Validation**: Validate prompts through structured Q&A
6. **#26 Improvement Opportunities**: "Standard" ratings trigger suggestions
7. **#27 Predicate Pattern**: Some checks are yes/no, not full extraction

---

## Files Created

### Prompts
- `11-1-analyze-intro.hbs`
- `11-2-analyze-outro.hbs`
- `11-3-analyze-cta.hbs`
- `11-4-analyze-breakout.hbs`

### Documentation
- `11-segment-analysis.md` - Full analysis document
- Updated `tips-for-paige.md` with tips #18-27

---

## Quotable Moments

> "Extract vs Analyze is two-phase design. Validate each phase independently."

> "Classification vocabularies should be explicit. Open-ended 'describe the type' produces inconsistent outputs."

> "Don't just report 'standard' - offer to improve."

> "Q&A validates both extraction AND analysis prompts."
