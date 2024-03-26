# [[ User scripts ]]

# Por problemas que desconozco cada vez que quiera hacer un kakscript tengo
# que hacer source por el hecho de que no puedo usar la carpeta autoload.
# Si lo hago no me funcionan los plugins.
source "%val{config}/user/surround.kak"
source "%val{config}/user/options.kak"
source "%val{config}/user/just.kak"
source "%val{config}/user/harpoon.kak"
source "%val{config}/user/file_pickers.kak"
source "%val{config}/user/zellij.kak"
source "%val{config}/user/small_commands.kak"
source "%val{config}/user/zk.kak"
source "%val{config}/user/broot.kak"
source "%val{config}/user/mappings.kak"


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
hook global WinSetOption filetype=(rust|python|c|cpp|ruby|java|bash|markdown|latex) %{
    lsp-enable-window
    lsp-inlay-hints-enable global
}

# Autopairs
plug "alexherbo2/auto-pairs.kak"
set-option global auto_pairs ( ) { } [ ] '"' '"' "'" "'" ` ` “ ” ‘ ’ « » ‹ ›
enable-auto-pairs


# smart indent
plug "andreyorst/smarttab.kak" defer smarttab %{
    # when `backspace' is pressed, 4 spaces are deleted at once
    set-option global softtabstop 4
} config %{
    # these languages will use `expandtab' behavior
    hook global WinSetOption filetype=(rust|markdown|kak|lisp|scheme|sh|perl|ruby|java|python) expandtab
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


