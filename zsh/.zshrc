# Interactive shell.

HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

# Directories
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS

# Completion
fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select

# Tools
command -v mise >/dev/null && eval "$(mise activate zsh)"
command -v starship >/dev/null && eval "$(starship init zsh)"

source "$HOME/.config/zsh/aliases.zsh"

# Plugins (Homebrew). syntax-highlighting must be sourced before history-substring-search.
for plugin in zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search; do
  [[ -r "$HOMEBREW_PREFIX/share/$plugin/$plugin.zsh" ]] && source "$HOMEBREW_PREFIX/share/$plugin/$plugin.zsh"
done
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Machine-specific overrides (not versioned)
[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
