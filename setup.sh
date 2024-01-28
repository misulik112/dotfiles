#!/bin/sh

# Enable shell script strictness
set -eu

# Enable command tracing
set -x

# Ensure config directory exists
mkdir -p ~/.config

# Link Git config if it doesn't exists
[ ! -e ~/.config/git ] && ln -s "$PWD/config/git" ~/.config/git

# Link Git config if it doesn't exists
[ ! -e ~/.config/qtile] && ln -s "$PWD/config/qtile" ~/.config/qtile

# Link Neovim config if it doesn't exists
[ ! -e ~/.config/nvim ] && ln -s "$PWD/config/nvim" ~/.config/nvim

# Link Xmodmap configuration
[ ! -e ~/.Xmodmap ] && ln -s "$PWD/config/Xmodmap" ~/.Xmodmap

# Link Alacritty config if it doesn't exists
[ ! -e ~/.config/alacritty ] && ln -s "$PWD/config/alacritty" ~/.config/alacritty

# Link ZSH config if it doesn't exists
#[ ! -e ~/.zshrc ] && ln -s "$PWD/config/zshrc" ~/.zshrc
