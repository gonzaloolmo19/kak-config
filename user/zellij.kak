# Zellij integration with kakoune

define-command -hidden zellij-split -params 1 -docstring 'split (down / right)' %{
  nop %sh{
    zellij action new-pane -cd $1 -- kak -c $kak_session
  }
}

define-command -hidden zellij-move-focus -params 1 %{
  nop %sh{
    zellij action move-focus $1
  }
}

declare-user-mode window-zellij
map global window-zellij Q ':q!<ret>'                  -docstring 'close window (force)'
map global window-zellij q ':q<ret>'                   -docstring 'close window'
map global window-zellij h ':zellij-move-focus left<ret>' -docstring 'move left'
map global window-zellij j ':zellij-move-focus down<ret>' -docstring 'move down'
map global window-zellij k ':zellij-move-focus up<ret>' -docstring 'move up'
map global window-zellij l ':zellij-move-focus right<ret>' -docstring 'move right'
map global window-zellij s ':zellij-split down<ret>'       -docstring 'horizontal split'
map global window-zellij v ':zellij-split right<ret>'       -docstring 'vertical split'


