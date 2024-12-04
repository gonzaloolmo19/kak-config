

# [[ Mappings ]]
map global user / ':grepfile<ret>'                                                  -docstring 'grep in curren buffer'

# System clipboard
map global user y '<a-|>xclip -i -selection clipboard<ret>'                         -docstring 'yeet to system clipboard'
map global user p '!xclip -o<ret>'                                                  -docstring 'paste from system clipboard'

# file pickers
map global user b ':open_buffer_picker<ret>'                                        -docstring 'pick buffer'
map global user f ':open_file_picker<ret>'                                          -docstring 'pick file'
map global user F ':open_rg_picker<ret>'                                            -docstring 'search project'

# grep
map global user g ':grep '  -docstring 'grep in workspace'

# Harpoon
harpoon-add-bindings

# LSP mappings
map global user l %{:enter-user-mode lsp<ret>}                                      -docstring "LSP mode"
map global insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Select next snippet placeholder'
map global object a '<a-semicolon>lsp-object<ret>'                                  -docstring 'LSP any symbol'
map global object <a-a> '<a-semicolon>lsp-object<ret>'                              -docstring 'LSP any symbol'
map global object f '<a-semicolon>lsp-object Function Method<ret>'                  -docstring 'LSP function or method'
map global object t '<a-semicolon>lsp-object Class Interface Struct<ret>'           -docstring 'LSP class interface or struct'
map global object d '<a-semicolon>lsp-diagnostic-object --include-warnings<ret>'    -docstring 'LSP errors and warnings'
map global object D '<a-semicolon>lsp-diagnostic-object<ret>'                       -docstring 'LSP errors'

# Broot mappings
map global user t ':br-vert<ret>' -docstring 'Open broot in a vertical split'
map global user T ':br-hor<ret>' -docstring 'Open broot in a horizontal split'

# zellij
map global user w %{:enter-user-mode window-zellij<ret>}                            -docstring "window management (zellij)"

# fzf mode
map global user z :fzf-mode<ret>                                                    -docstring "fzf mode"

# zk
hook global WinSetOption filetype=markdown %{
    map global user n ':enter-user-mode zk<ret>'    -docstring 'zk mode'
}



# Los dos siguientes bloques son para poder ciclar por el menu
# de compleciones con tab y s-tab en sentido contrario.
# hook global InsertCompletionShow .* %{
#     map window insert <tab> <c-n>
#     map window insert <s-tab> <c-p>
# }
# 
# hook global InsertCompletionHide .* %{
#     unmap window insert <tab> <c-n>
#     unmap window insert <s-tab> <c-p>
# }
