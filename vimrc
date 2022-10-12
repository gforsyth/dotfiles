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

" vim on Linux
autocmd BufNewFile,BufRead /dev/shm/gopass* setlocal noswapfile nobackup noundofile viminfo=""

if exists('$TMUX')
    " tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
    let &t_SI .= "\<Esc>Ptmux;\<Esc>\<Esc>[4 q\<Esc>\\"
    let &t_EI .= "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
    autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033[0 q\033\\"
else
    let &t_SI .= "\<Esc>[4 q"
    let &t_EI .= "\<Esc>[2 q"
    autocmd VimLeave * silent !echo -ne "\033[0 q"
endi
