#!/usr/bin/env ruby
# frozen_string_literal: true

# Generate projects.json manifest by scanning local and SSD directories
# Tracks video projects across storage locations with grouped folder support
#
# Usage: ruby generate_manifest.rb

require 'json'
require 'fileutils'

# Determine paths relative to script location
SCRIPT_DIR = File.dirname(__FILE__)
LOCAL_BASE = File.expand_path(File.join(SCRIPT_DIR, '..'))
LOCAL_ARCHIVED = File.join(LOCAL_BASE, 'archived')
SSD_BASE = '/Volumes/T7/youtube-PUBLISHED/appydave'
OUTPUT_FILE = File.join(LOCAL_BASE, 'projects.json')

def has_heavy_files?(dir)
  return false unless Dir.exist?(dir)

  Dir.glob(File.join(dir, '*.{mp4,mov,avi,mkv,webm}')).any?
end

def has_light_files?(dir)
  return false unless Dir.exist?(dir)

  Dir.glob(File.join(dir, '**/*.{srt,vtt,jpg,png,md,txt,json,yml}')).any?
end

def build_ssd_range_map
  return @ssd_range_map if @ssd_range_map

  @ssd_range_map = {}
  Dir.glob(File.join(SSD_BASE, '*/')).each do |range_path|
    range_name = File.basename(range_path)
    Dir.glob(File.join(range_path, '*/')).each do |project_path|
      proj_id = File.basename(project_path)
      @ssd_range_map[proj_id] = range_name
    end
  end

  @ssd_range_map
end

def get_range_for_project(project_id)
  build_ssd_range_map[project_id]
end

# Validation functions
def validate_project_id_format(project_id)
  # Valid formats:
  # - Modern: letter + 2 digits + dash + name (e.g., a00-project, b63-flivideo)
  # - Legacy: just numbers (e.g., 006-ac-carnivore-90, 010-bing-gpt)
  !!(project_id =~ /^[a-z]\d{2}-/ || project_id =~ /^\d/)
end

def extract_prefix(project_id)
  # Extract the prefix (e.g., "b63" from "b63-flivideo")
  match = project_id.match(/^([a-z]\d{2})/)
  match ? match[1] : nil
end

def compare_prefixes(prefix1, prefix2)
  # Compare two prefixes (e.g., "a12" vs "b40")
  # Returns: -1 if prefix1 < prefix2, 0 if equal, 1 if prefix1 > prefix2
  return 0 if prefix1 == prefix2

  letter1, num1 = prefix1[0], prefix1[1..2].to_i
  letter2, num2 = prefix2[0], prefix2[1..2].to_i

  if letter1 == letter2
    num1 <=> num2
  else
    letter1 <=> letter2
  end
end

def validate_flat_structure_consistency(projects)
  warnings = []

  flat_projects = projects.select { |p| p[:storage][:local][:structure] == 'flat' }
  return warnings if flat_projects.empty?

  # Extract prefixes and sort
  flat_prefixes = flat_projects.map { |p| extract_prefix(p[:id]) }.compact.sort

  return warnings if flat_prefixes.empty?

  # Find the oldest and newest flat projects
  oldest_flat = flat_prefixes.first
  newest_flat = flat_prefixes.last

  # Check if there are any grouped projects that are newer than the oldest flat
  grouped_projects = projects.select { |p| p[:storage][:local][:structure] == 'grouped' }
  grouped_prefixes = grouped_projects.map { |p| extract_prefix(p[:id]) }.compact

  grouped_prefixes.each do |grouped_prefix|
    if compare_prefixes(grouped_prefix, oldest_flat) >= 0 && compare_prefixes(grouped_prefix, newest_flat) <= 0
      warnings << "⚠️  WARNING: Project #{grouped_prefix}-* is in grouped structure but falls within flat range (#{oldest_flat} - #{newest_flat})"
    end
  end

  # Check for old projects in flat structure
  grouped_prefixes.each do |grouped_prefix|
    next unless compare_prefixes(grouped_prefix, oldest_flat) > 0

    # This is fine - grouped project is newer than flat (shouldn't happen but not critical)
  end

  warnings
end

def validate_project_id_formats(projects)
  warnings = []

  projects.each do |project|
    unless validate_project_id_format(project[:id])
      warnings << "⚠️  WARNING: Invalid project ID format: #{project[:id]}"
    end
  end

  warnings
end

def find_local_project(project_id)
  range = get_range_for_project(project_id)

  # Check flat structure first (active projects at root)
  flat_path = File.join(LOCAL_BASE, project_id)
  return flat_path if Dir.exist?(flat_path)

  # Check archived/grouped folder structure (if we know the range)
  if range
    archived_path = File.join(LOCAL_ARCHIVED, range, project_id)
    return archived_path if Dir.exist?(archived_path)
  end

  nil
end

def get_ssd_path(project_id)
  range = get_range_for_project(project_id)
  File.join(SSD_BASE, range, project_id)
end

# Require SSD to be mounted
unless Dir.exist?(SSD_BASE)
  puts "❌ SSD not mounted at #{SSD_BASE}"
  puts "   Please connect the SSD before running this tool."
  puts "   The manifest requires scanning both local AND SSD to be accurate."
  exit 1
end

# Collect all unique project IDs from both locations
all_project_ids = []

# Scan SSD (all range folders)
if Dir.exist?(SSD_BASE)
  Dir.glob(File.join(SSD_BASE, '*/')).each do |range_path|
    range_name = File.basename(range_path)
    # Look for project folders (a*, b*, or anything that looks like a project)
    Dir.glob(File.join(range_path, '*/')).each do |project_path|
      all_project_ids << File.basename(project_path)
    end
  end
end

# Scan local flat (root level projects)
Dir.glob(File.join(LOCAL_BASE, '*/')).each do |path|
  basename = File.basename(path)
  # Skip the 'archived' directory itself
  next if basename == 'archived'
  # Add flat project
  all_project_ids << basename
end

# Scan local archived (grouped folders inside archived/)
if Dir.exist?(LOCAL_ARCHIVED)
  Dir.glob(File.join(LOCAL_ARCHIVED, '*/')).each do |range_path|
    Dir.glob(File.join(range_path, '*/')).each do |project_path|
      all_project_ids << File.basename(project_path)
    end
  end
end

all_project_ids = all_project_ids.uniq.sort

# Build project entries
projects = []
all_project_ids.each do |project_id|
  local_path = find_local_project(project_id)
  ssd_path = get_ssd_path(project_id)

  local_exists = !local_path.nil?
  ssd_exists = Dir.exist?(ssd_path)

  # Determine if local is in flat or grouped structure
  # Check if path is in archived/ subdirectory
  local_structure = if local_path && local_path.include?('/archived/')
                      'grouped'
                    elsif local_path
                      'flat'
                    else
                      nil
                    end

  projects << {
    id: project_id,
    storage: {
      ssd: {
        exists: ssd_exists,
        path: "#{get_range_for_project(project_id)}/#{project_id}"
      },
      local: {
        exists: local_exists,
        structure: local_structure,
        has_heavy_files: local_exists ? has_heavy_files?(local_path) : false,
        has_light_files: local_exists ? has_light_files?(local_path) : false
      }
    }
  }
end

# Calculate disk usage for a specific path
def calculate_path_size(path)
  return 0 unless Dir.exist?(path)

  total = 0
  Dir.glob(File.join(path, '**', '*'), File::FNM_DOTMATCH).each do |file|
    total += File.size(file) if File.file?(file)
  end
  total
end

def format_bytes(bytes)
  {
    total_bytes: bytes,
    total_mb: (bytes / 1024.0 / 1024.0).round(2),
    total_gb: (bytes / 1024.0 / 1024.0 / 1024.0).round(2)
  }
end

puts "📊 Calculating disk usage..."

# Calculate local flat (root-level project folders only)
local_flat_bytes = 0
projects.each do |project|
  if project[:storage][:local][:exists] && project[:storage][:local][:structure] == 'flat'
    flat_path = File.join(LOCAL_BASE, project[:id])
    local_flat_bytes += calculate_path_size(flat_path)
  end
end

# Calculate local grouped (all grouped folders in archived/)
local_grouped_bytes = 0
projects.each do |project|
  if project[:storage][:local][:exists] && project[:storage][:local][:structure] == 'grouped'
    range = get_range_for_project(project[:id])
    grouped_path = File.join(LOCAL_ARCHIVED, range, project[:id])
    local_grouped_bytes += calculate_path_size(grouped_path)
  end
end

# Calculate total SSD
ssd_bytes = 0
projects.each do |project|
  if project[:storage][:ssd][:exists]
    range = get_range_for_project(project[:id])
    ssd_path = File.join(SSD_BASE, range, project[:id])
    ssd_bytes += calculate_path_size(ssd_path)
  end
end

local_flat_usage = format_bytes(local_flat_bytes)
local_grouped_usage = format_bytes(local_grouped_bytes)
ssd_usage = format_bytes(ssd_bytes)

# Build manifest
manifest = {
  config: {
    local_base: '~/dev/video-projects/v-appydave',
    ssd_base: '/Volumes/T7/youtube-PUBLISHED/appydave',
    last_updated: Time.now.utc.iso8601,
    note: 'Auto-generated manifest. Regenerate with: ruby generate_manifest.rb',
    disk_usage: {
      local_flat: local_flat_usage,
      local_grouped: local_grouped_usage,
      ssd: ssd_usage
    }
  },
  projects: projects
}

# Write to file
File.write(OUTPUT_FILE, JSON.pretty_generate(manifest))

puts "✅ Generated #{OUTPUT_FILE}"
puts "   Found #{projects.size} unique projects"
puts "   SSD mounted: #{Dir.exist?(SSD_BASE)}"
puts

# Summary stats
local_flat = projects.count { |p| p[:storage][:local][:structure] == 'flat' }
local_grouped = projects.count { |p| p[:storage][:local][:structure] == 'grouped' }
local_only = projects.count { |p| p[:storage][:local][:exists] && !p[:storage][:ssd][:exists] }
ssd_only = projects.count { |p| !p[:storage][:local][:exists] && p[:storage][:ssd][:exists] }
both = projects.count { |p| p[:storage][:local][:exists] && p[:storage][:ssd][:exists] }

puts "Distribution:"
puts "  Local only: #{local_only}"
puts "  SSD only: #{ssd_only}"
puts "  Both locations: #{both}"
puts
puts "Local structure:"
puts "  Flat (active): #{local_flat}"
puts "  Grouped (archived): #{local_grouped}"
puts

# Run validations
puts "🔍 Running validations..."
all_warnings = []

# Validate project ID formats
format_warnings = validate_project_id_formats(projects)
all_warnings.concat(format_warnings)

# Validate flat structure consistency
consistency_warnings = validate_flat_structure_consistency(projects)
all_warnings.concat(consistency_warnings)

if all_warnings.empty?
  puts "✅ All validations passed!"
else
  puts "#{all_warnings.size} warning(s) found:"
  all_warnings.each { |w| puts "   #{w}" }
end
