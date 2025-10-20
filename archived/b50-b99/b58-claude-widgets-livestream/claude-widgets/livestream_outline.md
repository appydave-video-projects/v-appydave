# Livestream Outline: Teaching Claude Artifacts by Doing

## 1. Kickoff: Big Picture to Widget (5 Bullet Plan)
Start with energy and immediacy—go from explanation to execution fast:

- Introduce Claude Artifacts and the concept of "acts" — small, shareable Claude-powered apps
- Explain the magic of `window.claude.complete()` (aka "Claudeception")
- Mention zero-cost deployment for creators (viewer pays for AI usage)
- Share the plan: "Let’s build a real app together—right now"
- Live demo: Start with a fun, 5-minute interactive app (e.g., Markdown Previewer or Task List)

## 2. Define Two Personas to Model Development
Use these personas throughout to reinforce good habits.

**Persona 1: The Requirement Writer**
- Thinks like a product manager
- Writes small, clear prompts with examples and edge cases
- Focuses on UX, animations, and user journey

**Persona 2: The Developer (Claude)**
- Translates requirements into Claude-compatible code
- Uses LocalStorage, animation libraries, and browser-only logic
- Manages runtime bugs, Claude token limits, and prompt packaging

## 3. Walk Through Application Categories
Pull from the main guide and show a few for inspiration:

- Productivity Tools (e.g., Budget Tracker, To-Do List)
- Data Dashboards (e.g., CSV Explorer)
- Games & Fun (e.g., Snake, AI Dungeon)
- Educational Aids (e.g., Flashcards, AI Tutor)
- Developer Utilities (e.g., JSON Formatter)
- Livestream Widgets (e.g., Countdown, Q&A Display)

Use this moment to let viewers vote or suggest what to build.

## 4. Build Multiple Example Applications
Rapid-fire walkthroughs of real builds:

- App 1: Claude-powered Chatbot (track message history manually)
- App 2: Budget Tracker w/ Chart.js (data viz + LocalStorage)
- App 3: Language Flashcards (AI-generated vocab via `window.claude.complete()`)

For each:
- Define scope in 2–3 sentences
- Write the prompt
- Deploy and test

## 5. Polish & Production Value Round
Take one or two artifacts and improve them:

- Add Tailwind CSS for visual polish
- Add anime.js or confetti effects
- Improve prompt packaging for Claude
- Add chroma key support for OBS use

Wrap with links to templates and encourage remixing or deployment.

---

## Optional Additions
- Show common debugging pattern: copying errors back to Claude
- Share a Claude prompt template pack
- Provide a URL to deployed examples viewers can test live

