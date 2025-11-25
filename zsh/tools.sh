#!/bin/sh
# Tool integrations - compatible with bash and zsh

# Starship prompt
if command -v starship &>/dev/null; then
  if [ -n "$ZSH_VERSION" ]; then
    eval "$(starship init zsh)"
  elif [ -n "$BASH_VERSION" ]; then
    eval "$(starship init bash)"
  fi
fi

# Zoxide - smart directory jumping
if command -v zoxide &>/dev/null; then
  if [ -n "$ZSH_VERSION" ]; then
    eval "$(zoxide init zsh)"
  elif [ -n "$BASH_VERSION" ]; then
    eval "$(zoxide init bash)"
  fi
fi

# Mise - runtime version manager
if command -v mise &>/dev/null; then
  if [ -n "$ZSH_VERSION" ]; then
    eval "$(mise activate zsh)"
  elif [ -n "$BASH_VERSION" ]; then
    eval "$(mise activate bash)"
  fi
fi

# FZF - fuzzy finder (load BEFORE atuin so atuin can override Ctrl+R)
if command -v fzf &>/dev/null; then
  if [ -n "$ZSH_VERSION" ]; then
    source <(fzf --zsh)
  elif [ -n "$BASH_VERSION" ]; then
    eval "$(fzf --bash)"
  fi
fi

# Atuin - shell history (load AFTER fzf to override Ctrl+R)
if command -v atuin &>/dev/null; then
  if [ -n "$ZSH_VERSION" ]; then
    eval "$(atuin init zsh)"
  elif [ -n "$BASH_VERSION" ]; then
    eval "$(atuin init bash)"
  fi
fi

# Cargo environment
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

