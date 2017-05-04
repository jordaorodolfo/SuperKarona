colorscheme zenburn
set global tabstop 2

hook global WinCreate .* %{addhl number_lines}

hook global InsertChar j %{ try %{
    exec -draft hH <a-k>kj<ret> d
    exec <esc>
}}

def find -params 1 -shell-candidates %{ find -type f } %{ edit %arg{1} }

def -docstring "This command opens the buffer commander mode." buffer-commander %{
	on-key %{%sh{case "$kak_key" in
		"n")
			echo "bn"
		;;
		"p")
			echo "bp"
		;;
		"d")
			echo "db"
		;;
		esac
	}}
	info -title "Buffers" %{"-n next \n p -previous \n -d delete"}
}

map global normal <space> ,
map global normal , <space> 

map -docstring "Find files inside the used dir." global user f ':find '
map -docstring "Edit the Kakrc file" global user c ':e ~/.config/kak/kakrc<ret>'

map -docstring "Manage buffers" global user b ":buffer-commander<ret>"
