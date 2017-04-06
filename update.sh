#!/bin/bash

git pull origin master
sh symlinks.sh

cd ${ZDOTDIR:-$HOME}/.zprezto
git pull && git submodule update --init --recursive
