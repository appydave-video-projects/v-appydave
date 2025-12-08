# Section 1, Step 5: Abridge QA

## Prompt Templates

**Files**:
- `/Users/davidcruwys/dev/ad/poem-os/poem/data/youtube-launch-optimizer/prompts/1-5-abridge-qa-v1.hbs` (Generic)
- `/Users/davidcruwys/dev/ad/poem-os/poem/data/youtube-launch-optimizer/prompts/1-5-abridge-qa-v2.hbs` (Structured)

**Synopsis**: Quality assurance step that compares the abridgement against the original transcript to identify discrepancies, omissions, or inaccuracies.

---

## Inputs Used

| Input | Source |
|-------|--------|
| `transcript` | Original transcript (~12,000 words) |
| `transcriptAbridgement_v1` | V1 abridgement (~500 words) |
| `transcriptAbridgement_v2` | V2 abridgement (~2,000 words) |

---

## Outputs

### QA V1 → Abridgement V1

**Value**: See `workflow-data.json` → `transcriptAbridgementQA_v1`

**Findings**: 12 missing key points identified, tone/intent changes, oversimplifications. ~35-40% information loss.

### QA V2 → Abridgement V2

**Value**: See `workflow-data.json` → `transcriptAbridgementQA_v2`

**Findings**: All categories checked (Named Entities, Numbered Items, Technical Terms, Problems & Solutions, Demonstrations, Chronological Flow, Quantitative Details). ~90-95% preservation. No critical gaps.

---

## Paige's Observations (Prompt Engineer Review)

### Output Quality Assessment

| QA Run | Abridgement | Result | Notes |
|--------|-------------|--------|-------|
| V1 QA | V1 Abridge | ⚠️ Many gaps | 12+ discrepancies, ~35-40% loss |
| V2 QA | V2 Abridge | ✅ Near-complete | All categories pass, ~90-95% preserved |

### Comparative Analysis

| Metric | V1 QA | V2 QA |
|--------|-------|-------|
| **Structure** | Unstructured list | 7 categories with Present/Missing/Altered |
| **Actionability** | Vague ("missing key points") | Specific ("Story 2.4 couldn't discover files → added list and preview tools") |
| **Verdict format** | Paragraph | Preservation estimate + Critical gaps + Recommendations |

### The Alignment Principle

**V1 prompt → V1 abridgement → V1 QA**: All generic, all lossy. QA catches issues but vaguely.

**V2 prompt → V2 abridgement → V2 QA**: All structured, all near-lossless. QA validates systematically by category.

**Insight**: The QA prompt should match the abridgement prompt's philosophy. V2 QA checks the same MUST categories that V2 abridge was supposed to preserve.

---

## Pattern Analysis

| Pattern | Applies? | Notes |
|---------|----------|-------|
| **Quality Gate** | ✅ Yes | This IS the quality gate for abridgement |
| **Sequential Refinement** | ✅ Yes | QA could trigger re-run of abridge with specific fixes |
| **Parallel Execution** | ❌ No | QA must run AFTER abridge completes |
| **Structured Output** | ✅ Yes (V2) | Categories make it easy to identify specific gaps |

---

## Recommendations

1. **V2 QA should be default** - Structured categories align with V2 abridge's MUST/MAY philosophy

2. **Actionable output** - V2 QA's "Recommendations" section enables targeted fixes

3. **Threshold decision** - Could set a "90% preservation" threshold as pass/fail gate

---

## Questions for User

1. Does the V2 QA output format give you what you need to validate abridgement quality?

2. Should QA failures trigger automatic re-run of abridge, or human review first?

3. Is 90-95% preservation acceptable, or should we aim for 98%+?
