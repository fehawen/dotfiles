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

" Always show statusline
set laststatus=2

" Set active statusline
function! SetActiveStatusLine()
	if &ft !=? 'nerdtree'
		" Clear statusline
		setlocal statusline=
		" Left 1 - mode
		setlocal statusline+=%1*\ %{toupper(g:modes[mode()])}
		setlocal statusline+=\ %3*%2*
		" Left 2 - file name
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
	endif
endfunction

" Set inactive statusline
function! SetInactiveStatusLine()
	if &ft !=? 'nerdtree'
		" Clear statusline
		setlocal statusline=
		" Left 1 - file name
		setlocal statusline+=%4*\ %t
		setlocal statusline+=\ %3*%2*
		" Spacing divider
		setlocal statusline+=%=
		" Right 1 - line number, total line
		setlocal statusline+=%3*
		setlocal statusline+=%4*\ %l
		setlocal statusline+=\ /
		setlocal statusline+=\ %L\ %*
	endif
endfunction

" Autocmd statusline
augroup statusline
	autocmd!
	autocmd BufEnter * call SetActiveStatusLine()
	autocmd BufLeave * call SetInactiveStatusLine()
augroup end

" }}}
