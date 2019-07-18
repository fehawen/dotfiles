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
		return printf("(%d)", l:counts.total)
	endif
endfunction

" }}}

" VIM MODES: " {{{
" https://kadekillary.work/post/statusline-vim/
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

" NERDTREE STATUSLINE: " {{{
" -------------------------------------------------------------------------

let NERDTreeStatusline="%8*%=%7*NERD%8*%="

" }}}

" VIM STATUSLINE: " {{{
" -------------------------------------------------------------------------

" Always show statusline
set laststatus=2

" Format active statusline
function! ActiveStatusLine()
	" Reset statusline
	let l:statusline=""
	" Spacer
	let l:statusline.="%8*%="
	" Set color based on mode
	if (mode() =~# '\v(n|no)')
		let l:statusline.="%2*"
	else
		let l:statusline.="%6*"
	endif
	" Mode
	let l:statusline.="%{ModeCurrent()}\ "
	" Filename
	let l:statusline.="%7*%t\ "
	" ALE lint errors, if any
	if LinterStatus() != ""
		let l:statusline.="%1*%{LinterStatus()}\ "
	endif
	" Current line number, total line numbers
	let l:statusline.="%5*%l/%L"
	" Show syntax identifier, if any
	if SyntaxItem() != ""
		let l:statusline.="\ %3*%{SyntaxItem()}"
	endif
	" Spacer
	let l:statusline.="%8*%="
	" Done
	return l:statusline
endfunction

" Format inactive statusline
function! InactiveStatusLine()
	" Reset statusline
	let l:statusline=""
	" Spacer
	let l:statusline.="%8*%="
	" Filename
	let l:statusline.="%7*%t"
	" Spacer
	let l:statusline.="%8*%="
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
	autocmd WinEnter * call SetActiveStatusLine()
	autocmd WinLeave * call SetInactiveStatusLine()
	autocmd BufEnter * call SetActiveStatusLine()
	autocmd BufLeave * call SetInactiveStatusLine()
augroup end

" }}}
