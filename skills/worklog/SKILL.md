---
name: worklog
description: >-
  Write timestamped entries to the daily worklog in the Obsidian vault.
  Use proactively after completing tasks, making commits or PRs, finishing
  research, or reaching any meaningful milestone. Do not wait to be asked.
---

# Daily Worklog

Write timestamped entries to the daily worklog at `~/workspace/vault/daily/`.

## Finding today's file

The daily file lives at:

```
~/workspace/vault/daily/YYYY/MM/YYYY-MM-DD.md
```

Use `date` to get the current date and time:

```bash
date +%Y          # year directory
date +%m          # month directory
date +%Y-%m-%d    # filename
date +%H:%M       # timestamp for entries
```

If today's file does not exist, create the month directory (`mkdir -p`) and copy the template from `~/workspace/vault/templates/daily.md`, replacing `{{time}}` with the current `HH:MM`.

## Writing entries

Append entries under the `## Worklog` section. Do not modify any other section (`## Everyday`, `## Todos`, `## Tomorrow`).

**Format:** `* HH:MM - entry text`

Always re-read the file before appending, to avoid overwriting entries from other agents.

## Style

Casual, fragmentary, present-tense. Incomplete sentences are fine. The goal is raw thought capture, not polished prose. But entries should still be:

- Clear enough to be useful when re-read later
- Specific rather than vague (name the file, the PR, the decision)
- Concise; say it once, say it well
- British English
- No em dashes

## When to write

- After completing a task or subtask
- After making a commit or PR
- After finishing research or investigation
- After any significant decision or milestone

## When NOT to write

- Not after every small file edit or read
- Not for failed attempts unless they are informative
- Do not duplicate entries already in today's worklog
