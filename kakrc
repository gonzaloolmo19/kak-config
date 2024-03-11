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

hook global WinSetOption filetype=(rust|python|go|javascript|typescript|c|cpp) %{
    lsp-enable-window
}


# Catppuccin
plug "catppuccin/kakoune" theme config %{
	colorscheme catppuccin_mocha
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
