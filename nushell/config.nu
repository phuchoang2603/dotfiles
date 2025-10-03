$env.config = {
  buffer_editor: "nvim"
  edit_mode: vi
  show_banner: false
  use_kitty_protocol: true
  cursor_shape: {
    vi_insert: line
    vi_normal: block
  }

  keybindings: [
    {
      name: move_one_word_right_or_take_history_hint_word
      modifier: control
      keycode: char_w
      mode: [vi_normal, vi_insert]
      event: {
        until: [
          { send: historyhintwordcomplete }
          { edit: movewordright }
        ]
      }
    }
    {
      name: delete_one_word_backward
      modifier: control
      keycode: char_b
      mode: [vi_normal, vi_insert]
      event: { edit: backspaceword }
    }
    {
      name: move_to_line_end_or_take_history_hint
      modifier: control
      keycode: char_e
      mode: [vi_normal, vi_insert]
      event: {
        until: [
          { send: historyhintcomplete }
          { edit: movetolineend }
        ]
      }
    }
  ]

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
alias ka = kubectl get all
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

# tmux
def tn [] {
    let session_name = ($env.PWD | path basename)

    if ((tmux has-session -t $session_name | complete).exit_code == 0) {
        tmux attach -t $session_name
    } else {
        tmux new -s $session_name
    }
}
