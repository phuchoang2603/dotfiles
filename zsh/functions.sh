#!/bin/sh
# Functions - compatible with bash and zsh

# Yazi - change directory on exit
y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# ImageMagick - convert image to PNG
img2png() {
  if [ -z "$1" ]; then
    echo "Usage: img2png <input_file>"
    return 1
  fi
  
  local input_file="$1"
  local file_stem="${input_file%.*}"
  local output_file="${file_stem}.png"
  
  magick "$input_file" "$output_file"
}

# Tmux - create or attach to session based on directory name
tn() {
  local session_name="$(basename "$PWD")"
  
  if tmux has-session -t "$session_name" 2>/dev/null; then
    tmux attach -t "$session_name"
  else
    tmux new -s "$session_name"
  fi
}
