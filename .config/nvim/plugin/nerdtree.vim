let s:gui = {}

let s:gui.white      = { 'default': '#C9CFDA' }
let s:gui.grey       = { "default": "#8A909A" }
let s:gui.red        = { "default": "#AA7B7B" }
let s:gui.green      = { "default": "#8CAA7B" }
let s:gui.yellow     = { "default": "#AA9F7B" }
let s:gui.orange     = { "default": "#AA897A" }
let s:gui.blue       = { "default": "#7B93AA" }
let s:gui.magenta    = { "default": "#AA7B98" }
let s:gui.cyan       = { "default": "#7BA6AA" }
let s:gui.none       = { 'default': 'NONE' }

function! s:gui(color)
	if exists("g:slate_style")
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
