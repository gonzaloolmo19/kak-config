# Kakoune Config
This my kakoune config. 

# Installation
You need kakoune installed and just clone this repo to ~/.config/kak/

``` bash
git clone https://github.com/gonzaloolmo19/kak-config.git ~/.config/kak
```

After this, run kakoune and type the command :plug-install several times until all plugins are correctly installed.

# Dependencies
Programs you might need installed: `fd`, `rg`, `fzf`, `broot`, `zellij`, `kak-lsp`, `kak-tree-sitter`, `ktsctl`.

## Language servers
You need the language servers installed for each programming language you use (and you have to add to the config in kakrc which languages are configured). Look in kak-lsp which language servers it uses for each language to intall it or change it (in ~/.config/kak-lsp/kak-lsp.toml).

## Treesitter
For treesitter syntax highligthing I use [kak-tree-sitter](https://sr.ht/~hadronized/kak-tree-sitter/). It is a standalone program that runs as a server and when kakoune starts it with a certain command, it enables highligthing and text-objects within kakoune.

Currently I am using clangd, rust-analyzer, solargraph, texlab, zk (lsp for markdown zettelkasten system. The program that provides this is [zk](https://github.com/zk-org/zk)), pylsp, bash-language-server.
