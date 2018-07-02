"------------------------------------
" Mazons vimrc
"------------------------------------
set nocompatible    " Don't be compatible with old vi.
scriptencoding utf-8 

filetype on "Detect file type.
"set list " Show tabs.
"set listchars=tab:>-
" Vundle Plugin Manager
set rtp+=~/.vim/bundle/Vundle.vim 
set cursorline
autocmd InsertLeave * highlight CursorLine guibg=#004000 guifg=fg

call vundle#begin() 
Plugin 'VundleVim/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'terryma/vim-smooth-scroll'
Plugin 'aserebryakov/vim-todo-lists'
Plugin 'rizzatti/dash.vim'
Plugin 'yuttie/comfortable-motion.vim'

call vundle#end()            
filetype plugin indent on   

let mapleader = ","
let maplocalleader = ",,"
"set runtimepath^=~/.vim/bundle/ctrlp.vim

"unknowns
set autowrite " auto save on make.
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window " . expand("%"))")
set t_ts=^[k
set wildmenu

" Line numbers
set relativenumber
set number

" System
set t_Co=256 " 256 colors
set noswapfile " Dont want any .swp laying around.
set clipboard=unnamed "Clipboard sync
set viminfo='1000,f1,:1000,/1000 " Enable a nice big viminfo file
set history=500
" Remove Banner from netrw
let g:netrw_banner = 0
" Make backspace delete lots of things
set backspace=indent,eol,start
" Show us the command we're typing
set showcmd
" Wrap on these
set whichwrap+=<,>,[,]
set fillchars=vert:┃,diff:⎼,fold:⎼
" Highlight matching parentes
set showmatch

" Search options
set incsearch
set ignorecase
set infercase
set hlsearch

" Show full tags when doing search completion
set showfulltag
set visualbell t_vb=
" Syntax on for showing colors from scheme.
syntax on

" Allow edit buffers to be hidden
set hidden

" 1 height windows
set winminheight=1

" Do clever indent things. Don't make a # force column zero.
set autoindent
set smartindent
inoremap # X<BS>#

" make Y and S effect to end of line instead of whole linee
map Y y$
map S s$

" Tab and Spaces
set shiftwidth=2 " By default, go for an indent of 2
set expandtab " Make tab always spaces.
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Set colorscheme to something beutiful.
 colorscheme vibrantink

" Filetype plugin eval.
if has("eval")
    filetype on
    filetype plugin on
    filetype indent on
endif

" Disable modelines, use securemodelines.vim instead
set nomodeline
let g:secure_modelines_verbose = 0
let g:secure_modelines_modelines = 15

" Statusline
set noshowmode " Hide default message when entering modes.
let g:airline_theme='bubblegum'
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
"--------------------------------------------------------

"Better include path handling
set path+=src/
let &inc.=' ["<]'

"source in keymappings.
source ~/.vim/keymap.vim
