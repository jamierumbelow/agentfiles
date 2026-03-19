#!/usr/bin/env bash
#
# add-all-skills — register every skill in the skills/ directory.
#
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

for skill_dir in "$REPO_DIR"/skills/*/; do
    [[ -d "$skill_dir" ]] || continue
    "$SCRIPT_DIR/add-skill.sh" "$skill_dir"
done
