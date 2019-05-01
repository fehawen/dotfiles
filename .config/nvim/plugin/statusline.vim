" SYNTAX HIGHLIGHT GROUP: " {{{
" https://vim.fandom.com/wiki/Showing_syntax_highlight_group_in_statusline
" https://stackoverflow.com/questions/9464844/how-to-get-group-name-of-highlighting-under-cursor-in-vim
" https://www.reddit.com/r/vim/comments/e19bu/whats_your_status_line/
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

" ALE LINTER STATUS: " {{{
" https://github.com/w0rp/ale#5v-how-can-i-show-errors-or-warnings-in-my-statusline
" -------------------------------------------------------------------------

function! LinterStatus() abort
	let l:counts = ale#statusline#Count(bufnr(''))

	if l:counts.total == 0
		return ""
	else
		return printf(" (%d)", l:counts.total)
	endif
endfunction

" VIM MODES: " {{{
" https://kadekillary.work/post/statusline-vim/
" -------------------------------------------------------------------------
let g:currentmode={
	\'n' : 'Normal',
	\'no' : 'Normal Op Pend',
	\'v' : 'Visual',
	\'V' : 'Visual Line',
	\'^V' : 'Visual Block',
	\'s' : 'Select',
	\'S': 'Select Line',
	\'^S' : 'Select Block',
	\'i' : 'Insert',
	\'R' : 'Replace',
	\'Rv' : 'Visual Replace',
	\'c' : 'Command',
	\'cv' : 'Vim Ex',
	\'ce' : 'Ex',
	\'r' : 'Prompt',
	\'rm' : 'More',
	\'r?' : 'Confirm',
	\'!' : 'Shell',
	\'t' : 'Terminal'
\}

function! ModeCurrent() abort
	let l:modecurrent = mode()
	let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'Visual Block'))
	let l:current_status_mode = l:modelist
	return l:current_status_mode
endfunction

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
		setlocal statusline+=%1*\ %{ModeCurrent()}
		setlocal statusline+=\ %3*%2*
		" Left 2 - file name, linter warnings/errors (if any)
		setlocal statusline+=%4*
		setlocal statusline+=%1*\ %t
		setlocal statusline+=%5*%{LinterStatus()}
		setlocal statusline+=\ %3*
		" Spacing divider
		setlocal statusline+=%=
		" Middle - syntax group name
		setlocal statusline+=%3*
		setlocal statusline+=%1*\ %{SyntaxItem()}
		setlocal statusline+=\ %3*
		" Spacing divider
		setlocal statusline+=%=
		" Right - line number, total lines
		setlocal statusline+=%3*
		setlocal statusline+=%1*\ %l\ %4*/\ %1*%L\ %*
	endif
endfunction

" Set inactive statusline
function! SetInactiveStatusLine()
	if &ft !=? 'nerdtree'
		" Clear statusline
		setlocal statusline=
		" Left - file name
		setlocal statusline+=%6*\ %t
		setlocal statusline+=\ %3*
		" Spacing divider
		setlocal statusline+=%=
		" Middle - syntax group name
		setlocal statusline+=%3*
		setlocal statusline+=%6*\ •••
		setlocal statusline+=\ %3*
		" Spacing divider
		setlocal statusline+=%=
		" Right - total lines
		setlocal statusline+=%3*
		setlocal statusline+=%6*\ %l\ %4*/\ %6*%L\ %*
	endif
endfunction

" Autocmd statusline
augroup statusline
	autocmd!
	autocmd BufEnter * call SetActiveStatusLine()
	autocmd BufLeave * call SetInactiveStatusLine()
augroup end

" }}}
