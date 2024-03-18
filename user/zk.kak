# zk commands

define-command -params .. \
    -docstring %{
        zk-new <title> [<directory>]: Create a zk node with the tile (you need to be in a zk notebook)
    } zk-new %{
        nop %sh{
            zk new -t "$@" --no-input
        }
        evaluate-commands %sh{
            # Asi nos aseguramos que se habra la nota que ha sido creada mas recientemente
            file=$(fd --type file "$1" -x stat --format="%w %n" {} | sort -n | cut -d " " -f 4 | tail -1)

            printf %s\\n "execute-keys ':e $file<ret>'"
        }
    }

define-command -docstring %{
        Prompt all the nodes and when you select one, it inserts the link to that node where the cursor is placed. It only works if you are working inside of a zk notebook
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
