

# [[ Mappings ]]
map global user f :fzf-mode<ret>                                                         -docstring "fzf"
map global user / ':grepfile<ret>'                  -docstring 'grep in curren buffer'

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


# LSP mappings
map global user l %{:enter-user-mode lsp<ret>} -docstring "LSP mode"
map global insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Select next snippet placeholder'
map global object a '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
map global object <a-a> '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
map global object f '<a-semicolon>lsp-object Function Method<ret>' -docstring 'LSP function or method'
map global object t '<a-semicolon>lsp-object Class Interface Struct<ret>' -docstring 'LSP class interface or struct'
map global object d '<a-semicolon>lsp-diagnostic-object --include-warnings<ret>' -docstring 'LSP errors and warnings'
map global object D '<a-semicolon>lsp-diagnostic-object<ret>' -docstring 'LSP errors'

# Harpoon
harpoon-add-bindings


# zellij
map global user w %{:enter-user-mode window-zellij<ret>} -docstring "window management (zellij)"
