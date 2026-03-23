Review a piece of writing against the vault STYLEGUIDE. Run the `prose-review`
skill for full guidance.

$ARGUMENTS is either:

- A file path in the vault (e.g. `jamierumbelow.net/flying blind.md`,
  `writing/wip/packet-service/draft.md`). Resolve relative to
  `~/workspace/vault/`.
- Blank, in which case look for a draft or piece of writing in the current
  conversation context and review that.

Steps:

1. Read `~/workspace/vault/STYLEGUIDE.md`.
2. Read the target text (file or conversation).
3. Work through the five review passes from the skill: AI slop, voice and
   register, specificity, structure, sentence-level craft.
4. Make edits directly if reviewing a file. Present a marked-up version if
   reviewing conversation text.
5. Summarise what you found and changed, grouped by category.
