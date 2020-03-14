#!/bin/bash

git clone https://github.com/VundleVim/Vundle.vim.git "${HOME}/.vim/bundle/Vundle.vim"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${HOME}/.zprezto"

bash symlinks.bash

vim +PluginInstall +qall

