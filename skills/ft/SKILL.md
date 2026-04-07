---
name: ft
description: >-
  Search, browse, and manage X/Twitter bookmarks using the Field Theory CLI.
  Use when Jamie asks about bookmarks, saved tweets, or wants to find
  something they bookmarked on X.
---

# ft: X/Twitter bookmark search

Field Theory (`ft`) is a local-first CLI for self-custody of X/Twitter
bookmarks. All data lives in a SQLite FTS5 database at `~/.ft-bookmarks/`.
No telemetry, no cloud — just local search.

## When to use ft

- Jamie asks "what did I bookmark about X?" or "find that tweet about Y"
- Jamie wants to search, browse, or analyse their X bookmarks
- Jamie asks to sync new bookmarks or check sync status
- Jamie wants to classify or organise bookmarks

Do not use ft for general web search. It only searches locally synced
X bookmarks.

## Quick reference

| Command | Purpose |
|---------|---------|
| `ft search "<query>"` | Full-text search (FTS5 syntax) |
| `ft list` | List bookmarks with filters |
| `ft show <id>` | Show a single bookmark |
| `ft stats` | Top authors, languages, date range |
| `ft categories` | Category distribution |
| `ft domains` | Subject domain distribution |
| `ft sync` | Sync new bookmarks from X |
| `ft classify` | Categorise bookmarks via LLM |
| `ft status` | Sync status and bookmark count |

## Searching

```bash
# Full-text search with BM25 ranking
ft search "distributed systems"

# Filter by author and date
ft search "machine learning" --author jremote --after 2024-01-01

# Limit results
ft search "rust" --limit 5
```

FTS5 syntax is supported: `AND`, `OR`, `NOT`, `"exact phrases"`, prefix
wildcards (`auth*`).

### Search flags

| Flag | What it does |
|------|--------------|
| `--author <handle>` | Filter by author |
| `--after YYYY-MM-DD` | Bookmarks after date |
| `--before YYYY-MM-DD` | Bookmarks before date |
| `--limit N` | Cap results (default: 20) |

## Listing and filtering

```bash
# List recent bookmarks
ft list --limit 10

# Filter by category and domain
ft list --category tool --domain ai --limit 20

# JSON output for structured processing
ft list --query "typescript" --json
```

### List flags

| Flag | What it does |
|------|--------------|
| `--query <text>` | Text filter |
| `--author <handle>` | Filter by author |
| `--after / --before` | Date range |
| `--category <cat>` | Filter by category |
| `--domain <domain>` | Filter by subject domain |
| `--limit N` | Cap results (default: 30) |
| `--offset N` | Pagination offset |
| `--json` | Machine-readable output |

## Categories

Bookmarks can be classified into 7 categories:

- **tool** — GitHub repos, CLI tools, npm packages, open-source projects
- **security** — CVEs, vulnerabilities, exploits, supply chain
- **technique** — Tutorials, demos, code patterns, how-to guides
- **launch** — Product launches, announcements, shipping news
- **research** — ArXiv papers, studies, academic findings
- **opinion** — Takes, analysis, commentary, threads
- **commerce** — Products, shopping, physical goods

Use `ft sample <category>` to see examples from a category.

## Syncing

```bash
# Incremental sync (new bookmarks only, uses Chrome session)
ft sync

# Full crawl of entire bookmark history
ft sync --full

# Sync and auto-classify with LLM
ft sync --classify

# Tune sync behaviour
ft sync --max-pages 100 --delay-ms 1000 --max-minutes 15
```

Chrome session sync (default) works on macOS only and requires Chrome to
be logged into x.com. For cross-platform, use `ft auth` then `ft sync --api`.

## Classifying

```bash
# LLM-powered classification
ft classify
ft classify-domains

# Re-classify all (not just unclassified)
ft classify-domains --all

# Simple regex fallback (no LLM needed)
ft classify --regex
```

## Analytics

```bash
ft stats         # Top authors, languages, date range
ft categories    # Category distribution with percentages
ft domains       # Subject domain distribution
ft viz           # Terminal dashboard with sparklines
```

## Example workflows

**Find bookmarks on a topic:**

```bash
ft search "transformer architecture" --limit 10
ft show <id>   # drill into a specific result
```

**Browse a category:**

```bash
ft list --category research --domain ai --limit 20
ft sample research --limit 5
```

**Check what's new:**

```bash
ft status
ft sync
ft list --after 2026-04-01 --limit 20
```

**Analyse bookmark patterns:**

```bash
ft stats
ft categories
ft domains
```
