" SYNTAX HIGHLIGHT GROUP: " {{{
" https://vim.fandom.com/wiki/Showing_syntax_highlight_group_in_statusline
" https://stackoverflow.com/questions/9464844/how-to-get-group-name-of-highlighting-under-cursor-in-vim
" -------------------------------------------------------------------------

function! SyntaxItem()
	let l:syntaxname = synIDattr(synID(line("."),col("."),1),"name")

	if l:syntaxname != ""
		return l:syntaxname
	else
		return "•••"
	endif
endfunction

" }}}

function! LinterStatus() abort
	let l:counts = ale#statusline#Count(bufnr(''))
	let l:all_errors = l:counts.error + l:counts.style_error
	let l:all_non_errors = l:counts.total - l:all_errors

	return l:counts.total == 0 ? "" : printf(
	\ " W:%d E:%d",
	\ l:all_non_errors,
	\ l:all_errors
	\)
endfunction

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
		" Left 2 - file name, linter warnings/errors (if any)
		setlocal statusline+=%4*
		setlocal statusline+=%1*\ %t
		setlocal statusline+=%{LinterStatus()}
		setlocal statusline+=\ %3*%2*
		" Spacing divider
		setlocal statusline+=%=
		" Middle - syntax group name
		setlocal statusline+=%3*
		setlocal statusline+=%4*\ %{SyntaxItem()}
		setlocal statusline+=\ %3*%2*
		" Spacing divider
		setlocal statusline+=%=
		" Right - line number, total lines
		setlocal statusline+=%3*
		setlocal statusline+=%1*\ %l
		setlocal statusline+=\ %4*
		setlocal statusline+=%3*
		setlocal statusline+=%1*\ %L\ %*
	endif
endfunction

" Set inactive statusline
function! SetInactiveStatusLine()
	if &ft !=? 'nerdtree'
		" Clear statusline
		setlocal statusline=
		" Left - file name
		setlocal statusline+=%4*\ %t
		setlocal statusline+=\ %3*%2*
		" Spacing divider
		setlocal statusline+=%=
		" Middle - syntax group name
		setlocal statusline+=%3*
		setlocal statusline+=%4*\ •••
		setlocal statusline+=\ %3*%2*
		" Spacing divider
		setlocal statusline+=%=
		" Right - total lines
		setlocal statusline+=%3*
		setlocal statusline+=%4*\ %L\ %*
	endif
endfunction

" Autocmd statusline
augroup statusline
	autocmd!
	autocmd BufEnter * call SetActiveStatusLine()
	autocmd BufLeave * call SetInactiveStatusLine()
augroup end

" }}}
