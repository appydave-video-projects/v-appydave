# vOz Learning Context - Clauding 01

Context gathered from vOz's Loom video, screenshots, and email (2025-12-09).

---

## Loom Update

**Video**: https://www.loom.com/share/13221ad32f184665bab4cfd4da52d004
**Title**: Learning to Use Claude Code for Vibe Coding

### Transcript

> 0:00 Hello, David. this is vOz. this is what I've been doing today. I've been trying to go through learning how to use Claude Code for Vibe Coding.
>
> 0:11 And, this is kind of where I'm at in the videos I've been watching. I hope I will continue with this.
>
> 0:18 This is kind of some of the different websites I've gone to. and what I'm starting to get set up.
>
> 0:28 So I will continue with this and if I have any further questions I'll send you an email to, loom. And, and we'll go from there.
>
> 0:40 So, thanks a lot. And, good day. Give joy my best. And, hope everything is well. Bye-bye.

---

## Current Course Progress

### Claude Code in Action (Anthropic Academy)

**Course URL**: https://anthropic.skilljar.com/claude-code-in-action

#### What is Claude Code?

**Completed:**
- Introduction
- What is a coding assistant?
- Claude Code in action

#### Getting Hands On

**Completed:**
- Claude Code setup
- Project setup

**Remaining:**
- Adding context
- Making changes
- Course satisfaction survey
- Controlling context
- Custom commands
- MCP servers with Claude Code
- Github integration

#### Hooks and the SDK

**Remaining:**
- Introducing hooks
- Defining hooks
- Implementing a hook
- Gotchas around hooks
- Useful hooks!
- Another useful hook

---

## Project Setup Notes (from Course)

Working with Claude Code is more interesting if you have a project to work with. The course uses a UI generation app:

1. Ensure Node.js is installed locally
2. Download `uigen.zip` from course materials and extract it
3. In the project directory, run `npm run setup` to install dependencies and set up a local SQLite database
4. **Optional**: This project uses Claude through the Anthropic API to generate UI components. If you want to fully test out the app, you will need to provide an API key to access the Anthropic API. *This is optional. If no API key is provided, the app will still generate some static fake code.*
   - Get an Anthropic API key at: https://console.anthropic.com/
   - Place your API key in the `.env` file
5. Start the project by running `npm run dev`

---

## vOz's Course Notes

### What is Claude Code?

#### What is a Coding Assistant?
1. Coding assistants use language models to complete different tasks
2. Language models need to use tools to work a vast majority of tasks
3. Not all language models use tools with the same finesse
4. Claude's strong tool use with Claude Code allows for better security, customization, and longevity

#### Claude Code in Action
1. Claude Code can tackle harder tasks
   - a. Claude will eagerly combine together different tools to handle more complex work
   - b. Claude will adeptly use tools it hasn't seen before
2. Claude Code is extensible
   - a. You can easily add additional tools (capabilities) to Claude Code
   - b. Adding tools allows customization for your particular workflow
   - c. Adding tools allow Claude to keep up with rapid changes in AI-enabled development
3. Improved Security
   - a. Thanks to Claude's strong tool use, Claude Code can easily navigate codebases
   - b. Claude Code doesn't rely upon indexing your codebase, which often requires sending your entire codebase to outside servers

---

## vOz's Compiled Learning Resources

### Instructors & Educators

**Elie Schoppik / Frontend Masters**
- https://frontendmasters.com/teachers/elie-schoppik/
- https://github.com/elie
- https://www.linkedin.com/in/eschoppik/

**Andrew Ng**
- https://www.linkedin.com/in/andrewyng/
- https://www.linkedin.com/company/deeplearningai/
- https://www.deeplearning.ai/

**Stephen Grider**
- YouTube: https://www.youtube.com/@stephengrider3783

### Platforms

**Anthropic Academy**
- https://www.anthropic.com/learn
- https://anthropic.skilljar.com/
- https://anthropic.skilljar.com/claude-code-in-action/303233
- https://anthropic.skilljar.com/claude-code-in-action

**LinkedIn Learning**
- https://www.linkedin.com/learning/

### Documentation

**Claude Code Quickstart**
- https://code.claude.com/docs/en/quickstart#native-install-recommended

**Shared Claude Prompt**
- https://claude.ai/share/d3602fa4-bf53-46f5-9b4a-7241527491fa

---

## Video Series Context

**Series Name**: Clauding
**Definition**: Vibe coding in the Claude Code environment

**Teaching Arc** (potential progression):
- Prompt Engineering → Vibe Coding → Context Engineering

This is lesson 01 - foundational, hands-on, dynamic session.

---

## Data Exclusions

The following were found in source materials but intentionally excluded:
- vOz's LinkedIn Learning account credentials (email + password visible in screenshot)

---

*Last updated: 2025-12-09*
