#!/bin/sh
# Aliases - compatible with bash and zsh

# File operations
alias ls='eza -lh --group-directories-first --icons=auto'
alias lt='eza --tree --level=2'
alias copy='rclone copy --progress --multi-thread-streams=32'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Application shortcuts
alias v='nvim'
alias g='git'
alias d='docker'
alias dcp='docker compose'
alias lzg='lazygit'
alias lzd='lazydocker'
alias asr='atuin scripts run'

# Kubernetes
alias kx='kubectx'
alias kn='kubens'
alias k='kubectl'
alias ka='kubectl get all'
alias h='helm'
