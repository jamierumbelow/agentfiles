---
name: skill-gaps
description: >-
  Search recent sessions for recurring friction that suggests a skill is missing
  or an existing agentfile has a blind spot. Produces a short report of
  candidate skills, command improvements, or AGENTS.md additions.
---

# Skill Gaps

Find patterns in recent session history that suggest the agentfiles are
incomplete. This is the discovery complement to `/skill-review`, which improves
existing artifacts. `/skill-gaps` finds things that don't have an artifact yet.

## What counts as a gap

A gap is a repeated pattern where Jamie had to correct, explain, or manually
do something that a skill or instruction could have handled. One-off
corrections are not gaps. The same correction across 2-3 sessions is.

Concrete examples:

- Jamie keeps explaining a project convention that isn't captured anywhere.
- The agent repeatedly gets a formatting or style choice wrong in the same way.
- A manual multi-step workflow comes up often enough to warrant a command.
- Jamie says "remember to..." or "like last time..." and there's no skill or
  memory covering it.
- The agent asks a question it shouldn't need to ask, because the answer is
  stable and could be documented.

## Search strategy

Cast a wide net, then filter. The goal is to surface candidate patterns, not
to be exhaustive.

### Step 1: Scan for correction language

Search cass for recent sessions containing correction signals. These are
phrases Jamie uses when redirecting the agent. Run several searches in
parallel, scoped to the last 14-30 days:

```bash
cass search "no not that" --robot --limit 10 --days 30 --fields summary
cass search "actually" --robot --limit 10 --days 14 --fields summary
cass search "like last time" --robot --limit 10 --days 30 --fields summary
cass search "remember to" --robot --limit 10 --days 30 --fields summary
cass search "I told you" --robot --limit 10 --days 30 --fields summary
cass search "don't do" --robot --limit 10 --days 30 --fields summary
cass search "wrong format" --robot --limit 10 --days 30 --fields summary
cass search "should have" --robot --limit 10 --days 30 --fields summary
```

These are starting points. Adjust or add queries based on what you find. The
signal is in Jamie's messages, not the agent's.

### Step 2: Scan for repeated explanations

Search for phrases that suggest the agent is being taught something
repeatedly:

```bash
cass search "the convention is" --robot --limit 10 --days 30 --fields summary
cass search "we always" --robot --limit 10 --days 30 --fields summary
cass search "the way we do" --robot --limit 10 --days 30 --fields summary
cass search "the pattern is" --robot --limit 10 --days 30 --fields summary
```

### Step 3: Expand and read

For hits that look promising, expand context to understand what happened:

```bash
cass expand <source_path> -n <line_number> -C 5 --json
```

Read enough to understand: what was the agent doing, what did Jamie correct,
and is this a pattern or a one-off?

### Step 4: Cross-reference existing artifacts

Before proposing a new skill, check whether the gap is already covered:

- Read the relevant skill if one exists (maybe it's covered but poorly)
- Check AGENTS.md files for existing instructions
- Check memories for feedback that already captures this

If the gap is in an existing artifact, this becomes a `/skill-review` finding
instead. Note it as such.

## Output

Produce a short report. For each candidate gap:

- **Pattern**: What keeps happening, with session evidence (quote or cite)
- **Frequency**: How many sessions, over what period
- **Current coverage**: What exists today (if anything)
- **Recommendation**: New skill, new command, addition to AGENTS.md, or
  feedback memory. Be specific about what the artifact should say.

Rank candidates by frequency and impact. A formatting issue that comes up
every session matters more than an edge case from two weeks ago.

If nothing actionable turns up, say so. Not every run will find gaps, and
that's fine.

## When to run

- On demand via `/skill-gaps`
- Optionally as part of a weekly review or at the end of a long session
- Not every session. This is heavier than `/skill-review` because it's doing
  open-ended discovery rather than reviewing a known artifact.

## What not to do

- Don't propose skills for things that are genuinely one-off.
- Don't propose skills for things the agent should already know how to do
  (standard coding, common tools). The gap has to be about Jamie's specific
  preferences, conventions, or workflows.
- Don't create the skills yourself. Present the findings and let Jamie decide
  what to build. The exception is very small additions to AGENTS.md that are
  clearly warranted by strong evidence.
