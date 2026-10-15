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
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

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
