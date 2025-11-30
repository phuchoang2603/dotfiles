#!/bin/bash
# Bash Configuration

# -----------------------------------------------------------------------------
# Bash-specific Configuration (only run in bash)
# -----------------------------------------------------------------------------
if [ -n "$BASH_VERSION" ]; then
  # History Configuration
  shopt -s histappend
  HISTCONTROL=ignoreboth
  HISTSIZE=32768
  HISTFILESIZE="${HISTSIZE}"

  # Bash Completion
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  fi
fi

# -----------------------------------------------------------------------------
# Source Shared Configuration
# -----------------------------------------------------------------------------

# Source shared shell configuration files
[ -f ~/.config/zsh/env.sh ] && source ~/.config/zsh/env.sh
[ -f ~/.config/zsh/aliases.sh ] && source ~/.config/zsh/aliases.sh
[ -f ~/.config/zsh/functions.sh ] && source ~/.config/zsh/functions.sh
[ -f ~/.config/zsh/tools.sh ] && source ~/.config/zsh/tools.sh
