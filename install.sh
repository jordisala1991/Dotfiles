#!/usr/bin/env bash
# Install dependencies and symlink dotfiles into $HOME. Safe to re-run.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

if ! command -v brew >/dev/null; then
    echo "Homebrew is required: https://brew.sh" >&2
    exit 1
fi

brew bundle --file=Brewfile

# Machine-specific packages, not versioned
if [[ -f "$HOME/.Brewfile.local" ]]; then
    brew bundle --file="$HOME/.Brewfile.local"
fi

# mise reads the [dotfile_groups] in mise.toml only once the file is trusted
mise trust --quiet "$PWD/mise.toml"

# mise sets the permissions of ~/.ssh before it links files into it, so create it first
mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"

# Stops without changing anything if a real file is in the way; see README.md
mise dot apply
mise install

echo "Done. Open a new terminal to load the changes."
