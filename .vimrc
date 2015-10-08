set nocompatible

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"To install, run :PluginInstall, or :PluginUpdate
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/TeX-9'
Plugin 'tpope/vim-unimpaired'
Plugin 'davidhalter/jedi-vim'
call vundle#end()

"shortcuts for resizing splits
map <C-l> 5<C-w>>
map <C-h> 5<C-w><
map <C-j> 3<C-w>+
map <C-k> 3<C-w>-

set bg=dark
set nohlsearch
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
" set lines=54
set columns=80
set softtabstop=4
set smarttab

set foldmethod=indent
set foldlevel=20

set clipboard=unnamedplus

set cmdheight=2

" Ignore case when searching
"set ignorecase

" Turn off vim backup stuff -- not really necessary
set nobackup
set nowb
set noswapfile

" Leader key for plugins
let mapleader = ""
" TeX_9 settings
let g:tex_flavor = 'latex'
let g:tex_nine_config = {'compiler': 'pdflatex', 'viewer': 'llpp'}


nnoremap <F5> "=strftime("%F")<CR> 
inoremap <F5> <C-R>=strftime("%F")<CR> 

" Map TagList toggle to F8 and set default window width
nmap <F8> :TlistToggle<CR>
let Tlist_WinWidth=50
" 
" If filetype is cpp, bind F4 to run g++, run file and remove
autocmd filetype cpp nnoremap <F4> :w <bar> exec '!g++ -std=c++11 '.shellescape('%').' -o '.shellescape('bin/%:r').' && ./'.shellescape('bin/%:r')<CR>
autocmd filetype c nnoremap <F4> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>

