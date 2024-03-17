
# Simplemente es un prompt que lo que pongas lo pasa al comando :grep para que
# busque en el buffer actual
define-command \
    -docstring ":grep in the current buffer" grepfile %{
        prompt grep: %{grep %val{text} %val{buffile}}
    }

