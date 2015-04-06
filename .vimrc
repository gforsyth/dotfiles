set nohlsearch
set bg=dark
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
syntax on
set nu

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

" nnoremap <F5> "=strftime("%y-%m-%d %H:%M:%S")<CR>P 
" inoremap <F5> <C-R>=strftime("%y-%m-%d %H:%M:%S")<CR> 
" 
" If filetype is cpp, bind F4 to run g++, run file and remove
autocmd filetype cpp nnoremap <F4> :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('bin/%:r').' && ./'.shellescape('%:r')<CR>
autocmd filetype c nnoremap <F4> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
