#!/bin/bash

# Base path of your dotfiles repo
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_TARGET="$HOME/.config"

mkdir -p "$CONFIG_TARGET"

# Files or directories to copy (only their contents)
COPY_ITEMS=(
  "autostart"
  "fcitx5"
  "filecxx"
  "rclone"
  "Code"
)

# Items to exclude from symlinking
EXCLUDE_ITEMS=(
  "symlink.sh"
  ".git"
  ".gitignore"
  "README.md"
  "${COPY_ITEMS[@]}"
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

echo "📄 Copying contents into folders..."

for item in "${COPY_ITEMS[@]}"; do
  src="$DOTFILES_DIR/$item"
  dest="$CONFIG_TARGET/$item"

  echo "→ Copy contents of: $item"
  mkdir -p "$dest"

  for f in "$src"/*; do
    [[ -e "$f" ]] || continue # skip if empty
    fname=$(basename "$f")
    echo "   ↪ $fname"
    rm -rf "$dest/$fname" && cp -r "$f" "$dest/"
  done
done

[ -f "~/.bashrc" ] && mv ~/.bashrc ~/.bashrc.bak
cp ~/.config/bashrc ~/.bashrc
[ -f "~/.inputrc" ] && mv ~/.inputrc ~/.inputrc.bak
cp ~/.config/inputrc ~/.inputrc
[ -f "~/.bash_completion" ] && mv ~/.bash_completion ~/.bash_completion.bak
cp ~/.config/bash_completion ~/.bash_completion

echo "✅ Done."
