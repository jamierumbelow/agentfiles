# lib.sh — shared helpers for add-skill / add-command.
# Sourced, not executed directly.

# Create or update a symlink, with idempotency.
#   safe_link <source> <link>
#
# - Skips if the link already points to source.
# - Replaces if the link points elsewhere.
# - Warns (and skips) if a real file/directory occupies the path.
# - Creates parent directories as needed.
safe_link() {
    local source="$1"
    local link="$2"

    mkdir -p "$(dirname "$link")"

    if [[ -L "$link" ]]; then
        local existing
        existing="$(readlink "$link")"
        if [[ "$existing" == "$source" ]]; then
            echo "  skip    $link (already linked)"
            return 0
        fi
        echo "  update  $link -> $source (was $existing)"
        rm "$link"
    elif [[ -e "$link" ]]; then
        echo "  warn    $link exists and is not a symlink, skipping" >&2
        return 0
    else
        echo "  link    $link -> $source"
    fi

    ln -s "$source" "$link"
}
