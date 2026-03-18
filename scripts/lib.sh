# lib.sh — shared helpers for add-skill / add-command.
# Sourced, not executed directly.

source "$HOME/framework.sh"

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
            info "Linked $link -> $source"
            return 0
        fi
        info "Updated $link -> $source (was $existing)"
        rm "$link"
    elif [[ -e "$link" ]]; then
        warn "$link exists and is not a symlink, skipping"
        return 0
    else
        info "Linked $link -> $source"
    fi

    ln -s "$source" "$link"
}
