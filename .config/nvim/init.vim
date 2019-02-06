" if (has("termguicolors"))
"  set termguicolors
" endif

syntax enable
colorscheme desert

" disable compatibility to old-time vi
set nocompatible

" filetype recognition
filetype on

" enable filetype plugins and indent
filetype plugin on
filetype indent on

" show matching brackets.
set showmatch

" do case insensitive matching
set ignorecase

" highlight search results
set hlsearch

" number of columns occupied by a tab character
set tabstop=2

" see multiple spaces as tabstops so <BS> does the right thing
set softtabstop=2

" softtabstop == tabstop, noexpandtab && always force use of tabs
set noexpandtab

" width for autoindents
set shiftwidth=2

" indent a new line the same amount as the line just typed
set autoindent

" add line numbers
set relativenumber number

" get bash-like tab completions
set wildmode=longest,list

" prevent cursor to jump around too much on scroll
set lazyredraw

" change line number color
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE

" set an 80 column border for good coding style
" set cc=80

" Automatic vim-plug installation
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'mattn/emmet-vim'

Plug 'w0rp/ale'

Plug 'pangloss/vim-javascript'

Plug 'leafgarland/typescript-vim'

Plug 'mhartington/nvim-typescript', {'do': './install.sh'}

Plug 'Shougo/deoplete.nvim'

Plug 'jiangmiao/auto-pairs'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'itchyny/lightline.vim'

" Initialize plugin system
call plug#end()

" Plugin configs
let g:deoplete#enable_at_startup = 1
