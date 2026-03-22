Search local agent session history using cass. Run the `cass` skill for full guidance.

$ARGUMENTS contains the user's search intent. If blank, ask what they want to find.

1. If the index hasn't been checked this session, run `cass health --json` first. If it fails, run `cass index --full` and tell the user.

2. Turn $ARGUMENTS into a cass search query. Use your judgment on flags:
   - Default to `--robot --limit 5 --fields summary`
   - Add `--workspace "$(pwd)"` if the question is about the current project
   - Add time filters (`--days`, `--today`, `--week`) when the question implies recency
   - Use `--agent` if the user specifies one
   - Use `--aggregate` for overview questions ("how much", "which agents", "when")

3. Run the search. If results look relevant, pick the best 1-2 hits and expand context:
   `cass expand <source_path> -n <line_number> -C 3 --json`

4. Summarise what you found. Quote the relevant parts. If nothing useful came back, say so and suggest a different query or broader search.
