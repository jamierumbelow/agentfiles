# Start Day

Morning briefing command. Run through each step below in order, then present a summary to the user.

## Step 1: Create today's daily note

The daily file lives at `~/workspace/vault/daily/YYYY/MM/YYYY-MM-DD.md`. Use `date` to get the current date.

If today's file does not exist, create the month directory (`mkdir -p`) and copy the template from `~/workspace/vault/templates/daily.md`, replacing `{{time}}` with the current `HH:MM`.

If it already exists, note that and move on.

## Step 2: Pull forward yesterday's "Tomorrow" items

Find the most recent daily note before today (check yesterday first, then go back up to 7 days). Read its `## Tomorrow` section.

If there are any items listed, add them to today's `## Todos` section (after any existing todos, before any blank line or next section). Do not duplicate items that are already in today's todos.

If the previous day's Tomorrow section is empty or the file doesn't exist, skip this step.

## Step 3: Scan for dropped todos

Look at the last 5 daily notes (excluding today). Collect any unchecked `- [ ]` items from their `## Todos` sections.

If there are unchecked items, deduplicate them and add them all to today's `## Todos` section (after any existing todos). Mention them in the briefing summary so Jamie knows what was pulled in.

## Step 4: Fetch today's calendar

Run the precompiled EventKit binary:

```bash
~/.claude/bin/calendar-today
```

This reads the local calendar cache via EventKit — fast and doesn't depend on Calendar.app being responsive. If the binary is missing, recompile it:

```bash
swiftc -O -o ~/.claude/bin/calendar-today ~/.claude/bin/calendar-today.swift
```

Format the output for the briefing:
- Events with `00:00-23:59` are all-day events; list them separately
- Sort timed events chronologically
- Skip holiday calendar noise (public holidays, religious observances) unless they're relevant to the user's country (UK/US)

## Step 5: Email triage via letterhead

### 5a: Sync and health check

Run `letterhead sync` to pull new messages, then `letterhead status --json` to confirm the archive is healthy. Note the total message count and last sync time.

If `letterhead` is not installed or returns an error (e.g. exit code 6 for not initialized), skip this entire step and note it in the briefing as "letterhead: not configured".

### 5b: Fetch recent emails

Check what day of the week it is. If it's Monday, look back to Friday; otherwise look back to yesterday. Use the appropriate date as the `--after` value:

```bash
letterhead find --after <lookback date YYYY-MM-DD> --limit 50 --json
```

### 5c: Read and triage

For the threads returned, read any that look like they might need action (use `letterhead read <read_handle> --view text` to get the body). Use your judgement — prioritise threads that look like they contain requests, deadlines, decisions, or action items over newsletters, notifications, and automated messages.

Categorise each actionable thread into one of:

- **Today** — needs a reply or action today (explicit deadlines, direct requests, time-sensitive)
- **This week** — important but not urgent (follow-ups, reviews, things with a few days' runway)
- **FYI** — worth knowing about but no action needed right now

Skip anything that's clearly noise (automated notifications, marketing, CI alerts).

### 5d: Create todos

For each **Today** and **This week** item, add a `- [ ]` todo to today's daily note under `## Todos`. Prefix with `[email]` so they're easy to spot. Include the sender and a short description, e.g.:

```
- [ ] [email] Reply to Alice re: Q2 budget review (deadline today)
- [ ] [email] Review draft from Bob — feedback by Thursday
```

Don't duplicate items that already exist in today's todos.

## Step 6: Update cass index

Run `cass health --json`. If the exit code is non-zero, run `cass index --full`
to rebuild. If healthy, run `cass index` to pick up any new sessions since the
last index. Report the status briefly in the briefing (e.g. "cass: healthy,
2,500 conversations indexed" or "cass: rebuilt index").

## Step 7: Git status across workspace repos

For each directory in `~/workspace/repos/*/`, run:
- `git status --porcelain` to check for uncommitted changes
- `git branch --show-current` to get the current branch

Only report repos that have uncommitted changes or are on a branch other than `main`/`master`. Skip clean repos on their default branch.

Run these in parallel where possible to keep things fast.

## Step 8: Write a worklog entry

Use the `worklog` skill to write an entry like:

```
* HH:MM - starting the day. N meetings today, M repos with uncommitted work.
```

Adjust the content based on what you found in the previous steps. Keep it brief.

## Presenting the briefing

After all steps are complete, present a formatted summary to the user:

```
## Good morning

**Date:** [today's date, formatted nicely]

### Calendar
[all-day events, then timed events in order]

### Todos pulled forward
[items from yesterday's Tomorrow section, if any]

### Dropped todos pulled in
[unchecked items from recent days that were added to today's Todos, if any]

### Email
[N new messages since yesterday]

**Today:**
[threads needing action today, with sender and subject]

**This week:**
[threads needing action this week]

**FYI:**
[notable threads, no action needed]

### Repo status
[repos with uncommitted work or non-default branches]

### cass
[index status: healthy/rebuilt, conversation count]

### Daily note
[created / already existed]
```

Keep it clean and scannable. The user wants to glance at this and know what their day looks like.
