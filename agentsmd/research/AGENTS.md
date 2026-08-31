This is an Obsidian vault of AI-generated research notes. Jamie does not maintain this vault directly — the agent is wholly responsible for its structure, content, and coherence. Treat it as a living knowledge base that grows through conversation, web research, and imports from Readwise and X bookmarks.

## Sources

Notes originate from three channels:

1. **LLM conversations** — research requests from Jamie via Claude Code or Codex. The agent synthesises findings into notes.
2. **Readwise** — highlights, saved articles, and annotations from Jamie's reading. Use the `readwise` skill and the `readwise` CLI to access.
3. **X bookmarks** — tweets and threads Jamie has bookmarked. Use the `ft` skill and the `ft` CLI to access.

When pulling from Readwise or X, always attribute the source (author, URL, date) in the note's frontmatter or inline.

## Structure

```
research/
├── notes/          # Individual research notes — the primary content
├── topics/         # Topic index pages that collect related notes
├── sources/        # Per-source pages (a book, article, thread, etc.)
├── open-questions/ # Explicit gaps, unresolved threads, future research
└── _index.md       # Top-level map of the vault
```

- **notes/** — One file per idea, finding, or synthesis. Filenames are lowercase-kebab-case, descriptive, and stable (e.g. `attention-is-all-you-need-summary.md`, `mechanism-design-for-llm-evals.md`).
- **topics/** — Each topic page is a curated hub that links to relevant notes, sources, and open questions. Think of these as Wikipedia-style portals. Create a topic page once 3+ notes cluster around a theme.
- **sources/** — When a single source (article, paper, book, tweet thread) generates multiple notes or is referenced repeatedly, give it its own page with metadata and a list of linked notes.
- **open-questions/** — Questions, contradictions, and gaps worth returning to. Link these from the notes that raised them.
- **_index.md** — A top-level map of the vault. Keep it updated as a table of contents: list all topic pages and link to the most important recent notes. This is the entry point for navigating the vault.

## Conventions

- All content is Markdown authored for Obsidian.
- Use `[[wiki-links]]` liberally to connect notes, topics, sources, and open questions. Prefer the bare note name (e.g. `[[transformer-architectures]]`) over the full path.
- Do **not** add an `# Title` heading. Obsidian displays the filename as the page title. Start with frontmatter or body content directly, using `##` as the highest heading level.
- Every note must have YAML frontmatter with at least:
  ```yaml
  ---
  created: YYYY-MM-DD
  sources: []        # URLs, Readwise IDs, ft bookmark IDs
  topics: []         # list of [[topic]] wiki-links
  status: seed | growing | evergreen
  ---
  ```
  - **seed** — stub or initial dump, needs expansion.
  - **growing** — has substance but is still being developed.
  - **evergreen** — mature, well-sourced, reviewed.
- Topic pages do not need the `status` field but should have `created` and a brief description at the top.
- Write in clear, direct prose. Prefer specificity over generality. Include concrete examples, data points, and quotations where available.
- When a note cites a claim, link or attribute the source inline (e.g. "According to [[scaling-laws-for-neural-language-models]], ...").
- **Debuzz the prose before saving.** Every note in this vault is agent-written, so it drifts into the assistant register — dramatic framing, suspense, listicle energy — and Jamie isn't editing it out by hand. Run the prose through the `debuzz` skill in `vault` mode and save the returned text. See below.
- British English spelling throughout. `agy` will Americanise a rewrite if not told otherwise, which is one reason the debuzz pass uses `vault` mode.

## Style: debuzz pass

Applies when creating a new note or substantially rewriting an existing one's prose, in `notes/`, `sources/`, or `open-questions/`.

1. Write the note first, as normal.
2. Pass the **body prose only** through the `debuzz` skill in `vault` mode — an independent editor that doesn't share the original's stylistic habits, which is the whole point of not just re-reading it yourself. Use `vault` mode, not plain `colleague`: it carries the British English and punctuation constraints that a generic rewrite breaks. Observed in practice on 31 August 2026, agy Americanised the spelling of a whole note under plain colleague mode.
3. Save the returned text verbatim. Do not re-polish it afterwards; that reintroduces the voice being removed. A mechanical fix for something agy broke is not re-polishing.

**Cut these out of the text before you send it, and paste them back afterwards.** Do not send them and hope; agy has been observed dropping source quotations outright.

- YAML frontmatter.
- `[[wiki-links]]` — these must survive byte-identical or the vault's link graph breaks. Check them after the rewrite.
- Verbatim quotations from sources, and any inline attribution.
- Code blocks, figures, and data tables.

Skip the pass entirely for mechanical edits: `_index.md` updates, adding or removing links on a topic page, status bumps, frontmatter changes. There's no prose to fix and `agy` will happily reword a link list.

If `agy` is unavailable, save the note as written and say so rather than substituting your own rewrite.

## Maintenance

The agent is responsible for keeping the vault coherent as it grows:

- **Link hygiene** — When creating a new note, scan for existing notes that should link to or from it. Update both sides.
- **Topic curation** — Periodically review topic pages. Add newly relevant notes, remove stale links, and update the summary description.
- **Index upkeep** — After adding notes or topics, update `_index.md` so it reflects the current state.
- **Deduplication** — Before creating a new note, check whether an existing note already covers the same ground. Merge or extend rather than duplicate.
- **Status promotion** — When revisiting a seed note and adding substance, bump its status to `growing`. When a note is well-sourced and stable, promote to `evergreen`.

## Workflow: Research Requests

When Jamie asks for research on a topic:

1. **Check existing notes** — Search the vault for relevant notes, topics, and open questions first.
2. **Check Readwise** — Search for saved articles and highlights on the topic (`readwise reader-search-documents`, `readwise readwise-search-highlights`).
3. **Check X bookmarks** — Search for relevant bookmarked tweets (`ft search`).
4. **Web research** — Search the web to fill gaps, find primary sources, and verify claims.
5. **Synthesise** — Write one or more notes in `notes/`, linking to sources and topics. Create source pages if a single source is especially rich. Create or update topic pages as needed. Run each note's prose through the debuzz pass before saving.
6. **Surface open questions** — If the research raises unresolved questions or contradictions, create entries in `open-questions/` and link them from the relevant notes.
7. **Update the index** — Add new topic pages to `_index.md`.

## Workflow: Importing from Sources

When importing content from Readwise or X bookmarks:

- Create a source page in `sources/` with full metadata (title, author, URL, date, highlights or key quotes).
- Extract distinct ideas into individual notes in `notes/`, linking back to the source.
- File each note under relevant topics, creating new topic pages if a cluster emerges.
- Do not dump raw highlights as notes. Synthesise, contextualise, and connect them.
- Debuzz your synthesis before saving, but never the quoted highlights themselves — those stay in the author's words.

## Tools

- **Readwise CLI** (`readwise`) — access highlights, documents, and the reading library. See the `readwise` skill for full command reference.
- **Field Theory CLI** (`ft`) — search and browse X/Twitter bookmarks. See the `ft` skill for full command reference.
- **Web search** — use when Readwise and bookmarks don't cover the topic, or to find primary sources and verify claims.
