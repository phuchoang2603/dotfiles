#!/bin/bash

# Base path of your dotfiles repo
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_TARGET="$HOME/.config"

mkdir -p "$CONFIG_TARGET"

EXCLUDE_ITEMS=(
  "symlink.sh"
  ".git"
  ".gitignore"
  "README.md"
)

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
  rm -rf "$dest" && ln -s "$src" "$dest"
done

[ -f "~/.bashrc" ] && mv ~/.bashrc ~/.bashrc.bak
cp ~/.config/bashrc ~/.bashrc
[ -f "~/.inputrc" ] && mv ~/.inputrc ~/.inputrc.bak
cp ~/.config/inputrc ~/.inputrc

echo "✅ Done."
