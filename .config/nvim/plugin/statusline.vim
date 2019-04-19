" GIT BRANCH: " {{{
" https://shapeshed.com/vim-statuslines/
" -------------------------------------------------------------------------

function! GitBranch()
	return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
	let l:branchname = GitBranch()
	return strlen(l:branchname) > 0? l:branchname : ""
endfunction

" }}}

" SYNTAX HIGHLIGHT GROUP: " {{{
" -------------------------------------------------------------------------

function! SyntaxItem()
	let l:syntaxname = synIDattr(synID(line("."),col("."),1),"name")

	if l:syntaxname != ""
		return l:syntaxname
	else
		return "none"
	endif
endfunction

" }}}

" VIM MODES: " {{{
" https://gabri.me/blog/diy-vim-statusline
" -------------------------------------------------------------------------

let g:modes={
\ 'n'      : 'Normal',
\ 'no'     : 'Operator Pending',
\ 'v'      : 'Visual',
\ 'V'      : 'Visual Line',
\ '\<C-V>' : 'Visual Block',
\ 's'      : 'Select',
\ 'S'      : 'S Line',
\ '\<C-S>' : 'S Block',
\ 'i'      : 'Insert',
\ 'R'      : 'Replace',
\ 'Rv'     : 'V Replace',
\ 'c'      : 'Command',
\ 'cv'     : 'Vim Ex',
\ 'ce'     : 'Ex',
\ 'r'      : 'Prompt',
\ 'rm'     : 'More',
\ 'r?'     : 'Confirm',
\ '!'      : 'Shell',
\ 't'      : 'Terminal'
\}

" }}}


" NERDTREE STATUSLINE: " {{{
" -------------------------------------------------------------------------

let NERDTreeStatusline="%2*%=%3*%1*\ NERD\ "

" }}}

" VIM STATUSLINE: " {{{
" -------------------------------------------------------------------------

" Show statusline
set laststatus=2

" Clear statusline
set statusline=

" Left 1 - mode
set statusline+=%1*\ %{toupper(g:modes[mode()])}
set statusline+=\ %3*%2*

" Left 2 - git branch
set statusline+=%4*
set statusline+=%1*\ %{StatuslineGit()}
set statusline+=\ %3*%2*

" Left 3 - file name
set statusline+=%4*
set statusline+=%1*\ %t
set statusline+=\ %3*%2*

" Spacing divider
set statusline+=%=

" Right 1 - syntax group name
set statusline+=%3*
set statusline+=%1*\ %{SyntaxItem()}
set statusline+=\ %4*%2*

" Right 2 - line number, total line
set statusline+=%3*
set statusline+=%1*\ %l
set statusline+=\ /
set statusline+=\ %L\ %*

" }}}
