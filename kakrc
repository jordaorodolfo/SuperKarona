colorscheme zenburn
set global tabstop 2
set global indentwidth 2
set global autoreload yes

hook global WinCreate .* %{addhl number_lines}

hook global InsertChar j %{ try %{
    exec -draft hH <a-k>kj<ret> d
    exec <esc>
}}

def find -params 1 -shell-candidates %{ find -type f } %{ edit %arg{1} }


def ide %{
    rename-client main
    set global jumpclient main

    new rename-client tools
    set global toolsclient tools

    new rename-client docs
    set global docsclient docs
}


def -docstring "This command opens the buffer commander mode." buffer-commander %{
	on-key %{%sh{case "$kak_key" in
		"n") echo "bn" ;;
		"p") echo "bp" ;;
		"d") echo "db" ;;
		esac
	}}
	info -title "Buffers" %{
-n next
-p previous
-d delete
	}
}

def -docstring "This command opens the files comander mode" file-commander %{
	on-key %{%sh{case "$kak_key" in
		"f") echo exec ":find<space>";;
		"c") echo e ~/.config/kak/kakrc ;;
		"s") echo w ;;
		esac
	}}
	info -title "Files" %{
-f find
-c kakrc
-s save
	}
}


#map global normal <space> ,
#map global normal , <space>
map global normal '#' :comment-line<ret>

map -docstring "Paste the contents from clipboard" global user p '!xclip -o<ret>'
map -docstring "Yank the contents to clipboard" global user y '<a-|>xclip -i<ret>; :echo -color Information "copied selection to X11 clipboard"<ret>'

# map -docstring "Edit the Kakrc file" global user c ':e ~/.config/kak/kakrc<ret>'

map -docstring "Manage buffers" global user b ":buffer-commander<ret>"
map -docstring "Manage files" global user f ':file-commander<ret>'
