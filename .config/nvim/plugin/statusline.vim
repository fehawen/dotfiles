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
	else
		return printf("%d", l:counts.total)
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

	if mode() == "n"
		let l:statusline="%1*"
  else
		let l:statusline="%2*"
	endif

	let l:statusline.="\ \ %{ModeCurrent()}\ %9*|"

	if LinterStatus() == ""
		let l:statusline.="%4*\ %t\ "
	else
		let l:statusline.="%3*\ %t\ "
		let l:statusline.="%4*%{LinterStatus()}\ errors\ "
	endif

	let l:statusline.="\ %8*"
	let l:statusline.="%="
	let l:statusline.="\ %8*"

	if SyntaxItem() != ""
		let l:statusline.="%1*\ \ %{SyntaxItem()}%9*\ |"
	else
		let l:statusline.="%9*\ "
	endif

	if LinePercent() < 25
		let l:statusline.="%1*\ %l\ %9*|\ "
		let l:statusline.="%1*%c\ %9*|\ "
		let l:statusline.="%1*%L\ %9*|\ "
		let l:statusline.="%1*%{LinePercent()}%%\ \ "
	elseif LinePercent() >= 25 && LinePercent() < 50
		let l:statusline.="%4*\ %l\ %9*|\ "
		let l:statusline.="%4*%c\ %9*|\ "
		let l:statusline.="%4*%L\ %9*|\ "
		let l:statusline.="%4*%{LinePercent()}%%\ \ "
	elseif LinePercent() >= 50 && LinePercent() <= 75
		let l:statusline.="%2*\ %l\ %9*|\ "
		let l:statusline.="%2*%c\ %9*|\ "
		let l:statusline.="%2*%L\ %9*|\ "
		let l:statusline.="%2*%{LinePercent()}%%\ \ "
	else
		let l:statusline.="%3*\ %l\ %9*|\ "
		let l:statusline.="%3*%c\ %9*|\ "
		let l:statusline.="%3*%L\ %9*|\ "
		let l:statusline.="%3*%{LinePercent()}%%\ \ "
	endif

	return l:statusline

endfunction

" Format inactive statusline
function! InactiveStatusLine()

	let l:statusline="%1*\ \ %t\ "
	let l:statusline.="\ %8*"

	let l:statusline.="%="

	let l:statusline.="%8*"
	let l:statusline.="%9*\ "
	let l:statusline.="%1*\ %l\ %9*|\ "
	let l:statusline.="%1*%c\ %9*|\ "
	let l:statusline.="%1*%L\ %9*|\ "
	let l:statusline.="%1*%{LinePercent()}%%\ \ "

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
