#!/bin/bash

set -e

echo \# Build vim configuration

# shared vimrc and newvimrc
mkdir -p ~/.config
ln -s $(pwd)/nvim ~/.config/nvim -f -v
