---
name: commit
description: >-
  Format git commit messages following project conventions. Use when the user
  asks to commit changes, write a commit message, or review staged changes for
  committing.
---

# Commit Messages

## Rules

- **Lowercase only** — no capital letters anywhere in the message
- **Single line** — no multi-line bodies or descriptions
- **Concise** — say what changed and why in as few words as possible
- **Area prefix** — prefix with the area of the codebase that was changed, followed by a colon and space

## Format

```
<area>: <short description>
```

`<area>` is the top-level directory, module, or domain that best describes where the change lives (e.g. `transactions`, `auth`, `tools`, `scripts`, `docs`).

## Examples

**Good:**

```
transactions: add new transaction type
tools: remove web viewer, not needed
auth: change from auth0 to custom auth provider
```

**Bad:**

```
Add new transaction type
```

Not lowercase, no area prefix.

```
Remove web viewer, not needed:

* Updates package.json to remove tool call
* Remove files from tools/
```

Multi-line. Keep it to a single line.

```
Changes from auth0 to custom auth provider
```

No area prefix.
