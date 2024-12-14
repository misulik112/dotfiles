#!/bin/bash

# Define the dotfiles directory and backup directory
DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Function to backup and remove existing dotfiles
backup_and_remove() {
  local file="$1"
  if [ -e "$HOME/$file" ]; then
    mv "$HOME/$file" "$BACKUP_DIR/"
    echo "Backed up and removed: $file"
  fi
}

# List of folders to ignore (add or remove as needed)
ignore_folders=(
  "scripts"
  "arconet-qtile"
  "templates"
  "docs"
  # Add more folders to ignore here
)

# Convert ignore_folders array to a string for use with grep
ignore_pattern=$(
  IFS="|"
  echo "${ignore_folders[*]}"
)

# Backup and remove existing dotfiles
cd "$DOTFILES_DIR"
for dir in */; do
  dir=${dir%/} # Remove trailing slash
  if ! echo "$dir" | grep -qE "^($ignore_pattern)$"; then
    for file in "$dir"/*; do
      if [ -f "$file" ]; then
        relative_path="${file#./}"
        backup_and_remove "$relative_path"
      fi
    done
    # Stow each directory individually
    stow "$dir"
    echo "Stowed $dir"
  else
    echo "Ignored $dir"
  fi
done

echo "Dotfiles have been backed up to $BACKUP_DIR and new symlinks created with Stow, excluding specified folders."
