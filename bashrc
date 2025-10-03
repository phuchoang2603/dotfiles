# History control
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=32768
HISTFILESIZE="${HISTSIZE}"

# Set complete path
export PATH="./bin:$HOME/.local/bin:$HOME/.spicetify:$HOME/.krew/bin:$HOME/.local/share/omakub/bin:$PATH"
set +h

export OMAKUB_PATH="/home/$USER/.local/share/omakub"

# Fzf default command
export FZF_DEFAULT_COMMAND='fd --type f --hidden --strip-cwd-prefix --exclude .git --exclude mnt'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Editor used by CLI
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export TERM=xterm-256color

# Autocompletion
source /usr/share/bash-completion/bash_completion

if command -v mise &>/dev/null; then
  eval "$(mise activate bash)"
fi

if command -v fzf &>/dev/null; then
  eval "$(fzf --bash)"
fi

if command -v starship &>/dev/null; then
  eval "$(starship init bash)"
fi

if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
  tmux new-session -A -s ${USER} >/dev/null 2>&1
fi

if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

if command -v kubectl &>/dev/null; then
  export KUBECONFIG=$(find ~/.kube \( -name '*.yaml' -o -name '*.yml' \) -print0 | xargs -0 echo | tr ' ' ':')
  source <(kubectl completion bash)
fi

if command -v zoxide &>/dev/null; then
  eval "$(zoxide init bash)"
fi
