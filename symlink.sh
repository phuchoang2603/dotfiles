#!/bin/bash

# Base path of your dotfiles repo
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_TARGET="$HOME/.config"

# Files or directories to copy (only their contents)
COPY_ITEMS=(
  "autostart"
  "fcitx5"
  "filecxx"
  "rclone"
)

# Items to exclude from symlinking
EXCLUDE_ITEMS=(
  "symlink.sh"
  ".git"
  ".gitignore"
  "${COPY_ITEMS[@]}"
)

# Enable dry-run if argument or env var is set
DRY_RUN="${DRY_RUN:-false}"
[[ "$1" == "--dry-run" ]] && DRY_RUN=true
[[ "$DRY_RUN" == "true" ]] && echo "🔍 Dry run enabled — no files will be modified."

echo "🔗 Creating symlinks..."

for item in "$DOTFILES_DIR"/* "$DOTFILES_DIR"/.*; do
  basename_item="$(basename "$item")"

  # Skip . and ..
  [[ "$basename_item" == "." || "$basename_item" == ".." ]] && continue

  # Skip excluded items
  if [[ " ${EXCLUDE_ITEMS[*]} " == *" $basename_item "* ]]; then
    continue
  fi

  src="$DOTFILES_DIR/$basename_item"
  dest="$CONFIG_TARGET/$basename_item"

  echo "→ Symlink: $basename_item"
  $DRY_RUN || rm -rf "$dest"
  $DRY_RUN || ln -s "$src" "$dest"
done

echo "📄 Copying contents into folders..."

for item in "${COPY_ITEMS[@]}"; do
  src="$DOTFILES_DIR/$item"
  dest="$CONFIG_TARGET/$item"

  echo "→ Copy contents of: $item"
  $DRY_RUN || mkdir -p "$dest"

  for f in "$src"/*; do
    [[ -e "$f" ]] || continue # skip if empty
    fname=$(basename "$f")
    echo "   ↪ $fname"
    $DRY_RUN || rm -rf "$dest/$fname"
    $DRY_RUN || cp -r "$f" "$dest/"
  done
done

echo "✅ Done."
