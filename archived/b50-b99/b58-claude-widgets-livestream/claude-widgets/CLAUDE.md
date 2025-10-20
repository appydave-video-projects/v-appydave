# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Claude Artifacts project focused on creating interactive web applications ("acts") for livestreaming and content creation. The project emphasizes building small, focused applications that leverage Claude's capabilities through the `window.claude.complete()` API within the Claude Artifacts sandbox environment.

## Key Constraints & Capabilities

### Claude Artifacts Sandbox Environment
- **No external API calls**: Cannot use `fetch()` to call third-party services
- **Client-side only**: All code runs in the user's browser with no custom backend
- **One API available**: `window.claude.complete()` for AI interactions ("Claudeception")
- **Browser features**: LocalStorage, HTML5 File API, `<canvas>` element are supported
- **CDN libraries**: Only libraries from whitelisted cdnjs.com can be used

### Development Workflow
- **Hosting**: Artifacts are one-click deployed to claude.site domains
- **Debugging**: Claude cannot see runtime errors; copy browser console errors back to Claude for fixes
- **AI conversations**: `window.claude.complete()` is stateless; manually manage chat history for continuous conversations
- **Media**: Can only display uploaded/included media; Claude responses must be text-only

## Application Categories

### 1. Productivity & Organization Tools
Use JavaScript + LocalStorage for state management, cdnjs.com for UI libraries.
Examples: Interactive To-Do Lists, Budget Trackers, Text Formatters

### 2. Data Visualization & Dashboards  
Use CSV upload or mock APIs via `window.claude.complete()`, render with Chart.js or D3.js.
Examples: CSV Data Explorers, Financial Charts, Mock API Dashboards

### 3. Games & Entertainment
Use `<canvas>` for graphics, JavaScript for input, optional AI for storytelling.
Examples: Arcade Games, Interactive Fiction, AI Chatbot Characters

### 4. Educational & Learning Aids
Use interactivity + LocalStorage for progress, AI for explanations/generation.
Examples: Flashcards, AI Tutors, Code Explainers

### 5. Developer & Technical Utilities
Pure JavaScript for transformations/validation, basic form UIs.
Examples: Regex Testers, Code Playgrounds, JSON Formatters

### 6. Widgets for Livestreamers & YouTubers
Transparent backgrounds, simple inputs, chroma key support, optional AI interaction.
Examples: Countdown Timers, Q&A Displays, Call-to-Actions, Poll Visualizers

## Development Principles

- **Small, focused requirements**: Keep applications concise and clear for optimal Claude generation
- **Design and UX first**: Prioritize beautiful, intuitive user experiences
- **Use supported libraries**: anime.js for animations, Tailwind CSS for styling (via cdnjs.com)
- **Leverage browser features**: Make full use of LocalStorage, File API, canvas, etc.
- **Structure AI interactions**: Use `window.claude.complete()` with structured JSON responses for dynamic behavior

## Project Structure

This project currently contains only documentation (`claude_artifacts_livestream.md`) that serves as the foundational guide for livestream development. Individual applications will be created as Claude Artifacts rather than traditional files in this repository.