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

If there are unchecked items, present them to the user as "potentially dropped todos" in the morning briefing. Do not automatically add them anywhere.

## Step 4: Fetch today's calendar

Run this AppleScript to get today's events:

```bash
osascript -e '
use scripting additions

set today to current date
set time of today to 0
set tomorrow to today + (1 * days)

set output to ""
tell application "Calendar"
    repeat with cal in calendars
        set calEvents to (every event of cal whose start date ≥ today and start date < tomorrow)
        repeat with ev in calEvents
            set evStart to start date of ev
            set evEnd to end date of ev
            set evSummary to summary of ev
            set h to hours of evStart
            set m to minutes of evStart
            if h < 10 then set h to "0" & h
            if m < 10 then set m to "0" & m
            set eh to hours of evEnd
            set em to minutes of evEnd
            if eh < 10 then set eh to "0" & eh
            if em < 10 then set em to "0" & em
            set output to output & h & ":" & m & "-" & eh & ":" & em & " " & evSummary & linefeed
        end repeat
    end repeat
end tell
return output
'
```

Format the output for the briefing:
- Events with `00:00-23:59` are all-day events; list them separately
- Sort timed events chronologically
- Skip holiday calendar noise (public holidays, religious observances) unless they're relevant to the user's country (UK/US)

## Step 5: Git status across workspace repos

For each directory in `~/workspace/repos/*/`, run:
- `git status --porcelain` to check for uncommitted changes
- `git branch --show-current` to get the current branch

Only report repos that have uncommitted changes or are on a branch other than `main`/`master`. Skip clean repos on their default branch.

Run these in parallel where possible to keep things fast.

## Step 6: Write a worklog entry

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

### Potentially dropped todos
[unchecked items from recent days, if any]

### Repo status
[repos with uncommitted work or non-default branches]

### Daily note
[created / already existed]
```

Keep it clean and scannable. The user wants to glance at this and know what their day looks like.
