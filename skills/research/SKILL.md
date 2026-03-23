---
name: research
description: >-
  Gather evidence, sources, data, and examples for a writing project. Searches
  the web, cass, and the vault, then drops structured findings into a research
  note. Designed for Jamie's evidence-heavy analytical writing style.
---

# Research

Gather raw material for a piece of writing. The output is a research note, not
a finished draft. The goal is to give Jamie a pile of specific, sourced,
well-organised evidence to work with.

## What good research looks like for Jamie's writing

Look at pieces like "Flying Blind," "Market Quality," and "Steam Networks" (in
the vault and at worksinprogress.co). The evidence that makes them work is:

- **Named sources with links.** Not "research shows" but a specific paper,
  article, or dataset with a URL.
- **Specific numbers.** Not "a lot of housing" but "9,300 units permitted in
  Q3 2025." Not "the system is large" but "105 miles of pipework" and
  "$3,555.43 per month standing charge." Precision is the difference between
  generic writing and Jamie's writing.
- **Named people and institutions.** James Scott, the ONS, Napoleon's
  cadastre, Birdsill Holly, Consolidated Edison. Proper nouns are always
  better than vague references. People with vivid details are even better:
  Wallace Andrews was "a popular dandy with a flair for equipage and
  flowered vests."
- **Primary source archaeology.** Dig for the original document, not the
  summary of it. Archive.org PDFs, patent records, Library of Congress
  photographs, government datasets, regulatory filings, contemporary
  accounts. "Steam Networks" cites a 1930s corporate history PDF, NYC
  Department of Buildings data, and ConEd engineering specifications.
  "Flying Blind" cites a National Audit, a Cambridge paper on ONS
  methodology, and specific tweets from named people.
- **Calculated examples.** Don't just report a number; show what it means in
  context. "Heating the Empire State Building would need more than 45 tons
  of coal per day, roughly two shipping containers' worth." Work out
  per-unit costs from aggregate data. Convert between units to make
  comparisons vivid.
- **Historical and international comparisons.** Jamie contextualises claims
  with precedent and cross-country evidence. Manhattan's steam vs
  Copenhagen's hot water. The ONS vs DOGE vs Gosplan. This is where the
  intellectual range shows.
- **Counterarguments and complications.** Not just evidence for the thesis,
  but evidence against it, or edge cases that need addressing. "Steam
  Networks" gives a fair hearing to steam's advantages even while
  explaining why the world moved to hot water.
- **Colourful detail that earns its place.** A good anecdote or quote is
  worth paragraphs of exposition. The anthracite user who declared that "if
  the world should take fire, the Lehigh coal mine would be the safest
  retreat." The Centralia mine fire still burning since 1962. These aren't
  decoration; they make technical material vivid and memorable. Look for
  them deliberately.

## How to research

### 1. Understand the brief

$ARGUMENTS gives a topic, thesis, or question. Before searching, clarify:

- What's the central question or argument?
- What kind of evidence would strengthen it? (data, case studies, historical
  precedent, expert opinion, counterexamples)
- What does Jamie already know about this? Check the vault and cass.

### 2. Search the vault and cass first

Before going to the web, check what already exists locally:

- Search the vault for related notes, prior writing, or worklog entries on
  the topic.
- Search cass for prior sessions where the topic came up. Jamie may have
  already discussed, debated, or researched aspects of this.

```bash
cass search "<topic>" --robot --limit 5 --fields summary --days 90
```

This grounds the research in Jamie's existing thinking and avoids duplicating
work.

### 3. Search the web

Use web search to find:

- **Primary sources**: government data, academic papers, official reports,
  legislation, company filings, engineering specifications, regulatory
  tariff schedules. These are the backbone of Jamie's writing. A ConEd
  service specification PDF or a NYC Department of Buildings dataset is
  worth more than ten news articles.
- **Archival material**: archive.org scans, Library of Congress records,
  historical photographs, patent filings, contemporary accounts. Jamie's
  historical writing draws on original documents, not Wikipedia summaries
  of them. Search archive.org directly when relevant.
- **High-quality secondary sources**: Works in Progress, Asterisk, the FT,
  The Economist, Marginal Revolution, Age of Invention, Pedestrian
  Observations, Construction Physics, and specific policy blogs Jamie reads
  (see the vault blogroll).
- **Specific data points**: statistics, survey results, time series. Look
  for numbers precise enough to calculate from. Per-unit costs, per-capita
  figures, conversion factors, rates of change.
- **Named experts, inventors, and characters.** People make technical
  writing vivid. Find out who did the thing, what they were like, what they
  said about it.
- **Counterarguments**: the strongest version of the opposing view.

Prefer sources Jamie would actually cite. He reads widely across economics,
policy, technology, urbanism, history, and philosophy. Academic papers and
serious policy writing carry more weight than news aggregators or hot takes.
But a well-chosen tweet from a domain expert (named, linked) is also fair
game.

### 4. Fetch and verify

For each promising source, fetch the page to confirm it actually says what the
search snippet suggests. Pull out the specific relevant quote, statistic, or
finding. Note the author, publication, and date.

Don't include sources you haven't verified. A broken link or a misattributed
quote is worse than a gap.

## Output format

Write findings to a research note in the vault. If the piece already has a
`writing/wip/<slug>/` directory, use the `research-notes.md` file there. If
not, ask Jamie where to put it, or default to
`writing/wip/<slug>/research-notes.md` (creating the directory scaffold:
`draft.md`, `scratchpad.md`, `research-notes.md`).

Structure the note like this:

```markdown
# Research: <topic>

Gathered <date>.

## Key findings

[3-5 bullet summary of the most important things found]

## Sources

### <Source title or description>
- **Author/org**: [name]
- **URL**: [link]
- **Key point**: [1-2 sentences, or a direct quote]
- **Relevance**: [why this matters for the piece]

### <Next source>
...

## Data points

[Specific statistics, numbers, dates worth referencing]

## Counterarguments and complications

[Evidence or arguments that push against the thesis]

## Calculated examples

[Numbers worked out from raw data that make a point vivid. E.g. "At peak
output, the system consumes nearly two Olympic swimming pools' worth of
water per hour." Show your working.]

## Colourful detail

[Anecdotes, quotes, biographical colour, striking images that could make
technical material vivid. Only include if they genuinely earn their place.]

## Gaps

[Things worth knowing that the research didn't turn up. Suggests where
to look next.]

## Prior thinking (from vault/cass)

[Anything relevant found in existing notes or past sessions]
```

Keep each source entry tight. Jamie will decide what to use; the research
note is a reference, not a narrative.

## What not to do

- Don't write the essay. This is raw material, not prose.
- Don't editorialize in the research note. Present what sources say; Jamie
  will form the argument.
- Don't pad with low-quality sources to make the note look comprehensive.
  Five good sources beat twenty mediocre ones.
- Don't include sources you can't link to or haven't verified.
- Don't summarise sources so aggressively that the specific detail is lost.
  Jamie's writing depends on precision; keep the numbers, quotes, and
  proper nouns.
