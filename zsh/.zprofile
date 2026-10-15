# Login shell: environment and PATH.

eval "$(/opt/homebrew/bin/brew shellenv)"

typeset -gU path fpath
path=("$HOME/.local/bin" $path)

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
export LESS='-F -g -i -M -R -S -w -X -z-4'
export LANG="${LANG:-en_US.UTF-8}"

[[ "$OSTYPE" == darwin* ]] && export BROWSER='open'

# OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
