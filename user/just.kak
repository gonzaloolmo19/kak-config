define-command -params .. \
    -docstring %{
        make [<arguments>]: make utility wrapper
        All the optional arguments are forwarded to the make utility
     } just %{ evaluate-commands %sh{
     output=$(mktemp -d "${TMPDIR:-/tmp}"/kak-make.XXXXXXXX)/fifo
     mkfifo ${output}
     ( eval just "$@" > ${output} 2>&1 & ) > /dev/null 2>&1 < /dev/null

     printf %s\\n "evaluate-commands -try-client '$kak_opt_toolsclient' %{
               edit! -fifo ${output} -scroll *make*
               set-option buffer filetype make
               set-option buffer jump_current_line 0
               hook -always -once buffer BufCloseFifo .* %{ nop %sh{ rm -r $(dirname ${output}) } }
           }"
}}
