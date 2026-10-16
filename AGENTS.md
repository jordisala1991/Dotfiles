# AGENTS.md

Personal macOS dotfiles, linked into `$HOME` with [mise dotfiles](https://mise.jdx.dev/dotfiles.html) (`mise dot apply`). See README.md for the user-facing overview.

## Layout

- Each top-level directory (`zsh`, `git`, `vim`, `ssh`, `mise`, `claude`) is a package whose contents mirror their path under `$HOME`. A new file for `~/.config/foo/bar` goes in `<package>/.config/foo/bar`.
- `mise.toml` at the repo root declares each package as a `[dotfile_groups.<name>]`. A new package needs a group there; `install.sh` reads the list from mise.
- Groups use `symlink-each` (the default), so only files are linked, never directories. Keep it that way: linking `~/.ssh` or `~/.claude` as a whole would pull keys and session data into the repo.
- `mise.toml` is project config for this repo, not the global `mise/.config/mise/config.toml`. mise reads it only after `mise trust` and only from inside the repo (or with `mise -C <repo>`).
- New Homebrew dependencies go in `Brewfile`.

## Never version

- `~/.claude/settings.json`: Claude Code and Orca rewrite it. A `merge` entry in `mise.toml` sets only the keys in `claude/settings.shared.json` (`statusLine`, and `attribution` turned off so commits and PRs get no Claude trailer or footer).
- `~/.config/gh/hosts.yml` (token), SSH keys, and other secrets.
- Machine-specific overrides: `~/.zshrc.local`, `~/.gitconfig.local`, `~/.ssh/config.local`. The repo configs include them when present.

## Gotchas

- `claude/.claude/statusline.sh` forwards its stdin to Orca's `~/.orca/agent-hooks/claude-statusline.sh` before printing. Keep that forwarding, or Orca loses its session data.
- macOS + Apple Silicon only: paths assume `/opt/homebrew`, and `ls` is BSD (`CLICOLOR`, not GNU flags).
- Files in `$HOME` are symlinks into this repo, so editing them edits the repo.
- `mise dot apply` refuses to replace a real file and lists every conflict; `--force` keeps no copy. Don't add `--force` to `install.sh`: the user resolves conflicts with `mise dot add` or by deleting the file.
- Don't use `mise dot track`: it writes into `~/.config/mise/config.toml`, which is a symlink into this repo, and a later apply drops the entry (rollback then fails).

## Verify changes

- `bash -n install.sh`, and `zsh -n` on any zsh file you change.
- `mise dot apply --dry-run` and `mise dot status` show what would change.
- To test without touching the real home, run with `HOME=$TMP_HOME` (and the `XDG_*` and `MISE_*_DIR` variables unset): `mise trust mise.toml && mise dot apply`, then `HOME=$TMP_HOME zsh -l -i -c '...'`.
- Pipe sample JSON into the status line script: `echo '{"model":{"display_name":"X"},"context_window":{"used_percentage":40}}' | claude/.claude/statusline.sh`.
- Apply for real with `./install.sh`. It is idempotent and stops on conflicting files without touching them.

## Git

Commits are signed with the SSH key `~/.ssh/id_ed25519` and must stay signed. Remote is SSH, and work goes on `master`.
