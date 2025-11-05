# v-appydave Video Project Management

This directory contains AppyDave brand video projects (107 total) managed across local and SSD storage with Ruby-based automation tools.

## Project Structure

### Storage Locations

- **Local Flat** (`~/dev/video-projects/v-appydave/b40-project/`)
  - Active projects at root level
  - Contains heavy files (videos) and light files (transcripts, thumbnails)
  - Currently: 5 projects (~3.93 GB)

- **Local Archived** (`~/dev/video-projects/v-appydave/archived/[range]/`)
  - Archived projects in grouped range folders
  - Contains ONLY light files (transcripts, thumbnails, docs)
  - Heavy files removed to save disk space
  - Currently: 102 projects (~1.55 GB)

- **SSD Backup** (`/Volumes/T7/youtube-PUBLISHED/appydave/[range]/`)
  - Complete backup of all projects (heavy + light files)
  - Organized in range folders: `-01-25`, `a01-a49`, `a50-a99`, `b00-b49`, `b50-b99`, etc.
  - Currently: 107 projects (~400.61 GB)

### Final Assets Directory

The `final/` directory stores **publishable final videos** ready for distribution.

**Naming convention**: `{project-name}-v{version}.mp4` (lowercase-kebab-case)

**Examples**:
```
project-name/
└── final/
    ├── project-name-v1.mp4          # First version
    ├── project-name-v2.mp4          # Revised version
    └── project-name-short-v1.mp4    # Short variant
```

**Git tracking**: Files in `final/` are tracked (exception to video ignore rules).

**When to use**:
- ✅ Final YouTube uploads
- ✅ Client deliverables
- ✅ Multiple versions for A/B testing
- ❌ NOT for work-in-progress renders

---

### Project Naming Convention

Projects follow sequential naming: `{letter}{number}-{name}`

- **Letter**: a-z (26 letters)
- **Number**: 00-99 (100 numbers)
- **Capacity**: 26 × 100 = 2,600 possible projects

**Examples**: `a00-first-project`, `b63-flivideo`, `z99-last-project`

### Range Folders

Projects are grouped into 50-project ranges for organization:

- `-01-25`: Legacy numerical projects (1-25)
- `a01-a49`: Projects a00-a49
- `a50-a99`: Projects a50-a99
- `b00-b49`: Projects b00-b49
- `b50-b99`: Projects b50-b99
- etc.

## Management Tools

All tools are located in `../v-shared/video-asset-tools/` directory (shared across all video repos).

### Prerequisites

1. **Ruby** installed (system Ruby or rbenv/rvm)
2. **SSD mounted** at `/Volumes/T7/youtube-PUBLISHED/appydave`
3. **Configuration file**: `.video-tools.env` in repository root
4. **Run from project root**: `~/dev/video-projects/v-appydave/`

### Tool Overview

| Tool | Purpose | SSD Required |
|------|---------|--------------|
| `generate_manifest.rb` | Scan and create projects.json | ✅ Yes |
| `sync_from_ssd.rb` | Pull light files from SSD | ✅ Yes |
| `archive_project.rb` | Archive project to SSD | ✅ Yes |
| `dashboard.html` | Visualize project state | ❌ No |

**Location**: `../v-shared/video-asset-tools/bin/`

**Documentation**: See `../v-shared/video-asset-tools/README.md` for full usage guide

## Workflows

### 1. Initial Setup / Refresh Manifest

**When to use**: First time setup, or after making manual changes to projects

```bash
# Generate manifest (scans local + SSD)
ruby ../v-shared/video-asset-tools/bin/generate_manifest.rb

# View dashboard
open ../v-shared/video-asset-tools/bin/dashboard.html
```

**What it does**:
- Scans all projects in local (flat + grouped) and SSD
- Creates `projects.json` manifest with disk usage stats
- Validates project structure consistency

**Output**: `projects.json` at root

---

### 2. Archive a Single Project

**When to use**: When you've finished working on a project and want to archive it

```bash
# Preview what will happen (dry-run)
ruby ../v-shared/video-asset-tools/bin/archive_project.rb b63-flivideo --dry-run

# Execute archival
ruby ../v-shared/video-asset-tools/bin/archive_project.rb b63-flivideo

# Pull back light files to archived/
ruby ../v-shared/video-asset-tools/bin/sync_from_ssd.rb

# Update manifest
ruby ../v-shared/video-asset-tools/bin/generate_manifest.rb
```

**What it does**:
1. `archive_project.rb`: Copies entire project to SSD, deletes local folder
2. `sync_from_ssd.rb`: Pulls back only light files to `archived/[range]/`
3. `generate_manifest.rb`: Updates projects.json with new state

**Result**:
- Project removed from local flat
- Full backup on SSD
- Light files in local `archived/` folder
- Manifest updated

---

### 3. Archive Multiple Projects (Batch)

**When to use**: When you want to archive the oldest N projects sequentially

```bash
# Preview archiving oldest 5 projects
ruby ../v-shared/video-asset-tools/bin/archive_project.rb --next 5 --dry-run

# Execute batch archival
ruby ../v-shared/video-asset-tools/bin/archive_project.rb --next 5

# Pull back light files
ruby ../v-shared/video-asset-tools/bin/sync_from_ssd.rb

# Update manifest
ruby ../v-shared/video-asset-tools/bin/generate_manifest.rb
```

**What it does**:
- Finds oldest N projects in flat structure (sorted by prefix: a00, a01, b40, b41...)
- Archives each one sequentially to SSD
- Deletes local folders
- Then you sync back light files and regenerate manifest

---

### 4. Sync Light Files from SSD

**When to use**: After archiving projects, or to refresh local archived folders

```bash
# Preview what will be synced
ruby ../v-shared/video-asset-tools/bin/sync_from_ssd.rb --dry-run

# Execute sync
ruby ../v-shared/video-asset-tools/bin/sync_from_ssd.rb

# Update manifest
ruby ../v-shared/video-asset-tools/bin/generate_manifest.rb
```

**What it does**:
- Reads `projects.json` manifest
- Syncs ONLY projects that exist on SSD but NOT in local flat structure
- Copies only light files (transcripts, thumbnails, docs)
- Skips heavy video files
- Creates `archived/[range]/[project]` folders

**Patterns**:
- **Included**: `*.srt`, `*.vtt`, `*.txt`, `*.md`, `*.jpg`, `*.png`, `*.json`, `*.yml`
- **Excluded**: `*.mp4`, `*.mov`, `*.avi`, `*.mkv`, `*.webm`

---

### 5. View Dashboard

**When to use**: Anytime you want to visualize project state

```bash
open ../v-shared/video-asset-tools/bin/dashboard.html
```

**What it shows**:
- Disk usage stats (local flat, local grouped, SSD)
- Three tabs: Local Flat, Local Grouped, SSD
- Search/filter bars for each tab
- Project counts in tab labels
- Storage details for each project

**Dependencies**: Reads `projects.json` from root

---

## Tool Execution Order

### Standard Archive Workflow

```
1. ruby ../v-shared/video-asset-tools/bin/archive_project.rb [project-id]
   └─ Copies to SSD, deletes local

2. ruby ../v-shared/video-asset-tools/bin/sync_from_ssd.rb
   └─ Pulls back light files to archived/

3. ruby ../v-shared/video-asset-tools/bin/generate_manifest.rb
   └─ Updates projects.json
```

### After Manual Changes

```
1. ruby ../v-shared/video-asset-tools/bin/generate_manifest.rb
   └─ Rescan everything, update manifest

2. open ../v-shared/video-asset-tools/bin/dashboard.html
   └─ View updated state
```

### Sync Without Archiving

```
1. ruby ../v-shared/video-asset-tools/bin/sync_from_ssd.rb
   └─ Pull light files for SSD-only projects

2. ruby ../v-shared/video-asset-tools/bin/generate_manifest.rb
   └─ Update manifest
```

## Common Scenarios

### Scenario: I finished editing project b63-flivideo

```bash
ruby ../v-shared/video-asset-tools/bin/archive_project.rb b63-flivideo
ruby ../v-shared/video-asset-tools/bin/sync_from_ssd.rb
ruby ../v-shared/video-asset-tools/bin/generate_manifest.rb
```

### Scenario: I want to archive my 10 oldest projects

```bash
ruby ../v-shared/video-asset-tools/bin/archive_project.rb --next 10 --dry-run  # Preview
ruby ../v-shared/video-asset-tools/bin/archive_project.rb --next 10            # Execute
ruby ../v-shared/video-asset-tools/bin/sync_from_ssd.rb
ruby ../v-shared/video-asset-tools/bin/generate_manifest.rb
```

### Scenario: I manually copied files to SSD

```bash
ruby ../v-shared/video-asset-tools/bin/generate_manifest.rb  # Rescan to detect changes
```

### Scenario: I want to check disk usage

```bash
ruby ../v-shared/video-asset-tools/bin/generate_manifest.rb  # Recalculate
open ../v-shared/video-asset-tools/bin/dashboard.html         # View stats
```

### Scenario: I need to restore a project from SSD

```bash
# Manually copy from SSD to local flat
cp -r /Volumes/T7/youtube-PUBLISHED/appydave/[range]/[project] ./

# Update manifest
ruby ../v-shared/video-asset-tools/bin/generate_manifest.rb
```

## File Types

### Heavy Files (Video Assets)
- `*.mp4`, `*.mov`, `*.avi`, `*.mkv`, `*.webm`
- Kept ONLY on SSD for archived projects
- Present in local flat for active projects

### Light Files (Metadata & Docs)
- `*.srt`, `*.vtt` - Subtitles/captions
- `*.txt`, `*.md` - Documentation
- `*.jpg`, `*.jpeg`, `*.png`, `*.webp` - Thumbnails/images
- `*.json`, `*.yml`, `*.yaml` - Configuration/metadata
- Synced to local `archived/` folders

## Validation & Safety

### Built-in Validations

- **SSD mount check**: Tools exit if SSD not mounted
- **Project ID format**: Validates naming convention
- **Structure consistency**: Warns if grouped projects fall within flat range
- **Duplicate detection**: Prevents syncing if flat folder exists (stale manifest)

### Dry-Run Mode

All archive and sync tools support `--dry-run`:

```bash
ruby ../v-shared/video-asset-tools/bin/archive_project.rb b63-flivideo --dry-run
ruby ../v-shared/video-asset-tools/bin/sync_from_ssd.rb --dry-run
```

**Always run dry-run first** to preview changes before executing.

### Defensive Operations

- Sync tool checks manifest AND filesystem to prevent duplicates
- Archive tool skips copy if project already exists on SSD
- Disk usage calculations exclude `.DS_Store` files
- Size verification when comparing duplicates (allows 1KB difference)

## Manifest Structure (projects.json)

```json
{
  "config": {
    "local_base": "~/dev/video-projects/v-appydave",
    "ssd_base": "/Volumes/T7/youtube-PUBLISHED/appydave",
    "last_updated": "2025-10-20T15:22:40Z",
    "disk_usage": {
      "local_flat": { "total_gb": 3.93 },
      "local_grouped": { "total_gb": 1.55 },
      "ssd": { "total_gb": 400.61 }
    }
  },
  "projects": [
    {
      "id": "b63-flivideo",
      "storage": {
        "ssd": {
          "exists": true,
          "path": "b50-b99/b63-flivideo"
        },
        "local": {
          "exists": true,
          "structure": "flat",
          "has_heavy_files": true,
          "has_light_files": true
        }
      }
    }
  ]
}
```

## Troubleshooting

### SSD not mounted error

```bash
# Check if SSD is mounted
ls /Volumes/T7/youtube-PUBLISHED/appydave

# If not, connect T7 SSD and wait for it to mount
```

### Manifest shows wrong counts

```bash
# Regenerate manifest from scratch
ruby ../v-shared/video-asset-tools/bin/generate_manifest.rb
```

### Sync tool shows "stale manifest" warning

```bash
# Project exists in both flat and grouped (shouldn't happen)
# Regenerate manifest to update
ruby ../v-shared/video-asset-tools/bin/generate_manifest.rb
```

### Dashboard not showing latest data

```bash
# Regenerate manifest first
ruby ../v-shared/video-asset-tools/bin/generate_manifest.rb

# Then reload dashboard
open ../v-shared/video-asset-tools/bin/dashboard.html
```

## Git Strategy

This repo tracks **metadata only** (transcripts, thumbnails, docs). Video files are gitignored.

```bash
# .gitignore includes:
*.mp4
*.mov
*.avi
*.mkv
*.webm
```

Only commit:
- Light files (transcripts, thumbnails, docs)
- Tool scripts (`.admin/*.rb`)
- Manifest (`projects.json`)
- Documentation (`CLAUDE.md`, `README.md`)

## Future: S3/Glacier Integration

Planned integration for cloud backup:
1. Archive to SSD (current workflow)
2. Upload to S3/Glacier from SSD
3. Delete from SSD (optional, keep recent)
4. Manifest tracks S3 location

**Status**: Not yet implemented

---

Last updated: 2025-10-20
