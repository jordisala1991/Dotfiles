#!/usr/bin/env zsh

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

[ -r "${HOME}/.aliases" ] && [ -f "${HOME}/.aliases" ] && source "${HOME}/.aliases";
