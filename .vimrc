if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

call plug#begin('~/.vim/plugged')

Plug 'dense-analysis/ale'
Plug 'scrooloose/nerdtree'
Plug 'fehawen/sc.vim'
Plug 'fehawen/sl.vim'

call plug#end()

syntax on
filetype on
filetype plugin on
filetype indent on

colorscheme sc

scriptencoding utf-8
set encoding=utf-8

set title
set noshowmode
set autoread
set ruler
set showmatch
set mat=2
set magic
set signcolumn=no
set hlsearch
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent
set nonumber
set lazyredraw
set cursorline
set nocursorcolumn
set ffs=unix,dos,mac
set wrap
set pumheight=10
set nobackup
set nowritebackup
set noswapfile
set maxmempattern=20000
set completeopt-=preview
set omnifunc=syntaxcomplete#Complete

set path+=**
set wildmenu
set wildignore+=**/node_modules/**
set wildignore+=**/.git/**

set list
set listchars=
set listchars+=tab:│\ ,
set listchars+=trail:•,
set fillchars+=vert:\ ,

let g:ale_sign_info = "•"
let g:ale_sign_error = "•"
let g:ale_sign_warning = "•"
let g:ale_sign_style_error = "•"
let g:ale_sign_style_warning = "•"
let g:ale_completion_enabled = 1

let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowLineNumbers = 0
let g:NERDTreeCascadeSingleChildDir = 0
let g:NERDTreeNodeDelimiter = "\u00a0"
let g:NERDTreeDirArrowExpandable = "•"
let g:NERDTreeDirArrowCollapsible = "•"
let g:NERDTreeWinSize = 31

au VimResized * wincmd=
au BufWritePre * %s/\s\+$//e
au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
au WinEnter,BufEnter * call matchadd('ColorColumn', '\%81v', 100)
au WinLeave,BufLeave * call clearmatches()
au FileType c,cpp setlocal noexpandtab softtabstop=8 shiftwidth=8

inoremap <expr><S-TAB> pumvisible() ? "\<Esc>" : "\<C-n>"
map <C-n> :NERDTreeToggle<CR>
map <C-f> :find<Space>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-h> :ALEHover<CR>
nmap <silent> <C-d> :ALEGoToDefinition<CR>
map <Tab> :noh<CR>
tnoremap <Esc> <C-\><C-n>
