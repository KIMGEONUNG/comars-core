#!/bin/bash

set -e

echo \# BUILD VIM CONFIGURATION

# SHARED VIMRC AND NEWVIMRC
mkdir -p ~/.config
ln -s $(pwd)/nvim ~/.config/ -f -v

# LINK FOR CONFIGS
ln -sfv $(pwd)/pycodestyle ~/.config/pycodestyle
ln -sfv $(pwd)/.style.yapf ~/.style.yapf
