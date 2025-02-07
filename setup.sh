#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

cd "$DOTFILES_DIR" || exit

for folder in */; do
    stow "${folder%/}"
done

echo "Dotfiles have been successfully linked!"
