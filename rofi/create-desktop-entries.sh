#!/bin/bash

# Destination for .desktop files
DEST_DIR="$HOME/.local/share/applications"
mkdir -p "$DEST_DIR"

# Ensure $OMAKUB_PATH/bin exists
mkdir -p "$OMAKUB_PATH/bin"

# Generate desktop entry content
desktop-entry() {
  cat <<EOF
[Desktop Entry]
Name=$1
Comment=
Exec=$2
Icon=applications-accessories
Terminal=false
Type=Application
Categories=Rofi;Desktop;
EOF
}

# Loop through all files in scripts/ (without .sh)
for f in scripts/*; do
  [ -f "$f" ] || continue

  filename="${f##*/}"                          # "foo"
  desktopname="$filename.desktop"              # "foo.desktop"
  new_script_path="$OMAKUB_PATH/bin/$filename" # Target: bin/foo

  # Copy to bin and make executable
  cp "$f" "$new_script_path"
  chmod +x "$new_script_path"

  # Generate .desktop file pointing to $OMAKUB_PATH/bin/foo
  desktop-entry "$filename" "$new_script_path" >"$DEST_DIR/$desktopname"
  chmod +x "$DEST_DIR/$desktopname"
done
