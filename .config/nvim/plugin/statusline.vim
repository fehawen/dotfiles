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
		return ""
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
	elseif l:counts.total == 1
		return printf("%d error", l:counts.total)
	else
		return printf("%d errors", l:counts.total)
	endif

endfunction

" VIM MODES: " {{{
" https://kadekillary.work/post/statusline-vim/
" -------------------------------------------------------------------------
let g:currentmode={
	\'n'  : 'Normal',
	\'no' : 'Normal Op Pend',
	\'v'  : 'Visual',
	\'V'  : 'Visual Line',
	\'^V' : 'Visual Block',
	\'s'  : 'Select',
	\'S'  : 'Select Line',
	\'^S' : 'Select Block',
	\'i'  : 'Insert',
	\'R'  : 'Replace',
	\'Rv' : 'Visual Replace',
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
	let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'Visual Block'))
	let l:current_status_mode = l:modelist

	return l:current_status_mode

endfunction

" }}}

" LINE PERCENTAGE: " {{{
" https://vi.stackexchange.com/questions/3894/get-percentage-through-file-of-displayed-window
" -------------------------------------------------------------------------

function! LinePercent()
	return line('.') * 100 / line('$')
endfunction

" }}}

" NERDTREE STATUSLINE: " {{{
" -------------------------------------------------------------------------

let NERDTreeStatusline="%8*%=%8*%1*\ \ NERD\ \ "

" }}}

" VIM STATUSLINE: " {{{
" -------------------------------------------------------------------------

" Always show statusline
set laststatus=2

" Format active statusline
function! ActiveStatusLine()

	if (mode() =~# '\v(n|no)')
		let l:statusline="%9*"
	elseif (mode() =~# '\v(i|v|V)' || ModeCurrent() ==# 'VISUAL BLOCK')
		let l:statusline="%2*"
	else
		let l:statusline="%4*"
	endif

	let l:statusline.="\ \ %{ModeCurrent()}\ %9*|"

	let l:statusline.="%4*\ %t\ "

	if LinterStatus() != ""
		let l:statusline.="%9*|\ %3*%{LinterStatus()}\ "
	endif

	let l:statusline.="\ %8*"

	let l:statusline.="%="
	let l:statusline.="\ %8*"

	if SyntaxItem() != ""
		let l:statusline.="%9*\ \ %1*hi%2*:"
		let l:statusline.="\ %4*%{SyntaxItem()}\ %9*|\ "
	else
		let l:statusline.="%9*\ "
	endif

	let l:statusline.="%1*col%2*:"
	let l:statusline.="\ %4*%c\ %9*|\ "
	let l:statusline.="%1*line%2*:"
	let l:statusline.="\ %4*%l%2*/%4*%L"
	let l:statusline.="\ %9*|\ "
	let l:statusline.="%1*perc%2*:"
	let l:statusline.="\ %4*%{LinePercent()}%%\ \ "

	return l:statusline

endfunction

" Format inactive statusline
function! InactiveStatusLine()

	let l:statusline="%1*\ \ %t\ "
	let l:statusline.="\ %8*"

	let l:statusline.="%="

	let l:statusline.="\ %8*%9*\ \ "
	let l:statusline.="%1*col%9*:"
	let l:statusline.="\ %1*%c\ %9*|\ "
	let l:statusline.="%1*line%9*:"
	let l:statusline.="\ %1*%l%9*/%1*%L"
	let l:statusline.="\ %9*|\ "
	let l:statusline.="%1*perc%9*:"
	let l:statusline.="\ %1*%{LinePercent()}%%\ \ "

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
	autocmd WinEnter * call SetActiveStatusLine()
	autocmd WinLeave * call SetInactiveStatusLine()
	autocmd BufEnter * call SetActiveStatusLine()
	autocmd BufLeave * call SetInactiveStatusLine()
augroup end

" }}}
