#!/usr/bin/env bash
# Install dependencies and symlink dotfiles into $HOME. Safe to re-run.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

PACKAGES=(zsh git vim ssh mise)

if ! command -v brew >/dev/null; then
    echo "Homebrew is required: https://brew.sh" >&2
    exit 1
fi

brew bundle --file=Brewfile

# Move aside real files that would conflict with the symlinks
backup="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
for pkg in "${PACKAGES[@]}"; do
    while IFS= read -r file; do
        target="$HOME/${file#"$pkg"/}"
        if [[ -e "$target" && ! -L "$target" ]]; then
            mkdir -p "$(dirname "$backup/${file#"$pkg"/}")"
            mv "$target" "$backup/${file#"$pkg"/}"
            echo "Backed up $target → $backup"
        fi
    done < <(find "$pkg" -type f)
done

mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"

# --no-folding: link files, never whole directories (keeps keys out of the repo)
stow --no-folding --restow --target="$HOME" "${PACKAGES[@]}"

echo "Done. Open a new terminal to load the changes."
