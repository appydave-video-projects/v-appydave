# Prompt structures

This is a breakdown of the elements and patterns in prompts for prompt engineering.

[ChatGPT](https://chat.openai.com/c/d9a1fe6f-d9d5-4119-b622-2cc1a2cc6ef7)

## Prompt elements

- **Context:** Sets stage for AI interaction.
- **Task:** Directs specific AI action.
- **Placeholder with Label:** For variable data input.
- **Key Prompt:** Initiates AI role-play.
- **Select Niche:** Focuses AI's domain expertise.
- **Give It Brains:** Equips AI with knowledge.
- **How Many Answers:** Specifies response quantity.
- **Size of Answer:** Desired response length.
- **Format:** Structures output as JSON/Mark
- **Conditions:** Sets rules to prevent AI hallucinations.
- **Question:** Asks for specific information or clarification.
- **Example:** Provides a concrete case or illustration.
- **Socratic Questioning:** Probes deeply through layered, critical questions.
- **Reasoning Path/Chain of Thought:** Demands sequential, logical reasoning from AI.
- **Tone and Style:** Specifies desired writing style or tone.
- **Specificity and Clarity:** Ensures clear, precise outcome expectations.

```json
[
  {
    "label": "Context",
    "description": "Sets stage for AI interaction."
  },
  {
    "label": "Task",
    "description": "Directs specific AI action."
  },
  {
    "label": "Labeled Placeholder",
    "description": "For variable data input."
  },
  {
    "label": "Key Prompt",
    "description": "Initiates AI role-play."
  },
  {
    "label": "Select Niche",
    "description": "Focuses AI's domain expertise."
  },
  {
    "label": "Give it Brains",
    "description": "Equips AI with knowledge."
  },
  {
    "label": "How many answers",
    "description": "Specifies response quantity."
  },
  {
    "label": "Size of answer",
    "description": "Desired response length."
  },
  {
    "label": "Format",
    "description": "Structures output as JSON/Markdown/CSV."
  },
  {
    "label": "Conditions",
    "description": "Sets rules to prevent AI hallucinations."
  },
  {
    "label": "Question",
    "description": "Asks for specific information or clarification."
  },
  {
    "label": "Example",
    "description": "Provides a concrete case or illustration."
  },
  {
    "label": "Socratic Questioning",
    "description": "Probes deeply through layered, critical questions."
  },
  {
    "label": "Reasoning Path",
    "description": "Demands sequential, logical reasoning from AI.",
    "aka": "Chain of Thought"
  },
  {
    "label": "Tone and Style",
    "description": "Specifies desired writing style or tone."
  },
  {
    "label": "Specificity and Clarity",
    "description": "Ensures clear, precise outcome expectations."
  }
]
```