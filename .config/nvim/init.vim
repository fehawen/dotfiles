" Automatic vim-plug installation
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'

Plug 'mattn/emmet-vim'

Plug 'w0rp/ale'

" Plug 'mxw/vim-jsx'

" Plug 'pangloss/vim-javascript'

" Plug 'othree/yajs.vim'

" Plug 'HerringtonDarkholme/yats.vim'

Plug 'leafgarland/typescript-vim'

" Plug 'mhartington/nvim-typescript', {'do': './install.sh'}

Plug 'Shougo/deoplete.nvim'

Plug 'jiangmiao/auto-pairs'

Plug 'ekalinin/Dockerfile.vim'

" Initialize plugin system
call plug#end()

set termguicolors

" Enable filetype plugins
filetype plugin on
filetype indent on

" set noshowmode

" Set to auto read when a file is changed from the outside
set autoread

" Always show current position
set ruler

" Disable compatibility to old-time vi
set nocompatible

" Show matching brackets.
set showmatch
set mat=2

set magic

" Do case insensitive matching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

set incsearch

" Number of columns occupied by a tab character
set tabstop=2

" See multiple spaces as tabstops so <BS> does the right thing
set softtabstop=2

" Softtabstop == tabstop, noexpandtab && always force use of tabs
set noexpandtab

" Width for autoindents
set shiftwidth=2

" Indent a new line the same amount as the line just typed
set autoindent

" Add line numbers
set relativenumber number

" Get bash-like tab completions
set wildmode=longest,list

" Prevent cursor to jump around too much on scroll
set lazyredraw

set encoding=utf8

" Sets unix as standard filetype
set ffs=unix,dos,mac

" Wrap lines
set wrap

set nocursorcolumn
set nocursorline
set updatetime=300

set pumheight=10

set nobackup
set nowb
set noswapfile

" Increase max memory to show syntax highlighting for large files
set maxmempattern=20000

" Auto resize panes
autocmd VimResized * wincmd =

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Tab to complete
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Plugin configs
let g:deoplete#enable_at_startup = 1

set background=dark
colorscheme industrial

let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'

highlight clear SignColumn

let NERDTreeShowHidden=1

" Map nerdtreetoggle to ctrl-n
map <C-n> :NERDTreeToggle<CR>
