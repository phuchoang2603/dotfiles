#!/bin/sh
# Environment variables - compatible with bash and zsh

# PATH
export PATH="$HOME/.local/bin:$HOME/.spicetify:$HOME/.krew/bin:$HOME/.cargo/bin:$HOME/.local/share/omakub/bin:$PATH"

# Editor
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

# Terminal
export TERM="xterm-256color"

# Omakub
export OMAKUB_PATH="$HOME/.local/share/omakub"

# Kubernetes - merge all kube config files
export KUBECONFIG=$(find ~/.kube -name "*.yml" 2>/dev/null | tr '\n' ':' | sed 's/:$//')

# FZF Configuration
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
export FZF_ALT_C_COMMAND="fd --type directory --hidden"
export FZF_ALT_C_OPTS="--preview 'eza -1 --color=always {} || ls --color=always {}'"
