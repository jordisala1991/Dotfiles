#!/bin/bash

git pull origin master
sh symlinks.sh

pushd ${HOME}/.zprezto
git pull && git submodule update --init --recursive
popd
