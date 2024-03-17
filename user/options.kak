

# [[ Options ]]

colorscheme kanagawa

# Pongo el flag -j8 para que paralelice la compilacion de las cosas
set-option global makecmd 'make -j8'

# Uso ripgrep en lugar de grep para mayor velocidad en grandes repositorios
set-option global grepcmd 'rg -Hn --column --smart-case --sort path'

# Relative line numbers
add-highlighter global/ number-lines -relative -hlcursor

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
