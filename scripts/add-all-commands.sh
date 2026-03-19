#!/usr/bin/env bash
#
# add-all-commands — register every command in the commands/ directory.
#
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

for cmd_dir in "$REPO_DIR"/commands/*/; do
    [[ -d "$cmd_dir" ]] || continue
    "$SCRIPT_DIR/add-command.sh" "$cmd_dir"
done
