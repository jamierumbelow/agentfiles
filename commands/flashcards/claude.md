# Flashcards → Mochi

Scan the Obsidian vault for unmoved flashcards, import them into Mochi, and mark them as moved.

## Step 1: Get the Mochi API key

Retrieve the API key from 1Password:

```bash
op read "op://Machine/secrets.zshrc/MOCHI_API_KEY"
```

Store this for use in subsequent API calls. If this fails, tell the user to check their 1Password setup and stop.

## Step 2: Find unmoved flashcards

Search all `.md` files under `~/workspace/vault/` for flashcard callouts that have not been moved yet. The format is:

```
> [!flashcard|Deck Name] - [ ]
> Question text (may span multiple lines)
> ---
> Answer text (may span multiple lines)
```

- The deck name comes after the pipe `|` in the callout type, before the `]`
- `- [ ]` means unmoved; `- [x]` means already moved — skip those
- The question is everything between the header line and `> ---`
- The answer is everything after `> ---` until the callout ends (first line that doesn't start with `>`, or end of file)
- Strip the leading `> ` from each content line

Collect all unmoved flashcards along with their file path and line numbers (needed for Step 4).

If no unmoved flashcards are found, tell the user and stop.

## Step 3: Fetch Mochi decks and create cards

First, fetch the list of existing decks:

```bash
curl -s -u "$MOCHI_API_KEY:" https://app.mochi.cards/api/decks/
```

The response is JSON with a `docs` array. Each deck has `id` and `name` fields.

For each flashcard:

1. **Find or create the deck**: Match the flashcard's deck name against existing deck names (case-insensitive). If there's no exact match but a similar deck exists (e.g. the flashcard says "social" and there's a deck called "Friends and Family"), ask the user which deck to use. If the user picks an existing deck, also update the deck name in the flashcard's header line in the source file to match going forward. If there's no match and no plausible similar deck, ask the user to confirm before creating a new one:
   ```bash
   curl -s -u "$MOCHI_API_KEY:" -X POST https://app.mochi.cards/api/decks/ \
     -H "Content-Type: application/json" \
     -d '{"name": "Deck Name"}'
   ```
   Cache newly created decks so you don't create duplicates within the same run.

2. **Create the card**: The card content uses Mochi's format where `---` separates front from back:
   ```bash
   curl -s -u "$MOCHI_API_KEY:" -X POST https://app.mochi.cards/api/cards/ \
     -H "Content-Type: application/json" \
     -d '{"content": "Question\n---\nAnswer", "deck-id": "deck_id_here"}'
   ```

**Important**: Mochi rate-limits to one concurrent request per account. Make API calls sequentially, not in parallel.

Report each card as it's created: deck name, question preview (first 60 chars), and success/failure.

## Step 4: Mark flashcards as moved

For each successfully imported flashcard, edit the source file to change `- [ ]` to `- [x]` on the flashcard's header line. For example:

```
> [!flashcard|Deck Name] - [ ]
```

becomes:

```
> [!flashcard|Deck Name] - [x]
```

Use the Edit tool for this — match the exact header line.

## Step 5: Summary

Present a summary:

```
## Flashcards imported

- **N** cards imported to Mochi
- **Decks**: [list of deck names used, with count per deck]
- **Files modified**: [list of files where flashcards were marked]
```

If any cards failed, list them separately with the error.
