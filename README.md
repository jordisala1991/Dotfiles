# Dotfiles

macOS dotfiles linked into `$HOME` by [mise](https://mise.jdx.dev/dotfiles.html). Packages are declared in `mise.toml`.

| Package | Contents |
|---------|----------|
| `zsh`   | `.zprofile`, `.zshrc`, aliases. Prompt by [Starship](https://starship.rs), plugins from Homebrew |
| `git`   | `.gitconfig` (SSH commit signing), global ignore |
| `vim`   | Minimal `.vimrc`, no plugins |
| `ssh`   | `.ssh/config` |
| `mise`  | Global tool versions (node, python, pnpm, uv…) |
| `claude`| Claude Code status line (model, context, branch, cost) |

## Install

Requires [Homebrew](https://brew.sh).

```sh
git clone https://github.com/jordisala1991/Dotfiles.git ~/Projects/Dotfiles
~/Projects/Dotfiles/install.sh
```

If a real file already exists where a link goes (for example a `~/.zprofile`
written by the Homebrew installer), `mise dot apply` lists it and stops without
changing anything. Keep it in the repo with `mise -C ~/Projects/Dotfiles dot add <file>`
or delete it, then run `./install.sh` again. Afterwards `mise install` sets up
the tools from the global mise config.

To update, `git pull` and run `./install.sh` again.

## Machine-specific config

These files are loaded if present and are not versioned:

- `~/.zshrc.local`
- `~/.gitconfig.local` (e.g. a work `user.email`)
- `~/.ssh/config.local`
- `~/.Brewfile.local` (extra Homebrew packages, installed by `install.sh`)
- `~/.config/mise/conf.d/*.toml` (extra mise tools, on top of the global config)

## Commit signing

Commits are signed with `~/.ssh/id_ed25519.pub`. Create the key and register it on GitHub as a *signing* key:

```sh
ssh-keygen -t ed25519 -C "jordism91@gmail.com"
gh ssh-key add ~/.ssh/id_ed25519.pub --type signing
gh ssh-key add ~/.ssh/id_ed25519.pub --type authentication
```
