# v-appydave - AppyDave Video Projects

This repository tracks light files (transcripts, thumbnails, docs) for AppyDave brand video projects (107 projects total). Heavy video files are stored locally during active work, then archived to external SSD, and eventually to AWS S3/Glacier.

**GitHub**: https://github.com/appydave-video-projects/v-appydave

> 📘 **For detailed technical documentation**, see [CLAUDE.md](CLAUDE.md) - includes comprehensive workflow guides, tool execution order, troubleshooting, and dependencies.

## Workflow

AppyDave videos follow the **FliVideo workflow** - sequential chapter-based recording:
1. Plan chapters in advance
2. Record individual chapter videos locally
3. Edit and assemble with FliVideo gem
4. Publish to YouTube
5. Archive: Move to SSD, keep light files locally for LLM processing

See `/video-projects/CLAUDE.md` for full workflow documentation.

## Storage Strategy

**File Types**:
- **Heavy files** (*.mp4, *.mov, *.avi) - Large video files, archived after publish
- **Light files** (*.srt, *.jpg, *.png, *.md, *.txt) - Transcripts, thumbnails, docs kept locally

**Storage Locations**:
1. **Local active** (`~/dev/video-projects/v-appydave/b63-project/`) - Current projects (flat structure)
2. **Local archived** (`~/dev/video-projects/v-appydave/archived/b50-b99/b62-project/`) - Light files only (grouped structure)
3. **SSD backup** (`/Volumes/T7/.../b50-b99/b62-project/`) - Full backup with heavy files (grouped structure)
4. **S3/Glacier** (future) - Cloud archival

**Why keep light files locally?**
- Process transcripts through LLMs for insights
- Generate titles/thumbnails with AI agents
- Build web dashboards showing all video summaries
- Quick reference without mounting SSD

**Git tracking**: Light files only (heavy files gitignored)

## Project Lifecycle

### Phase 1: Active Work
- Location: `~/dev/video-projects/v-appydave/b63-new-project/` (flat structure)
- Contains: Both heavy files (MP4s) and light files
- Working: Record, edit, publish

### Phase 2: Archive to SSD
```bash
# Preview what will happen
ruby .admin/archive_project.rb b63-new-project --dry-run

# Archive to SSD and delete local folder
ruby .admin/archive_project.rb b63-new-project

# Pull back light files to archived/ folder
ruby .admin/sync_from_ssd.rb

# Update manifest
ruby .admin/generate_manifest.rb
```

After archival:
- SSD: `b50-b99/b63-new-project/` (complete with heavy files)
- Local: `archived/b50-b99/b63-new-project/` (light files only)

### Phase 3: Batch Archive (Multiple Projects)
Archive multiple oldest projects at once:
```bash
# Preview archiving oldest 5 projects
ruby .admin/archive_project.rb --next 5 --dry-run

# Archive oldest 5 projects
ruby .admin/archive_project.rb --next 5

# Pull back light files
ruby .admin/sync_from_ssd.rb

# Update manifest
ruby .admin/generate_manifest.rb
```

### Phase 4: Sync Light Files
If you need light files from old projects (for LLM processing, web tools):
```bash
# Preview what would be synced
ruby .admin/sync_from_ssd.rb --dry-run

# Sync all light files from SSD to archived/ folder
ruby .admin/sync_from_ssd.rb
```

**Note**: Sync tool automatically checks manifest and only syncs projects NOT in local flat structure.

## Tools

All tools are located in `.admin/` directory and use location-aware paths. Always run from project root.

### 1. Generate Manifest

Scan both locations and track what exists where:

```bash
ruby .admin/generate_manifest.rb
```

Output: `projects.json` with structure:
```json
{
  "config": {
    "local_base": "~/dev/video-projects/v-appydave",
    "ssd_base": "/Volumes/T7/youtube-PUBLISHED/appydave",
    "last_updated": "2025-10-20T12:23:13Z"
  },
  "projects": [
    {
      "id": "b62-remotion-overview",
      "storage": {
        "ssd": { "exists": true, "path": "b50-b99/b62-remotion-overview" },
        "local": {
          "exists": true,
          "structure": "grouped",
          "has_heavy_files": false,
          "has_light_files": true
        }
      }
    }
  ]
}
```

**Manifest interpretation**:
- `structure: "flat"` - Active project (not yet archived)
- `structure: "grouped"` - Archived project (in b00-b49/ or b50-b99/ folder)
- `has_heavy_files: true` - Contains MP4s (needs archival or is active)
- `has_heavy_files: false` - Light files only (already archived)

### 2. Archive Project

Archive a completed project to SSD:

```bash
# Single project - preview
ruby .admin/archive_project.rb b63-flivideo --dry-run

# Single project - execute
ruby .admin/archive_project.rb b63-flivideo

# Batch archive - oldest 5 projects
ruby .admin/archive_project.rb --next 5 --dry-run
ruby .admin/archive_project.rb --next 5

# After archiving, pull back light files and update manifest
ruby .admin/sync_from_ssd.rb
ruby .admin/generate_manifest.rb
```

**What it does**:
1. Copies entire project to SSD grouped folder
2. Deletes local folder completely
3. Use `sync_from_ssd.rb` afterward to pull back light files to `archived/`

**Options**:
- `--next N` - Archive N oldest projects sequentially
- `--dry-run` - Preview changes without executing

### 3. Sync from SSD

Pull light files from SSD to local (useful for accessing old project data):

```bash
# Preview what would be synced
ruby .admin/sync_from_ssd.rb --dry-run

# Sync all projects from SSD to archived/ folder
ruby .admin/sync_from_ssd.rb

# Update manifest after syncing
ruby .admin/generate_manifest.rb
```

**What gets synced**:
- Transcripts (*.srt, *.vtt)
- Thumbnails (*.jpg, *.png)
- Documentation (*.md, *.txt)
- Configuration (*.json, *.yml)

**What gets excluded**:
- Heavy video files (*.mp4, *.mov, *.avi)
- Files that already exist with same size

**Result**: Local mirrored structure with light files only:
```
~/dev/video-projects/v-appydave/
├── b40-active-project/           # Active (flat, has heavy files)
└── archived/
    ├── b00-b49/
    │   └── b42-old-project/     # Archived (grouped, light files only)
    └── b50-b99/
        └── b62-recent-project/  # Archived (grouped, light files only)
```

## Project Structure

### Grouped Folders (SSD and archived local)
Projects organized by number range to avoid hundreds of folders in one directory:
- `-01-25/` - Legacy numerical projects (1-25)
- `a01-a49/` - Projects a00-a49
- `a50-a99/` - Projects a50-a99
- `b00-b49/` - Projects b00-b49
- `b50-b99/` - Projects b50-b99
- etc.

### Each Project Contains
```
b62-remotion-overview/
├── transcripts/          # .srt, .vtt subtitle files
├── thumbnails/           # .jpg thumbnail images
├── docs/                 # .md documentation
├── chapters/             # Individual chapter files
└── *.mp4                # Video files (only on SSD, gitignored)
```

## Security

Secret scanning enabled (gitleaks):
- GitHub Actions scan on every push
- Pre-commit hooks (optional local setup)
- See parent `SECURITY-SETUP.md` for details

## Related Repositories

- [v-voz](https://github.com/appydave-video-projects/v-voz) - VOZ client (Storyline workflow)
- [v-aitldr](https://github.com/appydave-video-projects/v-aitldr) - AITLDR brand videos
- [v-beauty-and-joy](https://github.com/appydave-video-projects/v-beauty-and-joy) - Joy's content
- [v-kiros](https://github.com/appydave-video-projects/v-kiros) - Kiros client videos
- [v-supportsignal](https://github.com/appydave-video-projects/v-supportsignal) - SupportSignal client videos

---

**Last Updated**: 2025-10-20
