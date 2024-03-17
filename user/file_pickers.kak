## Some pickers
define-command -hidden open_buffer_picker %{
  prompt buffer: -menu -buffer-completion %{
    buffer %val{text}
  }
}

define-command -hidden open_file_picker %{
  prompt file: -menu -shell-script-candidates 'fd --type=file' %{
    edit -existing %val{text}
  }
}

define-command file-picker %{
  try %{
    edit -scratch '*file-picker*'

    map buffer normal <ret> 'x_gf'
    add-highlighter buffer/file-picker-item regex (.*) 1:cyan
    set-option buffer swiper_callback 'x_gf'

    execute-keys '|fd --type=file<ret>gg'
  }
}

define-command -hidden open_rg_picker %{
  prompt search: %{
    prompt refine: -menu -shell-script-candidates "rg -in --column '%val{text}'" %{
      evaluate-commands "edit -existing %sh{
        IFS=':' read -r file line column rest <<< ""$kak_text""
        echo \""$file\"" $line $column
      }"
    }
  }
}
