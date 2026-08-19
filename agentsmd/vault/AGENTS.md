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