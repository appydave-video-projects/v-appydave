Foundational Guide for a Livestream on Claude Artifacts

This document provides a detailed foundation for our livestream, focusing on the practical creation of interactive applications ("acts") using Claude Artifacts and Claude Code. It integrates all key technical details from our research, focusing exclusively on currently supported features.

Core Principles for the Livestream

- **Small, Focused Requirements**: We will define small-scope applications. The effectiveness of Claude's artifact generation is highest when requirements are concise and clear. This also helps stay within model token limits (e.g., Sonnet 3.5's ~8192 output token limit).

- **Design and UX First**: Functionality is key, but we will prioritize creating applications that are beautiful, intuitive, and provide a simple, elegant user experience. We can explicitly ask Claude to use animation libraries like anime.js or CSS frameworks like Tailwind CSS, ensuring they are loaded from the whitelisted cdnjs.com.

- **Current Capabilities Only**: The concepts below are built on the existing Claude Artifacts sandbox. This means:
  - No external API calls: We cannot use fetch() to call third-party services.
  - Client-side focus: All code runs in the user's browser. There is no custom backend.
  - Simulated Interactions & "Claudeception": To create dynamic, AI-powered apps, we will heavily utilize window.claude.complete(). This is the one "API call" artifacts can make—calling back to Claude itself. We can instruct Claude to respond with structured JSON, a pattern sometimes called "Claudeception," allowing our front-end code to easily parse and use the AI-generated data.
  - Leveraging Browser Features: We will make use of browser-based technologies that the sandbox supports, such as LocalStorage, the HTML5 File API, and the <canvas> element.

Key Development & Deployment Concepts

- **Hosting, Sharing, and Cost**: Artifacts are deployed with one click and hosted by Anthropic on a claude.site domain. When you share the URL, anyone can use the app. If the app uses window.claude.complete, any AI usage costs are billed to the viewer's Claude account, not the creator's. This makes it free to distribute your AI-powered creations.

- **The Debugging Loop**: Claude often uses an internal "Analysis Tool" to test code and catch bugs before generating the final artifact. However, once deployed, Claude cannot see runtime errors. If the app breaks, you must copy the error message from your browser's developer console and paste it back into the prompt for Claude to fix it.

- **Managing AI Conversation State**: The window.claude.complete function is stateless. To create a continuous conversation (e.g., for a chatbot), your JavaScript code must manually collect the chat history and include it in the prompt for each new turn.

- **Media Generation vs. Display**: Artifacts cannot generate media like images, audio, or video through the Claude API. They can only display media that is uploaded by the user or included in the artifact code. All Claude responses must be text only.

Categories of Claude-Powered Applications ("Acts")

1. **Productivity & Organization Tools**
   - **How they work**: Use JavaScript and LocalStorage to manage state. Use cdnjs.com for any UI or animation libraries.
   - **Examples**:
     - Interactive To-Do List
     - Simple Budget Tracker
     - Text Formatter/Converter
     - Markdown Previewer

2. **Data Visualization & Dashboards**
   - **How they work**: Use CSV upload or mock API via window.claude.complete, render visualizations with Chart.js or D3.js.
   - **Examples**:
     - CSV Data Explorer
     - Interactive Financial Chart
     - Mock "API" Dashboard
     - Personalized Weather Dashboard

3. **Games & Entertainment**
   - **How they work**: Render graphics on <canvas>, handle input via JavaScript, optionally use window.claude.complete for storytelling or game events.
   - **Examples**:
     - Classic Arcade Game
     - Interactive Fiction / AI Dungeon
     - AI-Powered Chatbot Character
     - Visual Toy / Animation Demo

4. **Educational & Learning Aids**
   - **How they work**: Use interactivity, LocalStorage for progress, and window.claude.complete for AI explanations or generation.
   - **Examples**:
     - Language Flashcards
     - AI Math Tutor
     - AI-Powered Code Explainer
     - Interactive Periodic Table

5. **Developer & Technical Utilities**
   - **How they work**: Use pure JavaScript to transform/validate input. UI is basic form with text areas.
   - **Examples**:
     - Regex Tester
     - Code Playground
     - JSON Formatter & Validator

6. **Widgets for Livestreamers & YouTubers**
   - **How they work**: Transparent background, simple input forms, chroma key support, AI interaction if needed.
   - **Examples**:
     - Live Countdown Timer
     - AI Q&A Display
     - Dynamic Call-to-Action
     - "Now Playing" / "Up Next" Info Box
     - Live Poll Visualizer

