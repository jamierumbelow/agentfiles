# End Day

Evening wrap-up ritual, the counterpart to `/start-day`. **This command is interactive — Jamie must be present.** Its whole purpose is to create two small moments where Jamie generates his own thinking. The agent does everything *around* those moments (searching, formatting, filing, syncing) but never the generating itself. Do not answer the journal questions for him, and do not write flashcards he hasn't approved.

Target: the whole ritual should take Jamie about five minutes.

## Step 1: Locate today's note

The daily file lives at `~/workspace/vault/daily/YYYY/MM/YYYY-MM-DD.md`. If it doesn't exist, create it from `~/workspace/vault/templates/daily.md` as `/start-day` does (month directory, `{{time}}` replaced).

## Step 2: Harvest SRS candidates (silently, before talking to Jamie)

Gather candidate **facts worth remembering** from today's sources. Run these in parallel where possible:

- Today's daily note (worklog entries often contain gotchas and mechanisms)
- Today's sessions across coding agents, via the `cass` skill — look for things *learned*: API quirks, mechanisms, numbers, names, sharp distinctions, mistakes that taught something
- Recent Readwise highlights (last day or two), via the `readwise` skill
- Anything else Jamie flagged during the day as worth remembering

Distill to a shortlist of **3–7 one-line facts**, each with its source. These are facts, not cards — "Mochi's API allows one concurrent request per account (learned during sync debugging)", not question/answer pairs. Selection criteria:

- Prefer durable knowledge: mechanisms, numbers, definitions, gotchas likely to recur
- Skip ephemera: PR numbers, today's todo states, one-off incident details
- Skip things Jamie obviously already knows cold

If nothing qualifies, say so plainly. Never pad the list to look productive.

## Step 3: Journal prompts

Ask Jamie these two questions, one at a time, and wait for his answers:

1. **"What's one thing you learned today?"**
2. **"What's one thing you're chewing on?"**

File each answer under `## Journal` in today's note, prefixed with `HH:MM - `, **verbatim**. No cleanup, no embellishment, no expansion — this deliberately overrides the vault's usual "clean up and embellish" instruction. The Journal is Jamie's voice; rough phrasing is the point. (Fixing an obvious typo is fine only if he asks.)

Follow-ups:

- If an answer clearly relates to an existing evergreen note or an open question, offer to cross-file it — append his words verbatim, with today's date, to the evergreen note or `personhood/PROBLEMS.md`. Only do this if he says yes.
- If an answer to question 1 is fact-shaped, suggest it as a flashcard candidate in step 4.
- He can pass on either question. Record nothing and move on — one light remark at most, no guilt-tripping.

## Step 4: Build flashcards together

Present the shortlist from step 2 (plus anything from step 3). For each fact Jamie wants to keep:

- Jamie supplies or approves the phrasing — especially the answer, which should be in words he'd naturally recall
- Format as a flashcard callout under `## Flashcards` per the `flashcards` skill, checkbox `- [ ]`
- Questions use the "Thing / property" format ("Mochi API / concurrency limit"), not natural-language questions

Skipped candidates are simply dropped — they don't carry over.

## Step 5: Sync to Mochi

Run the import from the `flashcards` skill for all unsynced `- [ ]` cards across the vault (not just today's). Mark synced cards `- [x]`. Report the count and any failures.

## Step 6: Close out the day

- Ask if anything should go under `## Tomorrow`.
- Tick `/end-day` in the `## Everyday` checklist. If other Everyday items are unchecked, mention them once, without nagging.
- Write a closing worklog entry via the `worklog` skill, e.g. `HH:MM - wrapping up. Journal written, N cards to Mochi.`

## Summary

End with a compact recap:

```
## Day closed

- Journal: 2 entries (cross-filed to [[note]])
- Flashcards: N created, M synced to Mochi
- Tomorrow: [items or "nothing queued"]
```
