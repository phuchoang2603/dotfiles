$env.config.keybindings ++= [
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
  {
    name: clear_screen
    modifier: control
    keycode: char_l
    mode: [vi_normal vi_insert]
    event: {send: clearscrollback}
  }
  {
    name: clear_current_line
    modifier: control
    keycode: char_u
    mode: [vi_normal, vi_insert]
    event: { edit: clear }
  }
]
