---
name: worklog
description: >-
  Append timestamped entries to Jamie's daily worklog in
  `~/workspace/vault/daily/`. Use proactively after completing tasks, making
  commits or PRs, finishing research, or reaching any meaningful milestone.
  Write alongside Jamie rather than in generic assistant prose.
---

# Worklog

The daily note is a running log shared between Jamie and agents. Add one entry
per meaningful milestone.

## Appending an entry

One command, no other steps:

```bash
worklog-append "Opened [salp#8457](https://github.com/SALP-Strategy/salp/pull/8457): By person / By page toggle on /system/access."
```

It works out today's path (`~/workspace/vault/daily/YYYY/MM/YYYY-MM-DD.md`),
creates the note from `templates/daily.md` if needed, stamps the current time,
matches the day's style (plain `HH:MM - ` or bulleted `* HH:MM - `), and
appends inside `## Worklog`. It prints the line it wrote, so there is no need
to read the note before or after. It rejects em dashes and multi-line entries;
fix the text and rerun.

Pass a single-quoted string if the text contains backticks or `$`. Only use
`--date YYYY-MM-DD` / `--time HH:MM` when Jamie asks you to backfill.

If the sandbox blocks writes to `~/workspace/vault`, request escalation rather
than skipping the entry.

## Writing style

The worklog register from `~/workspace/vault/STYLEGUIDE.md`:

- casual, fragmentary, present-tense
- concise, but specific enough to be useful later
- British English
- no em dashes

Name the repo, PR, file, decision, or outcome when that makes the entry more
useful on reread. Avoid assistant phrasing such as "completed the task",
"successfully implemented", or "investigated the codebase". Write like a
collaborator keeping notes during the day.

## What to log

- completed tasks or meaningful subtasks
- commits, PRs, merges, and releases
- finished research with findings, not just "looked into X"
- decisions, discoveries, blockers, and handoffs

Prefer outcome over process noise. Collapse several small steps into one entry.
Don't log every file edit, failed attempts with no learning value, anything
already in today's note, or "starting work".

## Editing other sections

Only touch `## Todos`, `## Tomorrow`, or other sections when Jamie asks. Then
read the note, edit it directly, and leave `## Everyday`, `## Flashcards`, and
other people's entries alone. Every `## Todos` item ends with one tag:

- `#work`: World / professional tasks
- `#life`: life admin, family, personal finance
- `#side-projects`: side projects (e.g. lgtm)

## Examples

```text
11:43 - Added `write-dtos` skill to ABM. Covers the kebab-case GET / camelCase POST rule, response DTOs, validation, pagination, and inheritance patterns.

17:31 - PR created: [infrastructure#37957](https://github.com/worldcoin/infrastructure/pull/37957).

18:58 - Read through a Polsia ops JSON snapshot. Pulled out growth rates, ad performance, execution mix, and a few metric mismatches for a quick sanity check.
```
