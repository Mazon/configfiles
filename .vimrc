" Plugins 
set rtp+=~/.vim/bundle/Vundle.vim 
call vundle#begin() 
Plugin 'VundleVim/Vundle.vim' " Plugin manager :PluginInstall
Plugin 'fatih/vim-go' " Understand go
Plugin 'tpope/vim-fugitive' " Understand git
Plugin 'vim-airline/vim-airline' " Lean statusline
Plugin 'vim-airline/vim-airline-themes' " theme airline
Plugin 'terryma/vim-smooth-scroll' " smooth scrooling
call vundle#end()            

" General
set nocompatible "Don't be compatible with old vi.
colorscheme palenight "Set colorscheme to something beutiful.
scriptencoding utf-8 
filetype on "Detect file type.
filetype plugin indent on   
set noswapfile " Dont want any .swp laying around.
set clipboard=unnamed "Clipboard sync os x
set viminfo='1000,f1,:1000,/1000 " Enable a nice big viminfo file
set history=500
syntax on " Syntax on for showing colors from scheme.
set t_Co=256 " 256 colors
let g:netrw_banner = 0 " Remove Banner from netrw
set showcmd " Show us the command we're typing
set cursorline
autocmd InsertLeave * highlight CursorLine guibg=#004000 guifg=fg

" Line numbers
set relativenumber
set number
set visualbell t_vb= " no bell
set hidden " Allow edit buffers to be hidden
set winminheight=1 " 1 height windows
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window " . expand("%"))")
set t_ts=^[k " set window title to:

" Fuzzy File Search
set rtp+=/usr/local/opt/fzf

" Search
set incsearch
set ignorecase
set infercase
set hlsearch
set showmatch " Highlight matching parentes
set showfulltag " Show full tags when doing search completion

" Text, tab and indent related
set shiftwidth=2 " By default, go for an indent of 2
set expandtab " Make tab always spaces.
set tabstop=2
set softtabstop=2
set backspace=indent,eol,start " Make backspace delete lots of things
set autoindent " Do clever indent things. Don't make a # force column zero.
set smartindent

inoremap # X<BS>#
set whichwrap+=<,>,[,] " Wrap on these
set fillchars=vert:┃,diff:⎼,fold:⎼
set path+=Documents/ "Better include path handling
let &inc.=' ["<]'

" Statusline
set noshowmode " Hide default message when entering modes.
"let g:airline_theme='nord'
let g:airline_powerline_fonts=0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1

set laststatus=2
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%=                           " right align
set statusline+=%2*
setlocal numberwidth=3

set nomodeline " Disable modelines, use securemodelines.vim instead
let g:secure_modelines_verbose = 0
let g:secure_modelines_modelines = 15

" Keymaps
let mapleader = "," " set leader key
inoremap ,, <Esc>
:nnoremap <leader>f :GFiles<cr>
:nnoremap <leader>F :Files<cr>
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
:nnoremap <leader>b :Buffers<cr>
:nnoremap <leader>g :Rg<cr>

au FileType go map <leader>r :!go run % 
"nnoremap / /\v 
nnoremap j gj
nnoremap k gk
" clear searches after 
nnoremap <CR> :nohlsearch<cr> 
" smooth  scrolling
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 5, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 5, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
" sudo save files if being stupid
cmap w!! w !sudo tee % >/dev/null

