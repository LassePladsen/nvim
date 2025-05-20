set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
set signcolumn=auto:2

" Call init.lua
lua require('init')

if !empty(glob("~/.vimrc"))
    source ~/.vimrc
endif

