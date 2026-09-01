Rewrite a response in plain English by running it through the Antigravity CLI
(`agy`). Run the `debuzz` skill for full guidance.

$ARGUMENTS is `[mode] [text]`, both optional:

- If the first word is `colleague`, `manager`, or `director`, that's the mode.
  Otherwise the mode is `colleague`.
- Whatever remains is the text to translate. If it's blank, translate your own
  most recent substantive response — reproduce it from the conversation word
  for word, including code blocks.

Steps:

1. Write the source text verbatim to a temp file with your file-writing tool
   (not shell `echo`).
2. Run `agy --disable-slash-commands -p "<delimited source> <style + mode
   instructions>"` as described in the skill. Keep `-p` last — agy takes the
   next token as its prompt. Allow 120s+.
3. Print agy's output verbatim. Do not summarize it, reframe it, or add a
   sign-off — anything you add reintroduces the voice being removed. A one-line
   lead like "Antigravity's translation (manager):" is the maximum.
4. If agy errors, show the real error and the fix. Only offer your own rewrite
   as a clearly labeled fallback, never as a silent substitute.
