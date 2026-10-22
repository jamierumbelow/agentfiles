## Worklog

Proactively write to the daily worklog after completing tasks, making commits or PRs, finishing research, or reaching any meaningful milestone. Use the `worklog` skill for format and path details. Do not wait to be asked; this is a standing instruction for all sessions.

## Skill friction

When you notice that a skill, command, or AGENTS.md instruction led you astray, caused extra rounds of correction, or didn't cover a situation that came up, note it in the conversation naturally. You don't need a special format -- just say what went wrong and what the artifact should have said instead. These notes become searchable via cass and feed into `/skill-review`.

If you spot a clear, well-evidenced fix (not a vague hunch), you can run the `skill-review` skill quietly at the end of the session and make the edit directly. Keep sporadic reviews brief and only act on strong signals.

## Pull Requests

When coding, if Jamie asks you to create a pull request please do not include "[codex]" at the beginning of the title. If the PR contains one commit, you can just use the commit message.

## Worktrees

All git worktrees live under `~/workspace/repos-workspaces/<repo>/<branch>`, where `<branch>` is the branch name with `/` replaced by `-`. Never create them inside the repo itself, in `/tmp`, next to the repo in `~/workspace/repos`, or anywhere else, and prefer this over any tool that picks its own location.

```bash
git -C ~/workspace/repos/<repo> worktree add ~/workspace/repos-workspaces/<repo>/<branch-slug> -b <branch>
```

- Run `git worktree list` first. If a worktree for the branch already exists, use it instead of making another.
- When the branch is merged or abandoned, remove it with `git worktree remove <path>`, then `git worktree prune`. Delete the empty `<repo>` directory if it was the last one.
- Never remove a worktree with uncommitted or unpushed changes, or one you didn't create in this session, without asking Jamie first.

## Commit attribution

Never add a `Co-Authored-By: Claude` trailer, a "Generated with Claude Code" line, or any other Anthropic attribution to commit messages or PR bodies, including in subagents.
