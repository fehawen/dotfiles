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

function! ActiveStatusLine()
" Clear statusline
setlocal statusline=

" Left 1 - mode
setlocal statusline+=%1*\ %{toupper(g:modes[mode()])}
setlocal statusline+=\ %3*%2*

" Left 2 - git branch
setlocal statusline+=%4*
setlocal statusline+=%1*\ %{StatuslineGit()}
setlocal statusline+=\ %3*%2*

" Left 3 - file name
setlocal statusline+=%4*
setlocal statusline+=%1*\ %t
setlocal statusline+=\ %3*%2*

" Spacing divider
setlocal statusline+=%=

" Right 1 - syntax group name
setlocal statusline+=%3*
setlocal statusline+=%1*\ %{SyntaxItem()}
setlocal statusline+=\ %4*%2*

" Right 2 - line number, total line
setlocal statusline+=%3*
setlocal statusline+=%1*\ %l
setlocal statusline+=\ /
setlocal statusline+=\ %L\ %*
return statusline
endfunction

function! InactiveStatusLine()
setlocal statusline=
setlocal statusline+=hello
return statusline
endfunction

" }}}
au WinEnter * call ActiveStatusLine()
au WinLeave * call InactiveStatusLine()
" au WinEnter * setlocal statusline=... OR call ActiveStatusLine()
" au WinLeave * setlocal statusline=...
" :setlocal statusline=... or let &l:statusline=... OR call InactiveStatusLine()
