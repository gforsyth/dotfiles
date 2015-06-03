"theme for lightline (tab numbers and info bar)
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
set laststatus=2

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

nnoremap <F5> "=strftime("%F")<CR> 
inoremap <F5> <C-R>=strftime("%F")<CR> 
" 
" If filetype is cpp, bind F4 to run g++, run file and remove
autocmd filetype cpp nnoremap <F4> :w <bar> exec '!g++ -std=c++11 '.shellescape('%').' -o '.shellescape('bin/%:r').' && ./'.shellescape('bin/%:r')<CR>
autocmd filetype c nnoremap <F4> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>

