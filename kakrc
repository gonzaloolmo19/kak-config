# [[ Options ]]
add-highlighter global/ number-lines -relative -hlcursor
colorscheme kanagawa
set-option global tabstop 4

# highligth trailing white-spaces
add-highlighter global/ regex \h+$ 0:Error

# softwrap
add-highlighter global/ wrap -word -indent

# Hacer que el cursor siempre tenga 8 columnas y filas hacia arriba
# y hacia abajo
set-option global scrolloff 8,8

# Cursor cambia de color cuando en distintos modos
# Shades of blue/cyan for normal mode
set-face global PrimarySelection white,blue+F
set-face global SecondarySelection black,blue+F
set-face global PrimaryCursor black,bright-cyan+F
set-face global SecondaryCursor black,bright-blue+F
set-face global PrimaryCursorEol black,bright-cyan
set-face global SecondaryCursorEol black,bright-blue

# Shades of green/yellow for insert mode.
hook global ModeChange (push|pop):.*:insert %{
    set-face window PrimarySelection white,green+F
    set-face window SecondarySelection black,green+F
    set-face window PrimaryCursor black,bright-yellow+F
    set-face window SecondaryCursor black,bright-green+F
    set-face window PrimaryCursorEol black,bright-yellow
    set-face window SecondaryCursorEol black,bright-green
}

# Undo colour changes when we leave insert mode.
hook global ModeChange (push|pop):insert:.* %{
    unset-face window PrimarySelection
    unset-face window SecondarySelection
    unset-face window PrimaryCursor
    unset-face window SecondaryCursor
    unset-face window PrimaryCursorEol
    unset-face window SecondaryCursorEol
}


# [[ Plugins ]]
# plug.kak el plugin manager
evaluate-commands %sh{
    plugins="$kak_config/plugins"
    mkdir -p "$plugins"
    [ ! -e "$plugins/plug.kak" ] && \
        git clone -q https://github.com/andreyorst/plug.kak.git "$plugins/plug.kak"
    printf "%s\n" "source '$plugins/plug.kak/rc/plug.kak'"
}
plug "andreyorst/plug.kak" noload


# LSP
plug "kakoune-lsp/kakoune-lsp" do %{
    cargo install --locked --force --path .
    # optional: if you want to use specific language servers
    mkdir -p ~/.config/kak-lsp
    cp -n kak-lsp.toml ~/.config/kak-lsp/
}
hook global WinSetOption filetype=(rust|python|c|cpp|ruby|java|bash) %{
    lsp-enable-window
    lsp-inlay-hints-enable global
}

# Autopairs
plug "alexherbo2/auto-pairs.kak"
set-option global auto_pairs ( ) { } [ ] '"' '"' "'" "'" ` ` “ ” ‘ ’ « » ‹ ›
enable-auto-pairs

# fuzzy finder
plug "gustavo-hms/luar" %{
    plug "gustavo-hms/peneira" %{
        require-module peneira
    }
}

# smart indent
plug "andreyorst/smarttab.kak" defer smarttab %{
    # when `backspace' is pressed, 4 spaces are deleted at once
    set-option global softtabstop 4
} config %{
    # these languages will use `expandtab' behavior
    hook global WinSetOption filetype=(rust|markdown|kak|lisp|scheme|sh|perl|ruby|java) expandtab
    # these languages will use `noexpandtab' behavior
    hook global WinSetOption filetype=(makefile|gas) noexpandtab
    # these languages will use `smarttab' behavior
    hook global WinSetOption filetype=(c|cpp) smarttab

}


# fzf
plug "andreyorst/fzf.kak"


# [[ Language specific ]]
hook global WinSetOption filetype=ruby %{
    set-option buffer indentwidth 2
}


# [[ Mappings ]]
map global user f :fzf-mode<ret>            -docstring "fzf"
map global user q :lsp-diagnostics<ret>          -docstring "Show LSP diagnostics"


# Los dos siguientes bloques son para poder ciclar por el menu
# de compleciones con tab y s-tab en sentido contrario.
hook global InsertCompletionShow .* %{
    map window insert <tab> <c-n>
    map window insert <s-tab> <c-p>
}

hook global InsertCompletionHide .* %{
    unmap window insert <tab> <c-n>
    unmap window insert <s-tab> <c-p>
}


# LSP mappings
map global user l %{:enter-user-mode lsp<ret>} -docstring "LSP mode"
map global insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Select next snippet placeholder'
map global object a '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
map global object <a-a> '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
map global object f '<a-semicolon>lsp-object Function Method<ret>' -docstring 'LSP function or method'
map global object t '<a-semicolon>lsp-object Class Interface Struct<ret>' -docstring 'LSP class interface or struct'
map global object d '<a-semicolon>lsp-diagnostic-object --include-warnings<ret>' -docstring 'LSP errors and warnings'
map global object D '<a-semicolon>lsp-diagnostic-object<ret>' -docstring 'LSP errors'


