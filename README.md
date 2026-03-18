# agentfiles

Global base configuration for Claude Code, Codex, and Gemini CLI.

## Scripts

### `add-skill`

Register a skill with every AI coding tool at once. Claude Code, Codex, and Gemini CLI all discover skills from `~/.<tool>/skills/<name>/SKILL.md`. This script symlinks a single source directory into all three locations so you only maintain one copy.

```bash
add-skill path/to/my-skill          # pass the skill directory
add-skill path/to/my-skill/SKILL.md # or the SKILL.md directly
```

The script is idempotent — re-running it skips already-correct links, updates stale ones, and warns (without clobbering) if a non-symlink already exists at the target.

#### Installation

The script lives at `scripts/add-skill.sh`. Symlink it somewhere on your `$PATH`:

```bash
ln -s "$(pwd)/scripts/add-skill.sh" ~/bin/add-skill
```
