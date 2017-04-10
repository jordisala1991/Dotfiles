#!/usr/bin/env zsh

[ -s "${HOME}/.exports" ] && \. "${HOME}/.exports";
[ -s "${HOME}/.aliases" ] && \. "${HOME}/.aliases";
[ -s "${HOME}/.zprezto/init.zsh" ] && \. "${HOME}/.zprezto/init.zsh";
[ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh" --no-use;
