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

Make API calls sequentially — Mochi enforces **one concurrent request per account**. Wait for each response before sending the next. Use 5-second gaps when doing bulk operations; use exponential backoff (starting at 5s) on 429.

### 3b. Cards with images

If a flashcard's question includes an Obsidian image embed (`![[filename.jpg]]`), the image must be uploaded as a Mochi attachment and the content reference updated. Do this **after** the card is created.

**Step 1 — Upload the attachment** (multipart form, one per card):

```bash
curl -s -u "$MOCHI_API_KEY:" \
  -X POST "https://app.mochi.cards/api/cards/$CARD_ID/attachments/$SLUG" \
  -F "file=@/path/to/image.jpg"
```

The `$SLUG` must match the regex `/[0-9a-zA-Z]{8,16}\.(jpg|jpeg|png)/` — generate a random 10-char alphanumeric string + extension. Example: `aB3kRt9mXq.jpg`.

**Step 2 — Update the card content** to reference the attachment:

```bash
curl -s -u "$MOCHI_API_KEY:" \
  -X POST "https://app.mochi.cards/api/cards/$CARD_ID" \
  -H "Content-Type: application/json" \
  -d "{\"content\": \"![](@media/$SLUG)\nQuestion text\n---\nAnswer\"}"
```

The `![](@media/slug)` syntax is how Mochi resolves card attachments in markdown. The update endpoint is `POST /api/cards/:id` (not PATCH or PUT — those return 404).

**Important gotchas discovered in practice:**
- The `attachments` key in the card create/update body is deprecated and returns 422 — always use the separate upload endpoint
- The rate limit error "Please wait for the previous request to finish" means a previous request is still processing server-side — wait 5+ seconds, not just until you receive a response
- If the upload succeeds but the content update fails, the attachment persists on the card — just re-run the content update step; no need to re-upload
- Slug filenames: 8–16 alphanumeric chars only (no hyphens or underscores), then the extension

**Python pattern for image cards:**

```python
import random, string, time, os, base64, urllib.request, json

def random_slug(ext, n=10):
    chars = ''.join(random.choices(string.ascii_letters + string.digits, k=n))
    return chars + ext

def upload_attachment(card_id, slug, file_path, api_key):
    auth = base64.b64encode(f"{api_key}:".encode()).decode()
    boundary = "----B" + ''.join(random.choices(string.ascii_letters, k=16))
    with open(file_path, 'rb') as f:
        file_data = f.read()
    ext = os.path.splitext(file_path)[1].lower()
    mime = "image/jpeg" if ext in (".jpg", ".jpeg") else "image/png"
    body = (
        f"--{boundary}\r\n"
        f'Content-Disposition: form-data; name="file"; filename="{slug}"\r\n'
        f"Content-Type: {mime}\r\n\r\n"
    ).encode() + file_data + f"\r\n--{boundary}--\r\n".encode()
    req = urllib.request.Request(
        f"https://app.mochi.cards/api/cards/{card_id}/attachments/{slug}",
        data=body,
        headers={"Authorization": f"Basic {auth}",
                 "Content-Type": f"multipart/form-data; boundary={boundary}"},
        method="POST")
    with urllib.request.urlopen(req) as r:
        return r.read()

def update_card_content(card_id, new_content, api_key):
    auth = base64.b64encode(f"{api_key}:".encode()).decode()
    data = json.dumps({"content": new_content}).encode()
    req = urllib.request.Request(
        f"https://app.mochi.cards/api/cards/{card_id}",
        data=data,
        headers={"Authorization": f"Basic {auth}", "Content-Type": "application/json"},
        method="POST")
    with urllib.request.urlopen(req) as r:
        return json.loads(r.read())

# For each image card after creation:
# ext = ".jpg"
# slug = random_slug(ext)
# upload_attachment(card_id, slug, "/path/to/image.jpg", api_key)
# time.sleep(5)
# new_content = content.replace("![[image.jpg]]", f"![](@media/{slug})")
# update_card_content(card_id, new_content, api_key)
# time.sleep(5)
```

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
