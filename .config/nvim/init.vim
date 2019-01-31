" Automatic installation
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" Ale  -  asynchronous lint engine
Plug 'w0rp/ale'

" Vim javascript - syntax highlighting
Plug 'pangloss/vim-javascript'

" Vim typescript - syntax highlighting
Plug 'leafgarland/typescript-vim'

" Nerdtree (on-demand loading)
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Lightline
Plug 'itchyny/lightline.vim'

" Initialize plugin system
call plug#end()

" Disable compatibility to old-time vi
set nocompatible

" Show matching brackets.
set showmatch

" Do case insensitive matching
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

set lazyredraw

" set an 80 column border for good coding style
" set cc=80

" color scheme
" colorscheme vimbrant
