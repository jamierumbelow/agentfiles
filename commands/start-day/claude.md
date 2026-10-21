# Start Day

Morning briefing command. Run through each step below in order, then present a summary to the user.

## Step 1: Create today's daily note

The daily file lives at `~/workspace/vault/daily/YYYY/MM/YYYY-MM-DD.md`. Use `date` to get the current date.

If today's file does not exist, create the month directory (`mkdir -p`) and copy the template from `~/workspace/vault/templates/daily.md`, replacing `{{time}}` with the current `HH:MM`.

If the template is missing (e.g. the vault is still syncing on a new machine), create the file with empty `## Todos`, `## Tomorrow`, `## Journal` and `## Worklog` sections instead, and mention it in the briefing.

If it already exists, note that and move on.

## Step 2: Pull forward yesterday's "Tomorrow" items

Find the most recent daily note before today (check yesterday first, then go back up to 7 days). Read its `## Tomorrow` section.

If there are any items listed, add them to today's `## Todos` section (after any existing todos, before any blank line or next section). Do not duplicate items that are already in today's todos.

If the previous day's Tomorrow section is empty or the file doesn't exist, skip this step.

## Step 3: Scan for dropped todos

Look at the last 5 daily notes (excluding today). Collect any unchecked `- [ ]` items from their `## Todos` sections.

If there are unchecked items, deduplicate them and add them all to today's `## Todos` section (after any existing todos). Mention them in the briefing summary so Jamie knows what was pulled in.

## Step 3.5: Check whether yesterday's /end-day ran

Look at the most recent daily note before today (the same one from Step 2). If its `## Journal` section is empty or missing, Jamie skipped `/end-day` — and he has explicitly asked to be told off for this. Include a short, genuine scolding in the briefing (one or two sentences, pointed but good-humoured) reminding him the 5pm reminder exists for a reason. If several recent days in a row have empty Journals, say so — the streak is part of the telling-off.

If yesterday's Journal has entries, skip this silently.

## Step 4: Fetch today's calendar

Use the Google Calendar MCP connector to list today's events (midnight to midnight, local time) across all of Jamie's calendars. Include each event's time, title, and whether it has other attendees or a video link.

If the connector isn't connected or returns an error, skip this step and note it in the briefing as "calendar: not connected".

Format the output for the briefing:
- List all-day events separately
- Sort timed events chronologically
- Skip declined events
- Skip holiday calendar noise (public holidays, religious observances) unless they're relevant to the user's country (UK/US)

## Step 5: Email triage via Gmail

If the Gmail MCP connector isn't connected or returns an error, skip this entire step and note it in the briefing as "email: not connected".

### 5a: Fetch recent emails

Check what day of the week it is. If it's Monday, look back to Friday; otherwise look back to yesterday. Search the inbox for threads since that date (Gmail query `in:inbox after:YYYY/MM/DD`), up to about 50 threads.

### 5b: Read and triage

For the threads returned, read any that look like they might need action. Use your judgement — prioritise threads that look like they contain requests, deadlines, decisions, or action items over newsletters, notifications, and automated messages.

Categorise each actionable thread into one of:

- **Today** — needs a reply or action today (explicit deadlines, direct requests, time-sensitive)
- **This week** — important but not urgent (follow-ups, reviews, things with a few days' runway)
- **FYI** — worth knowing about but no action needed right now

Skip anything that's clearly noise (automated notifications, marketing, CI alerts).

### 5c: Create todos

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

### End-day check
[scolding if yesterday's Journal is empty; omit section entirely if it ran]

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
