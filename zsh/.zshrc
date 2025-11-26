#!/bin/zsh

# ZSH Configuration

# -----------------------------------------------------------------------------
# Source Shared Configuration
# -----------------------------------------------------------------------------
[ -f ~/.config/zsh/env.sh ] && source ~/.config/zsh/env.sh
[ -f ~/.config/zsh/aliases.sh ] && source ~/.config/zsh/aliases.sh
[ -f ~/.config/zsh/functions.sh ] && source ~/.config/zsh/functions.sh
[ -f ~/.config/zsh/tools.sh ] && source ~/.config/zsh/tools.sh

# -----------------------------------------------------------------------------
# History Configuration
# -----------------------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS

# -----------------------------------------------------------------------------
# Vi Mode Configuration
# -----------------------------------------------------------------------------
bindkey -v
export KEYTIMEOUT=1

# Vi cursor shape for different modes
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'  # block cursor
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'  # line cursor
  fi
}
zle -N zle-keymap-select

# Initialize with line cursor
echo -ne '\e[5 q'

# Reset cursor on each new prompt
function zle-line-init {
  echo -ne '\e[5 q'
}
zle -N zle-line-init

# -----------------------------------------------------------------------------
# Custom Key Bindings
# -----------------------------------------------------------------------------

# Ctrl+W - move word right
bindkey '^W' forward-word

# Ctrl+B - delete word backward
bindkey '^B' backward-delete-word

# Ctrl+E - move to end of line
bindkey '^E' end-of-line

# Ctrl+L - clear screen
bindkey '^L' clear-screen

# Ctrl+U - clear line
bindkey '^U' kill-whole-line

# Ctrl+A - move to beginning of line
bindkey '^A' beginning-of-line

# Ctrl+X - edit command line in editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X' edit-command-line

# -----------------------------------------------------------------------------
# Completion System
# -----------------------------------------------------------------------------

# Enable completion system
autoload -Uz compinit
compinit

# kubectl completion (must be after compinit)
if command -v kubectl &>/dev/null; then
  source <(kubectl completion zsh)
fi

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Enable group descriptions for fzf-tab
zstyle ':completion:*:descriptions' format '[%d]'

# Enable filename colorizing with LS_COLORS
if command -v dircolors &>/dev/null; then
  eval "$(dircolors -b)"
fi
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Disable default menu to let fzf-tab handle it
zstyle ':completion:*' menu no

# Enable completion menu for kill if fzf-tab isn't active
zstyle ':completion:*:*:kill:*' menu yes select

# -----------------------------------------------------------------------------
# fzf-tab Plugin
# -----------------------------------------------------------------------------

# Load fzf-tab (MUST be after compinit and zstyle configurations)
if [ -f ~/.config/zsh/fzf-tab/fzf-tab.plugin.zsh ]; then
  source ~/.config/zsh/fzf-tab/fzf-tab.plugin.zsh
 
  # Set switch group keys
  zstyle ':fzf-tab:*' switch-group '<' '>'

  # Disable preview
  zstyle ':fzf-tab:complete:*' fzf-flags --preview-window hidden 
fi

# -----------------------------------------------------------------------------
# zsh-autosuggestions Plugin
# -----------------------------------------------------------------------------

# Load zsh-autosuggestions
if [ -f ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  
  # Configure autosuggestions
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
fi

# -----------------------------------------------------------------------------
# Additional Options
# -----------------------------------------------------------------------------

# Auto cd when typing directory name
setopt AUTO_CD

# Corrections
setopt CORRECT

# Don't beep
setopt NO_BEEP

# Enable extended globbing
setopt EXTENDED_GLOB
