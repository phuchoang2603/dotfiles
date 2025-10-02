$env.config.buffer_editor = "nvim"
$env.config.show_banner = false

# Check if tmux exists, if we are in a graphical session, and not already in tmux
if (which tmux) != null and ($env.DISPLAY? | default '') != '' and ($env.TMUX? | default '') == '' {
    exec tmux new-session -A -s $env.USER &> /dev/null
}

# ALIAS
alias lt =  eza --tree --level=2 --long --icons --git
alias copy = rclone copy --progress --multi-thread-streams=32
alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..

alias v = nvim
alias g = git
alias d = docker
alias dcp = docker compose
alias lzg = lazygit
alias lzd = lazydocker
alias kx = kubectx
alias kn = kubens
alias k = kubectl
alias h = helm

# FUNCTIONS
# yazi-cwd
def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

# magick
def --env img2png [ input_file: string ] {
  let file_stem = ($input_file | path parse | get stem)
  let output_file = $"($file_stem).png"

  ^magick $input_file $output_file
}

# zoxide
def "nu-complete zoxide path" [context: string] {
    let parts = $context | split row " " | skip 1
    {
      options: {
        sort: false,
        completion_algorithm: substring,
        case_sensitive: false,
      },
      completions: (^zoxide query --list --exclude $env.PWD -- ...$parts | lines),
    }
  }

def --env --wrapped z [...rest: string@"nu-complete zoxide path"] {
  __zoxide_z ...$rest
}
