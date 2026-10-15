# Dotfiles

macOS dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

| Package | Contents |
|---------|----------|
| `zsh`   | `.zprofile`, `.zshrc`, aliases. Prompt by [Starship](https://starship.rs), plugins from Homebrew |
| `git`   | `.gitconfig` (SSH commit signing), global ignore |
| `vim`   | Minimal `.vimrc`, no plugins |
| `ssh`   | `.ssh/config` |
| `mise`  | Global tool versions (node, python, pnpm, uv…) |

## Install

Requires [Homebrew](https://brew.sh).

```sh
git clone https://github.com/jordisala1991/Dotfiles.git ~/Projects/Dotfiles
~/Projects/Dotfiles/install.sh
```

Existing files are moved to `~/.dotfiles-backup/<timestamp>/` before linking.
To update, `git pull` and run `./install.sh` again.

## Machine-specific config

These files are loaded if present and are not versioned:

- `~/.zshrc.local`
- `~/.gitconfig.local` (e.g. a work `user.email`)
- `~/.ssh/config.local`

## Commit signing

Commits are signed with `~/.ssh/id_ed25519.pub`. Create the key and register it on GitHub as a *signing* key:

```sh
ssh-keygen -t ed25519 -C "jordism91@gmail.com"
gh ssh-key add ~/.ssh/id_ed25519.pub --type signing
gh ssh-key add ~/.ssh/id_ed25519.pub --type authentication
```
