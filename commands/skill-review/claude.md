Review and improve agentfiles using evidence from past sessions. Run the
`skill-review` skill for full guidance.

$ARGUMENTS names the artifact to review. Accepted forms:

- A skill name: `commit`, `worklog`, `cass`
- A command name: `start-day`, `flashcards`
- `agents:global` or `agents:vault` for AGENTS.md files
- `settings:claude` or `settings:codex` for tool settings
- `all` to review every artifact (brief mode, flags only strong findings)

If $ARGUMENTS is blank, review the 2-3 skills or commands most used in
recent sessions (search cass for the last 7 days to figure out which).

Steps:

1. Read the target artifact from `~/workspace/repos/agentfiles/`.
2. Search cass for evidence (see the skill for query strategy).
3. Check `~/.claude/projects/-Users-james-rumbelow-workspace/memory/` for
   relevant feedback memories.
4. Diagnose issues and propose edits. Make clear, well-evidenced edits
   directly. Ask before larger changes.
5. If you edited anything, summarise what changed and why.
6. Write a worklog entry if the review produced edits.
