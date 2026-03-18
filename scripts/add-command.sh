#!/usr/bin/env bash
#
# add-command — register a slash-command with every AI coding tool at once.
#
# Unlike skills (which share a uniform SKILL.md convention), each tool
# has its own command format:
#   Claude Code : ~/.claude/commands/<name>.md
#   Gemini CLI  : ~/.gemini/commands/<name>.toml
#   Codex       : (no commands — uses skills instead)
#
# A "command" is a directory containing one or both of:
#   claude.md   — the Claude Code version
#   gemini.toml — the Gemini CLI version
#
# This script symlinks each file into the correct tool directory.
#
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib.sh"

usage() {
    cat <<EOF
Usage: $(basename "$0") <path> [--name <name>]

Symlink a command into the global commands directories for Claude Code
and Gemini CLI.

<path> must be a directory containing one or both of:
  - claude.md     (Claude Code command)
  - gemini.toml   (Gemini CLI command)

Options:
  --name <name>   Override the command name (default: directory basename).
                   Use slashes for nested commands (e.g. gsd/help).

The files are symlinked as:
  ~/.claude/commands/<name>.md    (from claude.md)
  ~/.gemini/commands/<name>.toml  (from gemini.toml)

Examples:
  $(basename "$0") commands/deslop
  $(basename "$0") commands/gsd-help --name gsd/help
EOF
    exit 1
}

[[ $# -lt 1 ]] && usage

input=""
cmd_name=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --name)
            [[ $# -lt 2 ]] && error "--name requires an argument"
            cmd_name="$2"
            shift 2
            ;;
        -h|--help)
            usage
            ;;
        *)
            [[ -n "$input" ]] && error "unexpected argument: $1"
            input="$1"
            shift
            ;;
    esac
done

[[ -z "$input" ]] && usage

[[ ! -d "$input" ]] && error "$input is not a directory"

cmd_dir="$(cd "$input" && pwd)"

has_claude=false
has_gemini=false
[[ -f "$cmd_dir/claude.md" ]]    && has_claude=true
[[ -f "$cmd_dir/gemini.toml" ]]  && has_gemini=true

if ! $has_claude && ! $has_gemini; then
    error "$input contains neither claude.md nor gemini.toml"
fi

[[ -z "$cmd_name" ]] && cmd_name="$(basename "$cmd_dir")"

$has_claude && safe_link "$cmd_dir/claude.md"   "$HOME/.claude/commands/${cmd_name}.md"
$has_gemini && safe_link "$cmd_dir/gemini.toml" "$HOME/.gemini/commands/${cmd_name}.toml"
