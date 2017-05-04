colorscheme zenburn
set global tabstop 2

hook global WinCreate .* %{addhl number_lines}

hook global InsertChar j %{ try %{
    exec -draft hH <a-k>kj<ret> d
    exec <esc>
}}

def find -params 1 -shell-candidates %{ find -type f } %{ edit %arg{1} }

map global normal <space> ,
map global normal , <space> 

map -docstring "Find files inside the used dir." global user f ':find '
map global user c ':e ~/.config/kak/kakrc<ret>'

