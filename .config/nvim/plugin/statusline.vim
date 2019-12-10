" SYNTAX HIGHLIGHT GROUP: " {{{
" -------------------------------------------------------------------------

function! SyntaxItem()
	let l:syntaxname = synIDattr(synID(line("."),col("."),1),"name")

	if l:syntaxname != ""
		return l:syntaxname
	else
		return ""
	endif
endfunction

" }}}

" ALE LINTER STATUS: " {{{
" -------------------------------------------------------------------------

function! LinterStatus() abort
	let l:counts = ale#statusline#Count(bufnr(''))

	if l:counts.total == 0
		return ""
	else
		return printf("%d", l:counts.total)
	endif
endfunction

" }}}

" VIM MODES: " {{{
" -------------------------------------------------------------------------

let g:currentmode={
	\'n'  : 'Normal',
	\'no' : 'Normal/Op/Pend',
	\'v'  : 'Visual',
	\'V'  : 'Visual/Line',
	\'^V' : 'Visual/Block',
	\'s'  : 'Select',
	\'S'  : 'Select/Line',
	\'^S' : 'Select/Block',
	\'i'  : 'Insert',
	\'R'  : 'Replace',
	\'Rv' : 'Visual/Replace',
	\'c'  : 'Command',
	\'cv' : 'Vim Ex',
	\'ce' : 'Ex',
	\'r'  : 'Prompt',
	\'rm' : 'More',
	\'r?' : 'Confirm',
	\'!'  : 'Shell',
	\'t'  : 'Terminal'
\}

function! ModeCurrent() abort
	let l:modecurrent = mode()
	let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'Visual/Block'))
	let l:current_status_mode = l:modelist

	return l:current_status_mode
endfunction

" }}}

" READONLY FLAG CHECK: " {{{
" -------------------------------------------------------------------------

function! ReadOnly()
	if &readonly || !&modifiable
		return 'READONLY'
	else
		return ''
	endif
endfunction

" }}}

" MODIFIED FLAG CHECK: " {{{
" -------------------------------------------------------------------------

function! Modified()
	if &modified
		return 'modified'
	else
		return ''
	endif
endfunction

" }}}

" NERDTREE STATUSLINE: " {{{
" -------------------------------------------------------------------------

let NERDTreeStatusline="%4*\ NERDTree\ %1*"

" }}}

" VIM STATUSLINE: " {{{
" -------------------------------------------------------------------------

" Always show statusline
set laststatus=2

" Format active statusline
function! ActiveStatusLine()
	" Reset statusline
	let l:statusline=""
	" Color by mode
	if (mode() =~# '\v(n|no)')
		let l:statusline.="%5*"
	elseif (mode() =~# '\v(c|ce|cv)')
		let l:statusline.="%8*"
	else
		let l:statusline.="%3*"
	endif
	" Mode
	let l:statusline.="\ %{ModeCurrent()}\ "
	" Separator
	let l:statusline.="%1*\ "
	" Current line number, total line numbers
	let l:statusline.="%6*\ %l:%L\ "
	" Separator
	let l:statusline.="%1*\ "
	" ALE lint errors, if any
	if LinterStatus() != ""
		let l:statusline.="%2*\ %{LinterStatus()}\ "
		" Separator
		let l:statusline.="%1*\ "
	endif
	" Filename
	let l:statusline.="%7*\ %t\ "
	" Separator
	let l:statusline.="%1*\ "
	" Show if file is readonly
	if ReadOnly() != ""
		let l:statusline.="%4*\ %{ReadOnly()}\ "
		" Separator
		let l:statusline.="%1*\ "
	endif
	" Show if file has been modified
	if Modified() != ""
		let l:statusline.="%8*\ %{Modified()}\ "
		" Separator
		let l:statusline.="%1*\ "
	endif
	" Spacer
	let l:statusline.="%1*%="
	" Show syntax identifier, if any
	if SyntaxItem() != ""
		let l:statusline.="%4*\ %{SyntaxItem()}\ "
		" Separator
		let l:statusline.="%1*\ "
	endif
	" File encoding
	let l:statusline.="%7*\ %{(&fenc!=''?&fenc:&enc)}\ "
	" Separator
	let l:statusline.="%1*\ "
	" File format
	let l:statusline.="%5*\ %{&ff}\ "
	" Done
	return l:statusline
endfunction

" Format inactive statusline
function! InactiveStatusLine()
	" Reset statusline
	let l:statusline=""
	" Filename
	let l:statusline.="%8*\ %t\ "
	" Spacer
	let l:statusline.="%1*%="
	" File encoding
	let l:statusline.="%8*\ %{(&fenc!=''?&fenc:&enc)}\ "
	" Separator
	let l:statusline.="%1*\ "
	" File format
	let l:statusline.="%8*\ %{&ff}\ "
	" Done
	return l:statusline
endfunction

" Set active statusline
function! SetActiveStatusLine()
	if &ft ==? 'nerdtree'
		return
	endif

	setlocal statusline=
	setlocal statusline+=%!ActiveStatusLine()
endfunction

" Set inactive statusline
function! SetInactiveStatusLine()
	if &ft ==? 'nerdtree'
		return
	endif

	setlocal statusline=
	setlocal statusline+=%!InactiveStatusLine()
endfunction

" Autocmd statusline
augroup statusline
	autocmd!
	autocmd WinEnter,BufEnter * call SetActiveStatusLine()
	autocmd WinLeave,BufLeave * call SetInactiveStatusLine()
augroup end

" }}}
