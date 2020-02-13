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
		return printf("%d err", l:counts.total)
	endif
endfunction

" }}}

" READONLY FLAG CHECK: " {{{
" -------------------------------------------------------------------------

function! ReadOnly()
	if &readonly || !&modifiable
		return 'readonly'
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

let NERDTreeStatusline="%4*nerdtree%1*"

" }}}

" VIM STATUSLINE: " {{{
" -------------------------------------------------------------------------

" Always show statusline
set laststatus=2

" Format active statusline
function! ActiveStatusLine()
	" Reset statusline
	let l:statusline=""

	" Filename
	let l:statusline.="%7*%t"

	" Separator
	let l:statusline.="%1*\ \ "

	" Show if file is readonly
	if ReadOnly() != ""
		let l:statusline.="%4*%{ReadOnly()}"
		" Separator
		let l:statusline.="%1*\ \ "
	endif

	" Current column, line number, total line numbers
	let l:statusline.="%6*%c:%l/%L"

	" Separator
	let l:statusline.="%1*\ \ "

	" Show if file has been modified
	if Modified() != ""
		" Modified
		let l:statusline.="%5*%{Modified()}"
		" Separator
		let l:statusline.="%1*\ \ "
	endif

	" ALE lint errors, if any
	if LinterStatus() != ""
		" Lint errors
		let l:statusline.="%8*%{LinterStatus()}"
		" Separator
		let l:statusline.="%1*\ \ "
	endif

	" Show syntax identifier, if any
	if SyntaxItem() != ""
		" Syntax identifier
		let l:statusline.="%4*%{SyntaxItem()}"
	endif

	" Blank
	let l:statusline.="%1*"

	" Done
	return l:statusline
endfunction

" Format inactive statusline
function! InactiveStatusLine()
	" Reset statusline
	let l:statusline=""

	" Filename
	let l:statusline.="%8*%t"

	" Blank
	let l:statusline.="%1*"

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
