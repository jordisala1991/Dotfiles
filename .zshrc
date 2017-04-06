#!/usr/bin/env zsh

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

for file in ~/.{aliases}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
