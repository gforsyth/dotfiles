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

au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile
