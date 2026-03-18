# Commit changes

- The user has asked you to commit changes
- You will need to do this with full permissions (not sandbox) because we use GPG signing for commits
- Commit messages should be lowercase
- Commit messages should be a single line
- Commit messages should be concise and to the point
- Commit messages should be prefixed with the area of the codebase that was changed. For example, if you changed the src/transactions folder, the commit message should be prefixed with `transactions: `.

GOOD:

- `transactions: add new transaction type`
- `tools: remove web viewer, not needed`
- `auth: change from auth0 to custom auth provider`

BAD:

- `Add new transaction type`
- `Remove web viewer, not needed:

* Updates package.json to remove tool call
* Remove files from tools/
  `

- `Changes from auth0 to custom auth provider`
