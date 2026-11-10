# End Day

Evening wrap-up ritual, the counterpart to `/start-day`. **This command is interactive — Jamie must be present.** Its whole purpose is to create small moments where Jamie generates his own thinking — the flashcard phrasing and the occasional taste answer. The agent does everything _around_ those moments (searching, formatting, filing, syncing) but never the generating itself. Do not answer for him, and do not write flashcards he hasn't approved.

Target: the whole ritual should take Jamie about five minutes.

## Step 1: Locate today's note

The daily file lives at `~/workspace/vault/daily/YYYY/MM/YYYY-MM-DD.md`. If it doesn't exist, create it from `~/workspace/vault/templates/daily.md` as `/start-day` does (month directory, `{{time}}` replaced).

Read through the day's note, paying particular attention to the `## Journal` section. Jamie logs to this section over the course of the day, and may add todos or things to remember here. Read through it and ensure that you capture everything relevant; Jamie would much rather see more noise than lose some signal.

## Step 1.5: Log the workout

Read today's `## Workout` section. Jamie ticks the session and writes notes under it in shorthand, or pastes in what Strong or Whoop recorded.

- **Ticked, with notes:** add the session to `~/workspace/vault/evergreen/workout-log.md` (see below).
- **Ticked, no notes:** log the session name only. Don't ask for sets or reps.
- **Unticked, and a session was planned:** ask once whether he got it in, naming the session ("Did you get Full Body in?"). If he did, tick it and log what he says. If he didn't, log `*Skipped.*` plus his reason if he gives one. The log already records skips, and they show patterns.
- **Rest day, or no section:** skip this step.

In the log, put the session under the current week's heading, `## Week of D Month YYYY` with Monday's date. Create the heading after the last entry if it isn't there yet, with a `---` above it. Then add `### Weekday D — Session`. Copy the existing entries' format: a table per lift with one column per set (`16kg x 8`), and runs as `**Run** — 3.0km, 6:40/km, avg HR 155bpm, 129m elevation`, with only the fields he gave. Keep his comments as written, in italics. Don't invent or pad numbers. If the session is already in the log (logged earlier in the day), don't add it twice.

Then update that session's entry in `## Next targets` in `~/workspace/vault/evergreen/workout-plan.md`: the next weight and reps for each lift, with what he did in brackets. Go up a step only when he hit the top of the rep range on every set; if he went past the range, go up more than a step. Carry over anything he said about pain or form.

## Step 2: Harvest SRS candidates (silently, before talking to Jamie)

Gather candidate **facts worth remembering** from these sources only:

- Today's `## Journal` section — Jamie flags anything he wants to remember there
- Recent Readwise highlights (last day or two), via the `readwise` skill

Do **not** mine the `## Worklog` or coding-agent sessions (cass) for candidates. Work findings are the agents' learning, not Jamie's; he rejected every worklog-derived candidate when this was tried.

Distill to a shortlist of **3–7 one-line facts**, each with its source. These are facts, not cards — "Mochi's API allows one concurrent request per account (learned during sync debugging)", not question/answer pairs. Selection criteria:

- Prefer durable knowledge: mechanisms, numbers, definitions, gotchas likely to recur
- Skip ephemera: PR numbers, today's todo states, one-off incident details
- Skip things Jamie obviously already knows cold

If nothing qualifies, say so plainly. Never pad the list to look productive.

## Step 3: Occasional taste question

There is no journal prompt; Jamie writes the Journal himself during the day. Do not ask "what did you learn today?" or similar.

Ask one short question only when either is true (otherwise skip straight to step 4):

- Today's note mentions something he ate, read, watched, listened to, or stayed at — ask how it was
- Otherwise, roughly one evening in three (`$(( 10#$(date +%j) % 3 )) -eq 0`) — ask about the thinnest file among `FOOD`, `TRAVEL`, `MUSIC`, `SCREEN`, and `BOOKS` in `personhood/`, e.g. "A hotel you'd go back to, and why?" or "An album you've had on repeat lately?"

One question, answerable in a sentence. File the answer per the `personhood` skill's taste format (Loved / Liked / Didn't work / Want to try, his words for the why) and log it in `updates.md`. Passing is fine; don't re-ask the same question the next time.

## Step 4: Build flashcards together

Present the shortlist from step 2. For each fact Jamie wants to keep:

- Jamie supplies or approves the phrasing — especially the answer, which should be in words he'd naturally recall
- Format as a flashcard callout under `## Flashcards` per the `flashcards` skill, checkbox `- [ ]`
- Questions use the "Thing / property" format ("Mochi API / concurrency limit"), not natural-language questions

Skipped candidates are simply dropped — they don't carry over.

## Step 5: Sync to Mochi

Run the import from the `flashcards` skill for all unsynced `- [ ]` cards across the vault (not just today's). Mark synced cards `- [x]`. Report the count and any failures.

## Step 6: Close out the day

- Ask if anything should go under `## Tomorrow`.
- Tick `/end-day` in the `## Everyday` checklist. If other Everyday items are unchecked, mention them once, without nagging.
- Run `~/workspace/repos/agentfiles-private/scripts/sync-personhood.sh` so tonight's answers reach the claude.ai project. If it pushed, remind Jamie that the project picks up changes only when he taps sync on the GitHub source in claude.ai.
- Write a closing worklog entry with `worklog-append 'wrapping up. N cards to Mochi.'`

## Summary

End with a compact recap:

```
## Day closed

- Workout: [session logged / skipped / rest day]
- Flashcards: N created, M synced to Mochi
- Tomorrow: [items or "nothing queued"]
```
