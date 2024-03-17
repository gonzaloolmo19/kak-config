
define-command \
    -docstring ":grep in the current buffer" grepfile %{
        prompt grep: %{grep %val{text} %val{buffile}}
    }

