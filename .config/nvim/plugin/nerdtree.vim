let s:gui = {}

" SLATE
let s:gui.white      = { "default": "#41515C" }
let s:gui.grey       = { "default": "#8E9A9B" }
let s:gui.red        = { "default": "#AE5151" }
let s:gui.green      = { "default": "#779687" }
let s:gui.yellow     = { "default": "#B98675" }
let s:gui.orange     = { "default": "#B98675" }
let s:gui.blue       = { "default": "#5E828F" }
let s:gui.magenta    = { "default": "#B48291" }
let s:gui.cyan       = { "default": "#7AB1B3" }
let s:gui.none       = { "default": "NONE"    }

" SPLINTER
" let s:gui.white      = { "default": "#C1D5DA" }
" let s:gui.grey       = { "default": "#A8BCC1" }
" let s:gui.red        = { "default": "#855959" }
" let s:gui.green      = { "default": "#4C626A" }
" let s:gui.yellow     = { "default": "#81877B" }
" let s:gui.orange     = { "default": "#87807B" }
" let s:gui.blue       = { "default": "#3E5661" }
" let s:gui.magenta    = { "default": "#5E7A85" }
" let s:gui.cyan       = { "default": "#72949F" }
" let s:gui.none       = { "default": "NONE"    }

function! s:gui(color)
	if exists("g:nerdtree_theme_style")
		return a:color[s:style]
	else
		return a:color["default"]
	endif
endfunction

function! NERDTreeHighlightFile(extension, guifg, guibg)
	exec "autocmd filetype nerdtree syn match " . a:extension . ' #^\s\+.*' . a:extension . "$#"
	exec "autocmd filetype nerdtree highlight " . a:extension . " guibg=" . s:gui(a:guibg) . " guifg=" . s:gui(a:guifg)
endfunction

" NERDTREE FILE HIGHLIGHTING
call NERDTreeHighlightFile("ts",               s:gui.cyan,        s:gui.none)
call NERDTreeHighlightFile("tsx",              s:gui.cyan,        s:gui.none)
call NERDTreeHighlightFile("conf",             s:gui.cyan,        s:gui.none)
call NERDTreeHighlightFile("config",           s:gui.cyan,        s:gui.none)
call NERDTreeHighlightFile("yml",              s:gui.cyan,        s:gui.none)

call NERDTreeHighlightFile("js",               s:gui.yellow,      s:gui.none)
call NERDTreeHighlightFile("jsx",              s:gui.yellow,      s:gui.none)
call NERDTreeHighlightFile("json",             s:gui.orange,      s:gui.none)

call NERDTreeHighlightFile("css",              s:gui.green,       s:gui.none)
call NERDTreeHighlightFile("scss",             s:gui.green,       s:gui.none)
call NERDTreeHighlightFile("less",             s:gui.green,       s:gui.none)
call NERDTreeHighlightFile("html",             s:gui.green,       s:gui.none)
call NERDTreeHighlightFile("xml",              s:gui.green,       s:gui.none)
call NERDTreeHighlightFile("md",               s:gui.green,       s:gui.none)
call NERDTreeHighlightFile("vim",              s:gui.green,       s:gui.none)


call NERDTreeHighlightFile("dockerignore",     s:gui.grey,        s:gui.none)
call NERDTreeHighlightFile("gitignore",        s:gui.grey,        s:gui.none)
call NERDTreeHighlightFile("eslint",           s:gui.grey,        s:gui.none)
call NERDTreeHighlightFile("babelrc",          s:gui.grey,        s:gui.none)

call NERDTreeHighlightFile("sh",               s:gui.blue,        s:gui.none)
call NERDTreeHighlightFile("lua",              s:gui.blue,        s:gui.none)
call NERDTreeHighlightFile("php",              s:gui.blue,        s:gui.none)

call NERDTreeHighlightFile("jpg",              s:gui.white,       s:gui.none)
call NERDTreeHighlightFile("png",              s:gui.white,       s:gui.none)
call NERDTreeHighlightFile("svg",              s:gui.white,       s:gui.none)
