---
name: worklog
description: >-
  Append timestamped entries to Jamie's daily worklog in
  `~/workspace/vault/daily/`. Use proactively after completing tasks, making
  commits or PRs, finishing research, or reaching any meaningful milestone.
  Preserve the day's local formatting and write alongside Jamie rather than in
  generic assistant prose.
---

# Worklog

Use this skill whenever work in the current session reaches a point Jamie would
want captured in the daily note.

The daily note is a shared running log between Jamie and agents. Treat it as a
live collaborative document, not as an append-only machine trace.

## Writing style

Write in the worklog register from `~/workspace/vault/STYLEGUIDE.md`:

- casual, fragmentary, present-tense
- concise, but specific enough to be useful later
- British English
- no em dashes

If Jamie gives rough shorthand, rewrite it into a clean entry that fits the
note. Name the repo, PR, file, decision, or outcome when that makes the entry
more useful.

Avoid generic assistant phrasing such as "completed the task", "successfully
implemented", or "investigated the codebase". Write like a collaborator keeping
notes during the day.

## Debuzz the entry before appending

Draft the entry, then run it through the `debuzz` skill in **`vault` mode** and
append what comes back. Worklog entries are the highest-volume agent prose in
the vault, and an independent editor catches the assistant register more
reliably than re-reading your own draft does.

Keep the timestamp prefix, `[[wiki-links]]`, `#tags`, PR links, commit SHAs, and
backticked paths byte-identical. Check the result for em dashes before writing;
the STYLEGUIDE bans them and a rewrite is where they creep in.

Skip the pass for one-line entries, `## Todos` items, and checkbox or status
changes. There is no register to fix and the call costs about ten seconds.

If `agy` is unavailable, append the entry as drafted and mention that the pass
was skipped. Never substitute your own rewrite.

## File location

Today's file lives at:

```text
~/workspace/vault/daily/YYYY/MM/YYYY-MM-DD.md
```

Use `date` to get the path components and timestamp:

```bash
date +%Y
date +%m
date +%Y-%m-%d
date +%H:%M
```

If today's file does not exist:

1. Create the month directory.
2. Copy `~/workspace/vault/templates/daily.md`.
3. Replace `{{time}}` in the template with the current `HH:MM`.

If your sandbox blocks writes to `~/workspace/vault`, request escalation rather
than skipping the log entry.

Default to today's note. Only backfill another day's worklog if Jamie
explicitly asks.

## Safe append workflow

1. Read today's file immediately before editing.
2. Find the `## Worklog` section.
3. Inspect the existing entries in that section and match the local format.

Match the format already in use for that day:

- plain style: `HH:MM - entry text`
- bulleted style: `* HH:MM - entry text`
- if the section is empty or the file was just created, use the template's
  plain `HH:MM - entry text` style

Preserve the surrounding spacing and punctuation. Do not normalise older
entries, rewrite Jamie's prose, or silently convert a plain day into a bulleted
day.

Append only inside `## Worklog`. Do not modify `## Everyday`, `## Todos`,
`## Flashcards`, or `## Tomorrow` unless Jamie asked for that specifically.

## Todo tags

Every item in `## Todos` should end with one of these tags:

- `#work` — World / professional tasks
- `#life` — life admin, family, personal finance
- `#side-projects` — side projects (e.g. lgtm)

When adding new todos or carrying them forward to a new day, always include the
appropriate tag at the end of the line.

If `## Worklog` is missing, add it at the end of the file and append the new
entry there.

Because this file is shared, re-read or patch carefully enough to avoid
overwriting entries another agent or Jamie may have added since your earlier
read.

## What to log

- completed tasks or meaningful subtasks
- commits, PRs, merges, and releases
- finished research with findings, not just "looked into X"
- decisions, discoveries, blockers, and handoffs
- explicit user requests to add or tidy worklog notes

Prefer outcome over process noise. If several tiny steps add up to one
meaningful milestone, collapse them into one entry.

## What not to log

- every small file read or edit
- failed attempts with no learning value
- duplicate status already captured in today's note
- generic bookkeeping such as "starting work", unless it adds real context

## Entry shape

Good entries usually answer one or more of these:

- What changed?
- What was decided?
- What did we learn?
- Why does it matter?

Keep each entry to one coherent milestone. Use links when they make the note
more valuable on reread.

## Examples

```text
11:43 - Added `write-dtos` skill to ABM. Covers the kebab-case GET / camelCase POST rule, response DTOs, validation, pagination, and inheritance patterns.

17:31 - PR created: [infrastructure#37957](https://github.com/worldcoin/infrastructure/pull/37957).

18:58 - Read through a Polsia ops JSON snapshot. Pulled out growth rates, ad performance, execution mix, and a few metric mismatches for a quick sanity check.
```
