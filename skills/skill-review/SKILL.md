---
name: skill-review
description: >-
  Review and improve agentfiles (skills, commands, AGENTS.md, settings) using
  evidence from past sessions via cass. Searches for corrections, friction, and
  patterns, then proposes concrete edits.
---

# Skill Review

Review an agent configuration artifact and propose improvements based on
evidence from past sessions.

## Scope

"Agentfiles" means anything that shapes agent behaviour across sessions:

- Skills (`~/workspace/repos/agentfiles/skills/*/SKILL.md`)
- Commands (`~/workspace/repos/agentfiles/commands/*/claude.md`)
- AGENTS.md / CLAUDE.md files (`~/workspace/repos/agentfiles/agentsmd/`)
- Settings (`~/workspace/repos/agentfiles/claude/settings.json`,
  `~/workspace/repos/agentfiles/codex/config.toml`)

All of these live in `~/workspace/repos/agentfiles/` and are symlinked into
their respective tool config directories.

## How it works

The review has three phases: gather evidence, diagnose, and propose.

### 1. Gather evidence

Search cass for sessions where the artifact was relevant. Build queries from
the artifact's name, its key concepts, and phrases Jamie would use when
correcting it.

For a skill named `commit`:
- `cass search "commit skill" --robot --limit 10 --fields summary`
- `cass search "commit message wrong" --robot --limit 5 --fields summary`
- `cass search "commit format" --robot --limit 5 --days 30 --fields summary`

For an AGENTS.md:
- Search for key phrases from the file
- Search for "CLAUDE.md" or "AGENTS.md" plus correction language

Expand the 2-3 most relevant hits to get full context:
`cass expand <path> -n <line> -C 5 --json`

Also check the agent's memory directory for feedback-type memories that
mention the artifact:
`~/.claude/projects/-Users-james-rumbelow-workspace/memory/`

### 2. Diagnose

Read the current artifact and compare it against the evidence. Look for:

- **Corrections**: Jamie changed the agent's output after the skill ran. What
  was wrong? Is the skill missing guidance that would have prevented it?
- **Friction**: The agent struggled to follow the skill, asked clarifying
  questions, or produced output that needed multiple rounds of editing.
- **Drift**: The skill says one thing but sessions show a different convention
  has emerged in practice.
- **Gaps**: Situations the skill doesn't cover that came up in sessions.
- **Staleness**: Instructions that reference tools, paths, or conventions that
  have changed.

Not every review will find problems. If the evidence shows the artifact is
working well, say so and move on.

### 3. Propose

For each issue found, propose a specific edit. Show:
- What the evidence says (quote the relevant session context)
- What the current artifact says (or doesn't say)
- The proposed change (as a diff or description)

Make the edits directly when the fix is clear and well-supported by evidence.
For judgment calls or larger restructures, describe the change and ask Jamie
before editing.

## What makes a good review

A good review is grounded in evidence, not vibes. Every proposed change should
trace back to something that actually happened in a session. "I think this
could be better" is not a finding. "In three sessions this week, Jamie
corrected the date format from US to ISO" is.

Keep proposals narrow. One skill review should produce 1-3 targeted edits, not
a rewrite. If the artifact needs a rewrite, say so and let Jamie decide.

Avoid the temptation to add complexity. The best edit is often removing a
sentence that's causing confusion, not adding three paragraphs of new guidance.

## Running sporadically

This skill can be triggered explicitly via `/skill-review` or run as part of a
natural end-of-session reflection. When running sporadically (not triggered by
Jamie), only flag issues with strong evidence. A single ambiguous correction
is not enough to propose a change. Look for patterns across multiple sessions.

When running sporadically, keep the output brief: a short note about what was
found (or "nothing actionable"), not a full report unless there's something
worth acting on.
