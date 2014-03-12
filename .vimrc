set nohlsearch
set bg=dark
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
syntax on

filetype indent on
filetype on
filetype plugin on
set noswapfile
set lines=40
set columns=140
set softtabstop=4
set smarttab

let g:tex_flavor = 'latex'

set foldmethod=indent
set foldlevel=20

call pathogen#infect()
call pathogen#helptags()

" Recommended for xelatex users who wants SyncTeX support
let g:tex_nine_config = {
    \'compiler': 'xelatex'
\}

let maplocalleader = ","

nnoremap <F5> "=strftime("%y-%m-%d %H:%M:%S")<CR>P 
inoremap <F5> <C-R>=strftime("%y-%m-%d %H:%M:%S")<CR> 
