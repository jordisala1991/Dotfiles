# AGENTS.md

Personal macOS dotfiles, linked into `$HOME` with GNU Stow. See README.md for the user-facing overview.

## Layout

- Each top-level directory (`zsh`, `git`, `vim`, `ssh`, `mise`, `claude`) is a Stow package whose contents mirror their path under `$HOME`. A new file for `~/.config/foo/bar` goes in `<package>/.config/foo/bar`.
- A new package must be added to `PACKAGES` in `install.sh`.
- Stow runs with `--no-folding`, so only files are linked, never directories. Keep it that way: folding `~/.ssh` or `~/.claude` would pull keys and session data into the repo.
- New Homebrew dependencies go in `Brewfile`.

## Never version

- `~/.claude/settings.json`: Claude Code and Orca rewrite it. `install.sh` sets only its `statusLine` key with `jq`.
- `~/.config/gh/hosts.yml` (token), SSH keys, and other secrets.
- Machine-specific overrides: `~/.zshrc.local`, `~/.gitconfig.local`, `~/.ssh/config.local`. The repo configs include them when present.

## Gotchas

- `claude/.claude/statusline.sh` forwards its stdin to Orca's `~/.orca/agent-hooks/claude-statusline.sh` before printing. Keep that forwarding, or Orca loses its session data.
- macOS + Apple Silicon only: paths assume `/opt/homebrew`, and `ls` is BSD (`CLICOLOR`, not GNU flags).
- Files in `$HOME` are symlinks into this repo, so editing them edits the repo.

## Verify changes

- `bash -n install.sh`, and `zsh -n` on any zsh file you change.
- To test without touching the real home: `stow --no-folding -t "$TMP_HOME" <packages>`, then `HOME=$TMP_HOME zsh -l -i -c '...'`.
- Pipe sample JSON into the status line script: `echo '{"model":{"display_name":"X"},"context_window":{"used_percentage":40}}' | claude/.claude/statusline.sh`.
- Apply for real with `./install.sh`. It is idempotent and backs up conflicting files to `~/.dotfiles-backup/`.

## Git

Commits are signed with the SSH key `~/.ssh/id_ed25519` and must stay signed. Remote is SSH, and work goes on `master`.
