#!/bin/bash

set -e

echo \# BUILD LAZYGIT CONFIGURATION

# SHARED VIMRC AND NEWVIMRC
mkdir -p ~/.config/lazygit
ln -s $(pwd)/config.yml ~/.config/lazygit -f -v
