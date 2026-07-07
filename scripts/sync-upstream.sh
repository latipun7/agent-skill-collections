#!/usr/bin/env bash
set -euo pipefail

# Sync upstream skill repos
# Run this periodically to pull latest changes from original skill repos
# Usage: ./scripts/sync-upstream.sh [--dry-run]

DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=true
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

declare -A UPSTREAM
UPSTREAM["skillopt"]="https://github.com/magnus919/hermes-SkillOpt.git"
UPSTREAM["historical-bayesian-html-briefing"]="https://github.com/H-Ali13381/historical-bayesian-html-briefing.git"

cd "$REPO_DIR"

for dir in "${!UPSTREAM[@]}"; do
  url="${UPSTREAM[$dir]}"
  target="skills/$dir"

  echo "=== $target ($url) ==="

  if [ ! -d "$target" ]; then
    echo "  ✗ Directory $target not found, skipping"
    continue
  fi

  if $DRY_RUN; then
    echo "  [dry-run] Would update $target from $url"
    continue
  fi

  # Create temp dir and clone latest
  tmpdir=$(mktemp -d)
  git clone --depth 1 "$url" "$tmpdir" 2>/dev/null

  # Remove .git from the cloned copy
  rm -rf "$tmpdir/.git"

  # Remove .gitignore from upstream that might interfere
  rm -f "$tmpdir/.gitignore"

  # Sync: delete old files, copy new ones
  # This ensures deleted upstream files are also removed from our repo
  # --exclude=.agents skips the cross-client mirror (duplicate files)
  rsync -a --delete --exclude=.agents "$tmpdir/" "$target/"

  rm -rf "$tmpdir"
  echo "  ✓ Updated"
done

echo ""
echo "Done. Run 'git status' and commit if there are changes."
