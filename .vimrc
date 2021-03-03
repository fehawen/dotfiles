"
"     ██▒   █▓ ██▓ ███▄ ▄███▓ ██▀███   ▄████▄
"    ▓██░   █▒▓██▒▓██▒▀█▀ ██▒▓██ ▒ ██▒▒██▀ ▀█
"     ▓██  █▒░▒██▒▓██    ▓██░▓██ ░▄█ ▒▒▓█    ▄
"      ▒██ █░░░██░▒██    ▒██ ▒██▀▀█▄  ▒▓▓▄ ▄██▒
"       ▒▀█░  ░██░▒██▒   ░██▒░██▓ ▒██▒▒ ▓███▀ ░
"       ░ ▐░  ░▓  ░ ▒░   ░  ░░ ▒▓ ░▒▓░░ ░▒ ▒  ░
"       ░ ░░   ▒ ░░  ░      ░  ░▒ ░ ▒░  ░  ▒
"         ░░   ▒ ░░      ░     ░░   ░ ░
"          ░   ░         ░      ░     ░ ░
"         ░                           ░

"#####################"
"###### PLUGINS ######"
"#####################"

" Automatic vim-plug installation
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'dense-analysis/ale'
Plug 'scrooloose/nerdtree'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'fehawen/cs.vim'
Plug 'fehawen/sl.vim'

" Initialize plugin system
call plug#end()

"#############################"
"###### GENERAL CONFIGS ######"
"#############################"

" Enable syntax and plugins
syntax enable
filetype on
filetype plugin on
filetype indent on

" Enable omni completion
set omnifunc=syntaxcomplete#Complete

" Set encoding
scriptencoding utf-8
set encoding=utf-8

" Hide mode (shown in status line)
set noshowmode

" When a file has been changed outside of Vim, automatically read it again
set autoread

" Always show current position
set ruler

" When a bracket is inserted, briefly jump to the matching one
set showmatch

" Tenths of a second to show the matching paren
set mat=2

" Switching this option off most likely breaks plugins, someone told me...
set magic

" Don't show signcolumn
set signcolumn=no

" Highlight search results
set hlsearch

" Number of columns occupied by a tab character
set tabstop=4

" See multiple spaces as tabstops so <BS> does the right thing
set softtabstop=4

" Spaces = expandtab, Tabs = noexpandtab
set expandtab

" Width for autoindents
set shiftwidth=4

" Indent a new line the same amount as the line just typed
set autoindent

" Disable line number
set nonumber

" Prevent cursor to jump around too much on scroll
set lazyredraw

" Enable cursor line and disable cursor column
set cursorline
set nocursorcolumn

" Sets unix as standard filetype
set ffs=unix,dos,mac

" Wrap lines
set wrap

" Maximum items in completion suggest popup menu
set pumheight=10

" Don't make any backups before overwriting a file
set nobackup
set nowritebackup

" Don't use a swapfile for the buffer
set noswapfile

" Increase max memory to show syntax highlighting for large files
set maxmempattern=20000

" Don't show preview [sratch] window
set completeopt-=preview

" Update term title
set title

"###########################"
"###### FINDING FILES ######"
"###########################"

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" Exclude dirs when using e.g. :find
set wildignore+=**/node_modules/**
set wildignore+=**/.git/**

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer

"#########################"
"###### TAG JUMPING ######"
"#########################"

" Create the `tags` file (may need to install ctags first)
" command! MakeTags !ctags .

" set tags=./tags,tags

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags

"############################"
"###### AUTOCMDS, ETC #######"
"############################"

" Auto resize panes
autocmd VimResized * wincmd =

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Open NERDTree if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Highlight 81st column if line is at column 80 or higher,
" which allows us to avoid having the colorcolumn always
" present with e.g. colorcolumn=80
autocmd WinEnter,BufEnter * call matchadd('ColorColumn', '\%81v', 100)
autocmd WinLeave,BufLeave * call clearmatches()

"#####################################"
"###### THEME & PLUGIN SETTINGS ######"
"#####################################"

" Set theme
colorscheme cs

" Set list characters
set list
set listchars=
set listchars+=tab:›\ ,
set listchars+=trail:•,

" Set end of buffer and vertsplit to empty
set fillchars+=vert:\ ,

" Enable deoplete on startup (async completion framework)
let g:deoplete#enable_at_startup = 1

" ALE settings
let g:ale_sign_info= "•"
let g:ale_sign_error = "•"
let g:ale_sign_warning = "•"
let g:ale_sign_style_error = "•"
let g:ale_sign_style_warning = "•"

" NERDTree settings
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowLineNumbers = 0
let g:NERDTreeCascadeSingleChildDir = 0
let g:NERDTreeDirArrowExpandable = "•"
let g:NERDTreeDirArrowCollapsible = "•"
let g:NERDTreeWinSize = 31

"#########################"
"###### KEYBINDINGS ######"
"#########################"

" Toggle completion menu with Shift-Tab in insert mode
inoremap <expr><S-TAB> pumvisible() ? "\<Esc>" : "\<C-n>"

" Map nerdtreetoggle to Ctrl-n
map <C-n> :NERDTreeToggle<CR>

" Map Ctrl-Space to :find
map <C-f> :find<Space>

" Navigate between ALE errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-h> :ALEHover<CR>
nmap <silent> <C-d> :ALEGoToDefinition<CR>

" Map Tab in normal mode to clear search highlight
map <Tab> :noh<CR>

" Map Esc to exit Terminal
tnoremap <Esc> <C-\><C-n>
