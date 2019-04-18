" FILE SIZE: "{{{
" https://hackernoon.com/the-last-statusline-for-vim-a613048959b2
" -------------------------------------------------------------------------

function! FileSize() abort
	let l:bytes = getfsize(expand("%p"))
	let l:prefix = " | "

	if (l:bytes >= 1024)
		let l:kbytes = l:bytes / 1025
	endif

	if (exists("kbytes") && l:kbytes >= 1000)
		let l:mbytes = l:kbytes / 1000
	endif

	if l:bytes <= 0
		return ""
	endif

	if (exists("mbytes"))
		return l:prefix . l:mbytes . "MB"
	elseif (exists("kbytes"))
		return l:prefix . l:kbytes . "KB"
	else
		return l:prefix . l:bytes . "B"
	endif
endfunction

" }}}

" SYNTAX HIGHLIGHT GROUP: "{{{
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

" NERDTREE STATUSLINE: "{{{
" -------------------------------------------------------------------------

let NERDTreeStatusline="%2*%=%3*%1*\ NERD\ "

" }}}

" VIM MODES: "{{{
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

" VIM STATUSLINE: "{{{
" -------------------------------------------------------------------------

" Show statusline
set laststatus=2

" Clear statusline
set statusline=

" Left 1 - file name, file size
set statusline+=%1*\ %t
set statusline+=%{FileSize()}
set statusline+=\ %3*%2*

" Left 2 - syntax group name
set statusline+=%4*
set statusline+=%1*\ %{toupper(g:modes[mode()])}
set statusline+=\ %3*%2*

" Spacing divider
set statusline+=%=

" Right 1 - syntax name (for theme highlighting)
set statusline+=%3*
set statusline+=%1*\ %{SyntaxItem()}
set statusline+=\ %4*%2*

" Right 2 - line number, total line
set statusline+=%3*
set statusline+=%1*\ %l
set statusline+=\ /
set statusline+=\ %L\ %*

" }}}
