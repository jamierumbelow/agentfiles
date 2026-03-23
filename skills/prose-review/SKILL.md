---
name: prose-review
description: >-
  Review a piece of writing against the vault STYLEGUIDE. Flags AI tells,
  voice drift, weak structure, and missed opportunities for specificity.
  Works on vault files or text in conversation.
---

# Prose Review

Review a piece of writing and improve it. The goal is to make the prose sound
like Jamie wrote it, not like an AI generated it.

Before doing anything, read `~/workspace/vault/STYLEGUIDE.md`. That file is
the authority. If it contradicts something in this skill, the STYLEGUIDE wins.

## What to look for

Work through these in order. The first two categories are the highest
priority because they're the most common failure modes when an agent has
contributed to or drafted the text.

### 1. AI slop

The most important pass. These are the tells that make prose read as
machine-generated. Flag every instance:

- **Em dashes as connectors.** The STYLEGUIDE bans them outright. Replace
  with semicolons, commas, parentheses, or restructure the sentence.
- **Hedge words without purpose.** "somewhat," "fairly," "relatively,"
  "arguably," "it's worth noting that." Cut them unless they're doing real
  epistemic work (the STYLEGUIDE distinguishes honest hedging from filler).
- **Formal transitions.** "Furthermore," "Additionally," "Moreover," "In
  conclusion," "It is important to note." These are almost never needed.
  The structure should carry the reader forward without signposts.
- **Soft concluding paragraphs.** The generic wrap-up that restates what was
  already said. Jamie's pieces end with open questions, plain conclusions,
  or just stop when they're done.
- **Passive constructions that hide the actor.** "It has been argued that" --
  by whom? "Mistakes were made" -- by whom? Jamie names things.
- **Generic intensifiers.** "very," "really," "incredibly," "extremely."
  Almost always deletable.
- **Throat-clearing openings.** "In today's world," "It goes without saying,"
  "When it comes to X." Start with the thing itself.

### 2. Voice and register

The STYLEGUIDE defines several registers. Check whether the piece is in the
right one and staying consistent:

- **Analytical essays** should be forensic, patient, evidence-driven.
  Assertive when warranted, honest when uncertain.
- **Personal/literary essays** should be sensory, reflective, with longer
  flowing sentences and specific detail.
- **Tech/product writing** should celebrate craft, argue against orthodoxies,
  use detailed examples.
- **Newsletter/blog** should be conversational, engage the reader directly.

A piece that drifts between registers without purpose reads as unfocused.
Flag it if you see it, but don't force everything into one mode; some pieces
legitimately shift register (e.g. from analytical to personal).

### 3. Specificity

Jamie's writing is distinguished by concrete detail. Look for places where
the text is vague and a specific reference exists:

- A claim without a source that could have one.
- "Some companies" when specific names would be stronger.
- "Recently" when a date or timeframe would be better.
- "Research shows" without citing the research.
- Round numbers or hedged statistics when precise ones are available.

Don't invent specifics. Flag the gap and suggest where to look, or leave a
placeholder like `[cite needed]` or `[specific example here]`.

### 4. Structure

Check against the STYLEGUIDE's structural patterns:

- Does it open by framing a question or observation?
- Are complex arguments broken into enumerated lists?
- Do paragraphs run 3-8 sentences in prose sections?
- Does it end with an open question or a plain conclusion (not a soft recap)?
- For longer pieces: is there a roadmap near the top?

### 5. Sentence-level craft

- Medium-to-long sentences with subordinate clauses. Not staccato.
- Short sentences used sparingly, for emphasis. Not as the default rhythm.
- Semicolons joining related clauses (regular but not excessive).
- Parenthetical asides for clarification or dry humour.
- Oxford comma, always.

## How to present findings

Two modes depending on how the skill was triggered.

**When reviewing a file** (the usual case): make the edits directly in the
file. For each substantive change, leave a brief inline comment or note in
the conversation explaining what you changed and why. Group changes by
category (slop, voice, specificity, structure, sentence-level) so Jamie
can review them coherently.

**When reviewing text in conversation** (Jamie pastes something and asks for
feedback): present a marked-up version with changes and explain the reasoning.
Don't just list problems; show the fix.

## What not to do

- Don't rewrite the piece in your own voice. The goal is to make it sound
  more like Jamie, not more like a polished AI draft.
- Don't add content. If a section is thin, flag it; don't fill it in
  (unless Jamie asks).
- Don't restructure unless the structure is clearly broken. Minor
  reordering is fine; moving whole sections around is a conversation.
- Don't touch worklog entries, daily notes, or other informal vault content
  unless specifically asked. This skill is for essays, blog posts, and
  published writing.
- Don't normalise British/American spelling -- Jamie uses British English,
  but if a piece has American spellings, flag rather than silently change
  (it might be intentional for the publication).
