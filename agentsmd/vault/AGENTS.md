This is an Obsidian vault containing personal notes, writing, project planning, and a daily worklog. It is not a software project — there are no build tools, tests, or linters.

## Structure

- `daily/` — daily journal entries, organized by year. Uses the template in `templates/daily.md` (timestamped bullet points).
- `evergreen/` — Jamie's developing ideas and ongoing topics of study
- `jamierumbelow.net/` — source content for Jamie's personal website (book lists, restaurants, blogroll, published writing). Blog *drafting* happens in Google Docs, not here — this directory is site content management only.
- `snippets/` — reusable text snippets organized by topic.
- `life admin/` — personal administrative notes.
- `templates/` — Obsidian templates for new notes.

## Conventions

- All content is Markdown, authored for Obsidian (may use wiki-links, callouts, and other Obsidian-flavored syntax).
- Use `[[wiki-links]]` when referencing other notes in the vault — especially when mentioning a file you've just created or edited. Prefer the bare note name (e.g. `[[silly-research-ideas]]`) over the full path.
- Do **not** add an `# Title` heading at the top of new pages. Obsidian displays the filename as the page title, so a leading H1 is redundant. Start the file body directly with content or a frontmatter block, and use `##` as the highest heading level within the page body.
- **When creating or editing vault pages**, invoke the `vault` skill for full guidelines before writing.
- **Debuzz agent-written prose before saving** — see below.

## Style: debuzz pass

Prose you generate drifts into the assistant register: dramatic framing, suspense, listicle energy. `[[STYLEGUIDE]]` says what good looks like and the `prose-review` skill checks against it, but both are you marking your own homework. So run agent-written prose through the `debuzz` skill in **`vault` mode** and save what comes back. That mode is colleague mode plus the STYLEGUIDE's hard constraints, because a generic rewrite reintroduces em dashes and American spellings.

Save the returned text verbatim. Do not re-polish it afterwards; that is how the voice gets back in. The one exception is a mechanical fix for something agy broke — an em dash, a US spelling, a mangled `[[wiki-link]]`.

### Where it applies

- **`## Worklog` entries** in `daily/`, which are the machine layer and the highest-volume agent prose in the vault.
- **Standalone prose pages** you drafted: `writing/`, `snippets/`, `personal/`, `links/`, project notes, and research dumps filed anywhere outside the directories excluded below.

### Where it must never apply

These are Jamie's own words. Rewriting them destroys the only thing that makes them worth having, and that damage is not visible after the fact.

- **`## Journal`** in `daily/` — verbatim by rule. The debuzz pass does not soften this; it is the same prohibition stated twice, deliberately.
- **`evergreen/`** — Jamie's ideas in development, including any verbatim dated words cross-filed from the Journal.
- **`personhood/`** — his stated positions on mission, worldview, mistakes, and goals.
- **`jamierumbelow.net/`** — published and site content in his authored voice.
- **`## Flashcards`** — Jamie approves the phrasing during `/end-day`; once approved it is settled.
- **Quoted material** anywhere — highlights, excerpts, and anything attributed to a named person stays in that person's words.

### When to skip it as pointless

Not everything agent-written is prose worth an agy round-trip. Skip single-line `## Todos`, status and checkbox changes, frontmatter edits, link-list maintenance, and any edit under roughly a sentence. There is no register to fix and the call costs ten seconds.

If `agy` is unavailable, save the prose as written and say so. Never substitute your own rewrite; the whole point is an editor that does not share your habits.

## Specific Directories

### daily

This contains the daily journal and worklog. Each entry is a collaborative document built up over the course of the day between the agent and Jamie. Two sections have opposite ownership rules:

- **`## Worklog`** is the machine layer: agent-written records of what got done. When adding worklog entries or todos, feel free to clean up, embellish, expand, or simplify what Jamie says so that it reads well and is in keeping with the [[STYLEGUIDE]]. His instructions will often be brief or sloppy shorthand — use your judgement to turn them into clear, well-written entries.
- **`## Journal`** is the human layer: Jamie's own thinking in his own words. Entries here are timestamped and **verbatim** — never paraphrase, polish, embellish, or expand them. The value of the Journal is that Jamie generated the words himself; smoothing them destroys the point. The embellish-freely rule above applies to Worklog and Todos only.

I may ask you to do a number of things:
* add specific notes
* summarise a point we're discussing elsewhere
* do some independent research and drop the findings in the worklog

The `/end-day` command runs the evening ritual (journal prompts, flashcard harvest, Mochi sync); `/start-day` runs the morning briefing.

### evergreen

These are Jamie's ideas in development — few, dense notes that grow over time. The thinking in them should be his: don't ghost-write idea development or expand a one-line thought into polished sections. You may append Jamie's verbatim words (dated) when cross-filing from the Journal, suggest which evergreen note a new thought belongs to, and point out when a conversation touches an existing note.

### jamierumbelow.net

Jamie's personal website is built from content in this directory. It is not a drafting space — drafts live in Google Docs so they can be shared for comments.