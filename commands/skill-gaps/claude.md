Find recurring friction in recent sessions that suggests a skill is missing or
an agentfile has a blind spot. Run the `skill-gaps` skill for full guidance.

$ARGUMENTS can optionally narrow the scope:

- A workspace path: only search sessions from that project
- A time range like `7d`, `14d`, `30d` (default: 14 days)
- An agent name: only search sessions from that agent

If $ARGUMENTS is blank, search across all agents and workspaces for the last
14 days.

Steps:

1. Run the correction-language and repeated-explanation searches from the
   skill (in parallel where possible).
2. Deduplicate hits across queries. Group by theme rather than by query.
3. Expand the best 3-5 hits to understand context.
4. Cross-reference against existing skills, commands, AGENTS.md files, and
   memories.
5. Present findings ranked by frequency and impact. For each, state the
   pattern, evidence, and a concrete recommendation.
6. Don't create new skills or commands without asking. Do suggest specific
   wording for what they'd contain.
