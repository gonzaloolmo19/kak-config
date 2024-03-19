
define-command br-vert -docstring "Opens broot in a vertical split" %{
    nop %sh{
        zellij action new-pane -cd right -- broot
    }
}


define-command br-hor -docstring "Opens broot in a vertical split" %{
    nop %sh{
        zellij action new-pane -cd down -- broot
    }
}
