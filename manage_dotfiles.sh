#!/bin/bash

# Define the dotfiles directory and backup directory
DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Function to backup and remove existing dotfiles
backup_and_remove() {
  local file="$1"
  if [ -L "$HOME/$file" ]; then
    echo "Skipping symlink: $file"
    rm "$HOME/$file"
  elif [ -e "$HOME/$file" ]; then
    mv "$HOME/$file" "$BACKUP_DIR/"
    echo "Backed up and removed: $file"
  fi
}

# List of folders to ignore (add or remove as needed)
ignore_folders=(
  "scripts"
  "templates"
  "docs"
  "alacritty"
  "zsh"
  "qtile"
)

# Convert ignore_folders array to a string for use with grep
ignore_pattern=$(
  IFS="|"
  echo "${ignore_folders[*]}"
)

# Backup and remove existing dotfiles
cd "$DOTFILES_DIR" || exit

for dir in */; do
  dir=${dir%/} # Remove trailing slash
  if ! echo "$dir" | grep -qE "^($ignore_pattern)$"; then
    if [ "$(ls -A "$dir")" ]; then # Check if directory is not empty
      find "$dir" -type f | while read -r file; do
        relative_path="${file#./}"
        backup_and_remove "$relative_path"
      done
      stow "$dir"
      echo "Stowed $dir"
    else
      echo "Skipped empty directory: $dir"
    fi
  else
    echo "Ignored $dir"
  fi
done

echo "Dotfiles have been backed up to $BACKUP_DIR and new symlinks created with Stow, excluding specified folders."
