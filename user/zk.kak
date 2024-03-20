# zk commands

define-command -params 1..2 \
    -docstring %{
        zk-new <title> [<directory>]: Create a zk node with the tile. Your kakoune pwd should be root directory of a zk notebook.
    } zk-new %{
        nop %sh{
            zk new -t "$@" --no-input
        }
        evaluate-commands %sh{
            # Asi nos aseguramos que se habra la nota que ha sido creada mas recientemente
            # BUG: No encuentra cuando los nombres son con varias palabras.
            name=$(echo $1 | tr " " "-")
            file=$(fd -i --type file "$name" -x stat --format="%w %n" {} | sort -n | cut -d " " -f 4 | tail -1)
            # echo $file

                printf %s\\n "edit $file"
        }
    }

define-command -params 1..2 \
    -docstring %{
        zk-insert-new-node-link <title> [<directory>]: insert a link to a node that does not exist. It creates the node with the title and directory specified. Your kakoune pwd should be the root of a zk notebook
    } zk-insert-new-node-link %{
        nop %sh{
            zk new -t "$@" --no-input
        }
        evaluate-commands %sh{
            # Asi nosee aseguramos que se habra la nota que ha sido creada mas recientemente
            name=$(echo $1 | tr " " "-")
            file=$(fd -i --type file "$name" -x stat --format="%w %n" {} | sort -n | tail -1 | cut -d " " -f 4 | cut -c 3-)

            # Initialize the path variable to the current directory
            path=$(dirname "$kak_buffile")

            # Initialize the relative path variable
            relative_path=""

            # Loop until the home directory is reached
            while [ "$path" != "/" ]; do
                # Check if the .zk folder exists in the current directory
                if [ -d "$path/.zk" ]; then
                    break
                else
                    # Append "../" to the relative path
                    relative_path="../$relative_path"
                    # Move up to the parent directory
                    path=$(dirname "$path")
                fi
            done
            printf %s\\n "execute-keys %{i[]()<esc>hi$relative_path$file<esc><a-f>];i}"
        }
    }

define-command -docstring %{
        Prompt all the nodes and when you select one, it inserts the link to that node where the cursor is placed. Your kakoune pwd should be the root of a zk notebook.
    } zk-insert-link %{
        prompt node: -menu -shell-script-candidates "fd --type=file" %{
            evaluate-commands %sh{
                # Initialize the path variable to the current directory
                path=$(dirname "$kak_buffile")

                # Initialize the relative path variable
                relative_path=""

                # Loop until the home directory is reached
                while [ "$path" != "/" ]; do
                    # Check if the .zk folder exists in the current directory
                    if [ -d "$path/.zk" ]; then
                        break
                    else
                        # Append "../" to the relative path
                        relative_path="../$relative_path"
                        # Move up to the parent directory
                        path=$(dirname "$path")
                    fi
                done

                printf %s\\n "execute-keys %{i[]()<esc>hi$relative_path$kak_text<esc><a-f>];i}"

            }
        }
    }

declare-user-mode zk
map global zk n ':zk-new '                      -docstring 'Create and open new zk node'
map global zk l ':zk-insert-link<ret>'          -docstring 'Insert a link to a node'
map global zk k ':zk-insert-new-node-link<ret>' -docstring 'Insert a link to a non-existent node (creates it)'
