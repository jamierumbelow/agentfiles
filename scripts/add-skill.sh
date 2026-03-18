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
        echo "error: file must be named SKILL.md" >&2
        exit 1
    fi
    skill_dir="$(cd "$(dirname "$input")" && pwd)"
elif [[ -d "$input" ]]; then
    if [[ ! -f "$input/SKILL.md" ]]; then
        echo "error: no SKILL.md found in $input" >&2
        exit 1
    fi
    skill_dir="$(cd "$input" && pwd)"
else
    echo "error: $input is not a file or directory" >&2
    exit 1
fi

# The directory name becomes the skill name in each target.
skill_name="$(basename "$skill_dir")"

TARGETS=(
    "$HOME/.claude/skills"
    "$HOME/.codex/skills"
    "$HOME/.gemini/skills"
)

for target_dir in "${TARGETS[@]}"; do
    mkdir -p "$target_dir"
    link="$target_dir/$skill_name"

    if [[ -L "$link" ]]; then
        existing="$(readlink "$link")"
        if [[ "$existing" == "$skill_dir" ]]; then
            echo "  skip  $link (already linked)"
            continue
        fi
        # Symlink exists but points somewhere else — replace it.
        echo "  update $link -> $skill_dir (was $existing)"
        rm "$link"
    elif [[ -e "$link" ]]; then
        # Real file/directory — don't clobber it.
        echo "  warn  $link exists and is not a symlink, skipping" >&2
        continue
    else
        echo "  link  $link -> $skill_dir"
    fi

    ln -s "$skill_dir" "$link"
done
