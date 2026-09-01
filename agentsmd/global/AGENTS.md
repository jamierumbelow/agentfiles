## Worklog

Proactively write to the daily worklog after completing tasks, making commits or PRs, finishing research, or reaching any meaningful milestone. Use the `worklog` skill for format and path details. Do not wait to be asked; this is a standing instruction for all sessions.

## Skill friction

When you notice that a skill, command, or AGENTS.md instruction led you astray, caused extra rounds of correction, or didn't cover a situation that came up, note it in the conversation naturally. You don't need a special format -- just say what went wrong and what the artifact should have said instead. These notes become searchable via cass and feed into `/skill-review`.

If you spot a clear, well-evidenced fix (not a vague hunch), you can run the `skill-review` skill quietly at the end of the session and make the edit directly. Keep sporadic reviews brief and only act on strong signals.

## Pull Requests

When coding, if Jamie asks you to create a pull request please do not include "[codex]" at the beginning of the title. If the PR contains one commit, you can just use the commit message.

<!-- mod:guidance:begin -->
## Reviewing markdown with mod

When the user asks for a plan, write it as a Markdown file on disk. When a Markdown document needs the user's review, comments, or approval, use the `mod` skill: run `mod open "<absolute path>" --wait` and follow the skill's review loop.
<!-- mod:guidance:end -->

Mod replaces Roughdraft. Treat requests mentioning Roughdraft or `rd` as requests for mod, but do not create or modify any shell alias, executable, symlink, or command named `rd`.
