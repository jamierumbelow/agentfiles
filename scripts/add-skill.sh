#!/usr/bin/env bash
#
# add-skill — register a SKILL.md with every AI coding tool at once.
#
# All three tools (Claude Code, Codex, Gemini CLI) share the same
# convention: ~/.{tool}/skills/{name}/SKILL.md. This script resolves
# the input to an absolute skill directory and symlinks it into each
# tool's global skills folder, so one source of truth serves all three.
#
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib.sh"

usage() {
    cat <<EOF
Usage: $(basename "$0") <path>

Symlink a skill into the global skills directories for Claude Code,
Codex, and Gemini CLI.

<path> can be:
  - A SKILL.md file      (e.g. skills/my-skill/SKILL.md)
  - A skill directory     (e.g. skills/my-skill)

The skill directory is symlinked into:
  ~/.claude/skills/<name>
  ~/.codex/skills/<name>
  ~/.gemini/skills/<name>
EOF
    exit 1
}

[[ $# -lt 1 ]] && usage

input="$1"

# Resolve the input to an absolute path to the skill directory,
# accepting either a SKILL.md file or the directory containing it.
if [[ -f "$input" ]]; then
    if [[ "$(basename "$input")" != "SKILL.md" ]]; then
        error "file must be named SKILL.md"
    fi
    skill_dir="$(cd "$(dirname "$input")" && pwd)"
elif [[ -d "$input" ]]; then
    if [[ ! -f "$input/SKILL.md" ]]; then
        error "no SKILL.md found in $input"
    fi
    skill_dir="$(cd "$input" && pwd)"
else
    error "$input is not a file or directory"
fi

skill_name="$(basename "$skill_dir")"

TARGETS=(
    "$HOME/.claude/skills"
    "$HOME/.codex/skills"
    "$HOME/.gemini/skills"
)

for target_dir in "${TARGETS[@]}"; do
    safe_link "$skill_dir" "$target_dir/$skill_name"
done
