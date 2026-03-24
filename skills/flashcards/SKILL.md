---
name: flashcards
description: >-
  Flashcards → Mochi. Use when the user asks to add a flashcard, or when
  running the import to Mochi. Covers the callout format and the Mochi sync
  process.
---

# Flashcards

Flashcards live in the Obsidian vault as callouts and get batch-imported into
Mochi. This skill covers both writing and importing them.

## Writing flashcards

Add flashcards to the `## Flashcards` section of the current daily note (or
whatever file the user specifies). Use this exact callout format:

```
> [!flashcard|Deck Name] - [ ]
> Question text
> ---
> Answer text
```

- **Deck name** goes after the pipe `|`. Ask the user which deck if you're
  unsure. Common decks: Friends and Family, Geography, History, Science.
- `- [ ]` means not yet imported; `- [x]` means already synced to Mochi.
- Question and answer can span multiple lines — every line must start with `> `.
- `> ---` separates question from answer.

Do **not** use `question :: answer` syntax or any other format.

## Importing flashcards to Mochi

When the user asks to sync or import flashcards, run through these steps:

### 1. Get the Mochi API key

```bash
op read "op://Machine/secrets.zshrc/MOCHI_API_KEY"
```

If this fails, tell the user to check their 1Password setup and stop.

### 2. Find unmoved flashcards

Search all `.md` files under `~/workspace/vault/` for flashcard callouts where
the checkbox is `- [ ]`. Skip any marked `- [x]`.

Parse each callout:
- Deck name: text between `|` and `]`
- Question: lines between the header and `> ---`
- Answer: lines after `> ---` until the callout ends

Strip leading `> ` from content lines. Collect file paths and line numbers for
marking later.

### 3. Create cards in Mochi

Fetch existing decks:

```bash
curl -s -u "$MOCHI_API_KEY:" https://app.mochi.cards/api/decks/
```

For each flashcard:

1. **Match or create the deck** (case-insensitive). If the deck name is close
   but not exact (e.g. "social" vs "Friends and Family"), ask the user. If
   creating a new deck, confirm first:
   ```bash
   curl -s -u "$MOCHI_API_KEY:" -X POST https://app.mochi.cards/api/decks/ \
     -H "Content-Type: application/json" \
     -d '{"name": "Deck Name"}'
   ```

2. **Create the card**:
   ```bash
   curl -s -u "$MOCHI_API_KEY:" -X POST https://app.mochi.cards/api/cards/ \
     -H "Content-Type: application/json" \
     -d '{"content": "Question\n---\nAnswer", "deck-id": "deck_id_here"}'
   ```

Make API calls sequentially — Mochi rate-limits to one concurrent request.

### 4. Mark as moved

Change `- [ ]` to `- [x]` on each successfully imported flashcard's header line.

### 5. Summary

```
## Flashcards imported

- **N** cards imported to Mochi
- **Decks**: [list with counts]
- **Files modified**: [list]
```

List any failures separately with the error.
