---
name: rudd
description: >-
  Record and analyse day trades with the `rudd` CLI. Use when Jamie writes a
  trading message — daily levels/notes, a session open/close, entering or
  exiting an options trade, or asking how trades are going. Translate the chat
  message into rudd commands, run them, and confirm in prose.
---

# rudd — day trade tracker

`rudd` is a CLI for tracking day trades (options, v1). Jamie writes a normal chat
message; you translate it into `rudd` commands, run them, and report back. It is
built for this: every command takes terse, agent-friendly input and returns
parseable output.

## Output formats

- **default (text)** — terse, one fact per line. Use for most commands.
- **`--json`** — structured. Use when you need to extract a value reliably
  (especially the new trade **id** from `open`, and `analyze` figures).
- **`--pretty`** — lipgloss panels/ladders for a human. Don't parse it; suggest
  Jamie run it himself when he wants the nice view.

Never dump raw JSON at Jamie — read it and summarise in prose.

## Database

Data lives at `$RUDDTRACKER_DB`, else `$XDG_DATA_HOME/ruddtracker/ruddtracker.db`.
Run `rudd` against the **same DB Jamie uses** — if he works inside the
`ruddtracker` repo, mise points `RUDDTRACKER_DB` at `./.dev/ruddtracker.db`, so
run from there or export the same path. If `rudd` isn't on PATH, it's `bin/rudd`
in the repo (or `make install`).

## Commands

### Account (enables R-multiples)
```bash
rudd account set --size 2682.32 --risk-pct 5   # rewrites BOTH fields each call
rudd account show
```
`account set` overwrites both fields, so always pass `--size` and `--risk-pct`
together when changing either.

### Day notes & levels
```bash
rudd day note "SPY breakout watch"
rudd day level QQQ resistance 585          # one level: <ticker> <kind> <price>
rudd day show [date] [--pretty]
```
Kinds are free text. In the pretty ladder these are **session markers** drawn as
divider lines, not rungs:
- `open` — start of day
- `close` — end of day (green/red for up/down vs open)
- `current` — live price; shown only until an open/close exists

Record the session when you have it so the ladder reads well looking back:
```bash
rudd day level QQQ open 715.20
rudd day level QQQ close 705.06
```

**Bulk levels** — when Jamie pastes a block of levels, pipe it in one shot
instead of many calls. One level per line, price first or last, leading
arrows/bullets stripped, non-numeric lines skipped:
```bash
rudd day levels QQQ [--kind level] <<'EOF'
714.66 daily exhaust support
weekly pivot 721.90
→ 717.15
EOF
```

### Trades
```bash
# Open — capture the id (use --json) so you can close it later.
rudd open --ticker SPY --expiry 2026-06-13 --type call --strike 585 \
          --price 2.50 --qty 2 [--side long|short] [--fees 1.30] \
          [--note "…"] [--tag breakout] [--time 10:15] --json

# Close by id, or match a single open position when the id is unknown.
rudd close 12 --price 3.80 [--fees 1.30] [--note "…"] [--time 10:48]
rudd close --ticker SPY --strike 585 --type call --price 3.80
```
`--price` is the premium per share; dollar P&L applies the 100× multiplier.
P&L: `(exit-entry)*qty*100` (negated for shorts), minus entry+exit fees.
`--time` sets entry/exit time (`HH:MM`, RFC3339, or `now`; default `now`). When
Jamie gives times ("entered 10:15, out 10:48"), pass them so time-held is tracked.

### List & analyse
```bash
rudd list [--open|--closed] [--ticker SPY] [--date YYYY-MM-DD]  # all by default
rudd analyze [--ticker SPY] [--from … --to …] [--json|--pretty]
```
`analyze` gives win rate, net/avg/gross P&L, fees, avg win/loss, profit factor,
best/worst, open exposure, by-ticker, and total R (when account risk is set).

## Translating chat → commands

- "QQQ levels for today: …list…" → `rudd day levels QQQ` (bulk, via stdin).
- "opened 2 SPY 585 calls at 2.50" → `rudd open … --json`, then tell Jamie the
  trade id.
- "closed those for 3.80" → find the open SPY position (`rudd list --open
  --ticker SPY`), then `rudd close <id> --price 3.80`. Report net P&L and R.
- "how am I doing / how's the week" → `rudd analyze [--from …] --json`,
  summarise win rate, net P&L, R, best/worst.
- "opened at 715.20, closed 705.06" → `rudd day level QQQ open …` /
  `… close …`.

## Tips

- Always grab the **id** from `open` (parse `--json`) before moving on, so a
  later "close it" is unambiguous. If `close --ticker` matches multiple open
  positions, rudd errors and lists the ids — pick the right one with Jamie.
- Default `--side` is `long`; only pass `--side short` for sold-to-open.
- Tickers and dates: `--date` accepts `today` (default) or `YYYY-MM-DD`.
- Confirm what you recorded back to Jamie in plain language (contract, qty,
  price, P&L, R) — don't make him read tool output.
