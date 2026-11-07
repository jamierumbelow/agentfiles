## Worklog

Proactively write to the daily worklog after completing tasks, making commits or PRs, finishing research, or reaching any meaningful milestone. Do not wait to be asked; this is a standing instruction for all sessions.

Append with one command: `worklog-append 'entry text'`. It finds today's note, stamps the time and prints the line it wrote, so don't load the `worklog` skill, read the note or run `date` first. Write entries casual, fragmentary and specific (name the repo, PR or outcome), in British English, with no em dashes. Load the `worklog` skill only to edit other sections of the note or if you're unsure what's worth logging.

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

## Installing software: always mise, never brew

Never run `brew install`, `brew upgrade`, `brew reinstall` or `brew install --cask`, even when a README or an error message tells you to. Everything on this machine is installed through mise and declared in config, so it can be rebuilt. Read-only lookups (`brew info`, `brew search`) are fine for finding a name.

- **CLI tools and runtimes:** add them to `[tools]` in `~/workspace/repos/agentfiles/mise/mise.toml`, or in the project's `mise.toml` if only that project needs it, then run `mise install`. Find the backend with `mise registry <name>` (`aqua:`, `github:`, `npm:`, `pipx:` and `cargo:` all work).
- **Host libraries** (e.g. `libpq`): add `"brew:<formula>" = "latest"` under `[bootstrap.packages]` in `~/workspace/repos/dotfiles/mise/config.toml`.
- **Mac apps:** add `"brew-cask:<cask>" = { os = "macos" }` in the same place. For both of these, run `mise bootstrap packages apply --yes` afterwards. mise writes into the Homebrew prefix itself.
- **One-off use:** `mise exec <tool>@<version> -- <command>` runs a tool without installing it permanently.

Commit config changes in agentfiles or dotfiles only when asked.

## Commit attribution

Never add a `Co-Authored-By: Claude` trailer, a "Generated with Claude Code" line, or any other Anthropic attribution to commit messages or PR bodies, including in subagents.

## Recommendations

Before recommending Jamie anything personal (restaurants, hotels, trips, books, music, films, gifts), load the `personhood` skill and read his taste files. When he reacts to something he ate, read, watched, or stayed at, offer to record it there.

## Decision ownership

Don't assign decisions to people ("Joe's call", "up to Sarah", "worth checking with the owner"). Jamie decides who owns what. Give the recommendation or lay out the tradeoff, and leave the "whose call is it" part out. Only name someone when Jamie asks who owns something, or when a fact depends on it (e.g. "Joe wrote this in #123").
