"Plugins 
set rtp+=~/.vim/bundle/Vundle.vim 
call vundle#begin() 
Plugin 'VundleVim/Vundle.vim' 
Plugin 'fatih/vim-go' 
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline' 
Plugin 'vim-airline/vim-airline-themes' 
Plugin 'terryma/vim-smooth-scroll' 
call vundle#end()            

"General
set nocompatible "Don't be compatible with old vi.
set t_Co=256 "256 colors
colorscheme palenight "Set colorscheme to something beutiful. Scriptencoding utf-8 
syntax on "Syntax on for showing colors from scheme.
filetype on "Detect file type.
filetype plugin indent on   
set noswapfile "Dont want any .swp laying around.
set clipboard=unnamed "Clipboard sync os x
set viminfo='1000,f1,:1000,/1000 "Enable a nice big viminfo file
set history=500
set showcmd "Show us the command we're typing
set cursorline
autocmd InsertLeave * highlight CursorLine guibg=#004000 guifg=fg
set formatoptions-=ro
set visualbell t_vb= "No bell
set hidden "Allow edit buffers to be hidden
set winminheight=1 "1 height windows
set relativenumber "Line Numbers
set number

"Search
set incsearch
set ignorecase
set infercase
set hlsearch
set showmatch "Highlight matching parentes
set showfulltag "Show full tags when doing search completion
set rtp+=/usr/local/opt/fzf "Fuzzy search

"Text
set shiftwidth=2 "By default, go for an indent of 2
set expandtab "Make tab always spaces.
set tabstop=2
set softtabstop=2
set backspace=indent,eol,start "Make backspace delete lots of things
set autoindent "Do clever indent things. Don't make a # force column zero.
set smartindent
set whichwrap+=<,>,[,] "Wrap on these
set fillchars=vert:┃,diff:⎼,fold:⎼
set path+=Documents/ "Better include path handling
let &inc.=' ["<]'

"Statusline
set noshowmode "Hide default message when entering modes.
let g:airline_powerline_fonts=0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
set laststatus=2
set statusline=
set statusline+=%-3.3n\                      "Buffer number
set statusline+=%f\                          "File name
set statusline+=%=                           "Right align
set statusline+=%2*
setlocal numberwidth=3
set nomodeline "Disable modelines, use securemodelines.vim instead
let g:secure_modelines_verbose = 0
let g:secure_modelines_modelines = 15

"Keymapping
let mapleader = "," "Set leader key
inoremap <leader>, <Esc>
inoremap # X<BS>#
:nnoremap <leader>f :GFiles<cr>
:nnoremap <leader>F :Files<cr>
:nnoremap <leader>b :Buffers<cr>
:nnoremap <leader>g :Rg<cr>
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nnoremap <Tab> :bnext<cr>
nnoremap <Leader>pp :set paste!<CR>
nnoremap <S-Tab> :bprevious<cr>
nnoremap j gj
nnoremap k gk
nnoremap <CR> :nohlsearch<cr> 
noremap <silent> <c-k> :call smooth_scroll#up(&scroll, 5, 2)<CR>
noremap <silent> <c-j> :call smooth_scroll#down(&scroll, 5, 2)<CR>
cmap w!! w !sudo tee % >/dev/null
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>
nnoremap <Space> i_<Esc>r
au FileType go map <leader>r :!go run % 
