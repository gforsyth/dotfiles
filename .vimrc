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
set lines=24
set columns=80
set softtabstop=4
set smarttab

set foldmethod=indent
set foldlevel=20

set clipboard=unnamedplus

call pathogen#infect()
call pathogen#helptags()

let maplocalleader = ","

nnoremap <F5> "=strftime("%y-%m-%d %H:%M:%S")<CR>P 
inoremap <F5> <C-R>=strftime("%y-%m-%d %H:%M:%S")<CR> 
