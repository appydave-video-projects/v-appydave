# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

AppyDave brand video projects repository. This repo tracks **light files only** (transcripts, thumbnails, documentation) - heavy video files are gitignored and stored on external SSD (`/Volumes/T7/youtube-PUBLISHED/appydave`).

**Workflow**: FliVideo - sequential chapter-based recording for YouTube content.

## Directory Structure

```
v-appydave/
├── b85-clauding-01/              # Active projects (flat at root)
├── b84-ecamm-application/
├── ...
├── archived/                     # Light files from completed projects
│   ├── -01-25/                   # Legacy numerical projects
│   ├── a01-a49/
│   ├── a50-a99/
│   ├── b00-b49/
│   └── b50-b99/
├── projects.json                 # Project manifest (gitignored)
└── .video-tools.env              # Local config with SSD paths (gitignored)
```

## Project Naming Convention

Format: `{letter}{number}-{name}` (e.g., `b85-clauding-01`, `b84-ecamm-application`)

- **Letter**: a-z (26 letters)
- **Number**: 00-99 (100 numbers)
- **Range folders**: Projects grouped by 50s (e.g., `b50-b99/`)

## File Types

**Light files** (tracked in git):
- `*.srt`, `*.vtt` - Subtitles/captions
- `*.txt`, `*.md` - Documentation and transcripts
- `*.jpg`, `*.png`, `*.webp` - Thumbnails
- `*.json`, `*.yml` - Configuration/metadata

**Heavy files** (gitignored, stored on SSD):
- `*.mp4`, `*.mov`, `*.avi`, `*.mkv`, `*.webm`

## Typical Project Structure

```
b85-clauding-01/
├── recordings/              # Chapter recordings (heavy files on SSD)
├── recording-transcripts/   # Transcript files per chapter
├── assets/                  # Images, thumbnails
├── final/                   # Final rendered videos
└── *.md                     # Documentation
```

## Finding Project Context

To understand what a video project is about:

1. **Use the DAM skill** - Invoke the `managing-assets` skill to query real data about projects
2. **Read intro transcripts** - Most projects have transcripts, and the first 2-3 files (typically starting with `01-` and containing "intro" in the name) describe what the video will cover

## Final Assets

The `final/` directory stores publishable videos. Naming: `{project-name}-v{version}.mp4`

Example:
```
final/
├── b85-clauding-01-v1.mp4
└── b85-clauding-01-short-v1.mp4
```

## Git Strategy

- Light files only (transcripts, thumbnails, docs)
- Heavy video files gitignored
- SSD backup location: `/Volumes/T7/youtube-PUBLISHED/appydave/[range]/`

## Related Repositories

- [v-voz](https://github.com/appydave-video-projects/v-voz) - VOZ client (Storyline workflow)
- [v-aitldr](https://github.com/appydave-video-projects/v-aitldr) - AITLDR brand
- [v-shared](https://github.com/appydave-video-projects/v-shared) - Shared resources

---

Last updated: 2025-12-09
