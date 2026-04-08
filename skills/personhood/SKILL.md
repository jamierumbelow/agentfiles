---
name: personhood
description: >-
  Read and update Jamie's personhood files in `~/workspace/vault/personhood/`.
  These capture mission, worldview, books, past mistakes, narratives, goals,
  active projects, and open problems. Use when conversation touches on any of
  these topics to ground responses in Jamie's own stated positions, or when
  Jamie asks to add or revise an entry.
---

# Personhood

The `personhood/` directory in the vault is a structured self-portrait that
gives agents richer context about who Jamie is, what he believes, and what he's
working toward. Use it both as a source of context and as a living document to
update when new information surfaces.

## Files

| File            | Contents                                       |
| --------------- | ---------------------------------------------- |
| `MISSION.md`    | Life mission statement                         |
| `WORLDVIEW.md`  | Core beliefs and commitments                   |
| `BOOKS.md`      | Books that changed how he thinks               |
| `WRONG.md`      | Positions revised and lessons learned          |
| `NARRATIVES.md` | Self-stories, examined honestly (good and bad) |
| `GOALS.md`      | Near-term and long-term goals                  |
| `PROJECTS.md`   | Active projects                                |
| `PROBLEMS.md`   | Open questions and unresolved problems         |
| `updates.md`    | Changelog of all edits to the above files      |

All files live at `~/workspace/vault/personhood/`.

## When to read

- When Jamie asks a question that his stated worldview, goals, or mission would
  usefully inform
- When making suggestions about priorities, projects, or direction
- When Jamie references something he's been wrong about, a narrative he tells,
  or a book that shaped his thinking

You do not need to read every file every time. Pick the ones relevant to the
conversation.

## When to write

- Jamie explicitly asks to add or update an entry
- Conversation surfaces a clear new belief, goal, project, book, or revised
  position that Jamie confirms

Always ask before adding to WRONG.md or NARRATIVES.md; these are sensitive and
Jamie should confirm the framing.

## Writing style

Follow the vault STYLEGUIDE. These are reference pages: minimal prose, brief
editorial preamble where it adds something, then get out of the way. Annotated
lists preferred over narrative descriptions.

## Changelog

After every edit to a personhood file, append an entry to `updates.md` with the
date and a short description of what changed. Format:

```text
## YYYY-MM-DD

- FILENAME: what changed
```

## Security and Privacy

- NEVER commit to public repos
- NEVER share publicly
- Always backup before changes
