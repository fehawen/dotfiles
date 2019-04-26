highlight clear

if exists("syntax_on")
	syntax reset
endif

let g:colors_name = "oceanone"

let s:gui = {}
let s:cterm = {}

let s:gui.background = { 'default': '#263238' }
let s:gui.foreground = { 'default': '#B0BEC5' }
let s:gui.none       = { 'default': 'NONE',   }
let s:gui.selection  = { 'default': '#546E7A' }
let s:gui.line       = { 'default': '#37474F' }
let s:gui.comment    = { 'default': '#0E1014' }

let s:gui.black      = { 'default': '#0E1014' }
let s:gui.red        = { 'default': '#AF4C48' }
let s:gui.green      = { 'default': '#979E8C' }
let s:gui.yellow     = { 'default': '#BB987C' }
let s:gui.blue       = { 'default': '#718C9A' }
let s:gui.orange     = { 'default': '#CF745A' }
let s:gui.magenta    = { 'default': '#9183A4' }
let s:gui.cyan       = { 'default': '#90B2C7' }

function! s:hi(group, guifg, guibg, attr)
	if s:gui(a:guifg) != ""
		exec "hi " . a:group . " guifg=" . s:gui(a:guifg)
	endif
	if s:gui(a:guibg) != ""
		exec "hi " . a:group . " guibg=" . s:gui(a:guibg)
	endif

	if a:attr != ""
		exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
	endif
endfunction

function! s:gui(color)
	return a:color['default']
endfunction

" Neovim Terminal colors
if has("nvim")
	let g:terminal_color_0          = s:gui(s:gui.black)
	let g:terminal_color_8          = s:gui(s:gui.black)
	let g:terminal_color_1          = s:gui(s:gui.red)
	let g:terminal_color_9          = s:gui(s:gui.red)
	let g:terminal_color_2          = s:gui(s:gui.green)
	let g:terminal_color_10         = s:gui(s:gui.green)
	let g:terminal_color_3          = s:gui(s:gui.yellow)
	let g:terminal_color_11         = s:gui(s:gui.yellow)
	let g:terminal_color_4          = s:gui(s:gui.blue)
	let g:terminal_color_12         = s:gui(s:gui.blue)
	let g:terminal_color_5          = s:gui(s:gui.magenta)
	let g:terminal_color_13         = s:gui(s:gui.magenta)
	let g:terminal_color_6          = s:gui(s:gui.cyan)
	let g:terminal_color_14         = s:gui(s:gui.cyan)
	let g:terminal_color_7          = s:gui(s:gui.foreground)
	let g:terminal_color_15         = s:gui(s:gui.foreground)
	let g:terminal_color_background = s:gui(s:gui.background)
	let g:terminal_color_foreground = s:gui(s:gui.foreground)
endif

" "EDITOR COLORS
call s:hi("User1",        s:gui.blue,       s:gui.line,       "bold")
call s:hi("User2",        s:gui.background, s:gui.background, "bold")
call s:hi("User3",        s:gui.line,       s:gui.background, "bold")
call s:hi("User4",        s:gui.background, s:gui.line,       "bold")

call s:hi("StatusLine",       s:gui.line,   s:gui.foreground, "")
call s:hi("StatusLineNC",     s:gui.line,   s:gui.background, "")
call s:hi("StatusLineTerm",   s:gui.line,   s:gui.foreground, "")
call s:hi("StatusLineTemrNC", s:gui.line,   s:gui.background, "")

call s:hi("NERDTreeOpenable",   s:gui.selection,  s:gui.none,     "")
call s:hi("NERDTreeClosable",   s:gui.selection,  s:gui.none,     "")
call s:hi("NERDTreeCWD",        s:gui.selection,  s:gui.none,     "")
call s:hi("NERDTreeDir",        s:gui.blue,       s:gui.none,     "")
call s:hi("NERDTreeDirSlash",   s:gui.background, s:gui.none,     "")
call s:hi("NERDTreeFile",       s:gui.foreground, s:gui.none,     "")

call s:hi("EndOfBuffer",  s:gui.background, s:gui.none,       "")
call s:hi("ColorColumn",  s:gui.none,       s:gui.line,       "")
call s:hi("Cursor",       s:gui.magenta,    "",               "")
call s:hi("CursorColumn", s:gui.none,       s:gui.line,       "")
call s:hi("LineNr",       s:gui.line,       "",               "")
call s:hi("CursorLine",   s:gui.none,       s:gui.none,       "")
call s:hi("CursorLineNr", s:gui.magenta,    s:gui.line,       "")
call s:hi("Directory",    s:gui.line,       "",               "")
call s:hi("FoldColumn",   "",               s:gui.none,       "")
call s:hi("Folded",       s:gui.comment,    s:gui.line,       "")
call s:hi("PMenu",        s:gui.foreground, s:gui.line,       "")
call s:hi("PMenuSel",     s:gui.cyan,       s:gui.none,       "")
call s:hi("ErrorMsg",     s:gui.red,        s:gui.none,       "")
call s:hi("Error",        s:gui.red,        s:gui.none,       "")
call s:hi("WarningMsg",   s:gui.yellow,     "",               "")
call s:hi("VertSplit",    s:gui.line,       s:gui.line,       "")
call s:hi("Conceal",      s:gui.comment,    s:gui.none,       "")

call s:hi("DiffAdded",    s:gui.green,      "", "")
call s:hi("DiffRemoved",  s:gui.red,        "", "")

call s:hi("DiffAdd",      "",               s:gui.cyan,       "")
call s:hi("DiffChange",   "",               s:gui.cyan,       "")
call s:hi("DiffDelete",   s:gui.red,        s:gui.black,      "")
call s:hi("DiffText",     s:gui.background, s:gui.selection,  "")

call s:hi("NonText",      s:gui.line,       "",               "")
call s:hi("helpExample",  s:gui.blue,       "",               "")
call s:hi("MatchParen",   s:gui.background, s:gui.selection,  "")
call s:hi("Title",        s:gui.cyan,       "",               "")
call s:hi("Comment",      s:gui.comment,    "",               "")
call s:hi("String",       s:gui.green,      "",               "")
call s:hi("Events",       s:gui.red,        "",               "")
call s:hi("Normal",       s:gui.foreground, s:gui.none,       "")
call s:hi("Visual",       s:gui.background, s:gui.selection,  "")
call s:hi("Constant",     s:gui.blue,       "",               "")
call s:hi("Boolean",      s:gui.orange,     "",               "")
call s:hi("Type",         s:gui.blue,       "",               "")
call s:hi("Define",       s:gui.cyan,       "",               "")
call s:hi("Statement",    s:gui.blue,       "",               "")
call s:hi("Function",     s:gui.magenta,     "",               "")
call s:hi("Conditional",  s:gui.red,        "",               "")
call s:hi("Float",        s:gui.green,      "",               "")
call s:hi("Noise",        s:gui.cyan,       "",               "")
call s:hi("Number",       s:gui.green,      "",               "")
call s:hi("Identifier",   s:gui.blue,       "",               "")
call s:hi("Operator",     s:gui.cyan,       "",               "")
call s:hi("PreProc",      s:gui.blue,       "",               "")
call s:hi("Search",       s:gui.blue,       s:gui.selection,  "")
call s:hi("InSearch",     s:gui.black,      s:gui.foreground, "")
call s:hi("Todo",         s:gui.comment,    "",               "")
call s:hi("Special",      s:gui.magenta,    "",               "") " @observable etc...

" ALE COLORS
call s:hi("AleText",      s:gui.red,        s:gui.line, "")
call s:hi("AleWarning",   s:gui.red,        s:gui.line, "")
call s:hi("AleLine",      "",               s:gui.none, "")

hi link ALEErrorSign    AleText
hi link ALEWarningSign  AleText
hi link ALEErrorLine    AleLine
hi link ALEInfoLine     AleLine

" TYPESCRIPT COLORS: " {{{
" leafgarland/typescript-vim

call s:hi("typescriptComment",                   s:gui.comment,     "", "")
call s:hi("typescriptCommentSkip",               s:gui.comment,     "", "")
call s:hi("typescriptCommentTodo",               s:gui.comment,     "", "")
call s:hi("typescriptLineComment",               s:gui.comment,     "", "")
call s:hi("typescriptRefComment",                s:gui.comment,     "", "")
call s:hi("typescriptRefD",                      s:gui.comment,     "", "")
call s:hi("typescriptRefS",                      s:gui.comment,     "", "")

call s:hi("typescriptDocComment",                s:gui.comment,     "", "")
call s:hi("typescriptDocTags",                   s:gui.comment,     "", "")
call s:hi("typescriptDocParam",                  s:gui.comment,     "", "")
call s:hi("typescriptDocSeeTag",                 s:gui.comment,     "", "")

call s:hi("typescriptSpecial",                   s:gui.cyan,        "", "")
call s:hi("typescriptStringD",                   s:gui.green,       "", "")
call s:hi("typescriptStringS",                   s:gui.green,       "", "")
call s:hi("typescriptStringB",                   s:gui.green,       "", "")
call s:hi("typescriptInterpolation",             s:gui.green,       "", "")
call s:hi("typescriptNumber",                    s:gui.orange,      "", "")
call s:hi("typescriptRegexpString",              s:gui.cyan,        "", "")
call s:hi("typescriptPrototype",                 s:gui.red,         "", "")
call s:hi("typescriptBrowserObjects",            s:gui.red,         "", "")
call s:hi("typescriptDOMObjects",                s:gui.blue,        "", "")
call s:hi("typescriptDOMMethods",                s:gui.yellow,      "", "")
call s:hi("typescriptDOMProperties",             s:gui.yellow,      "", "")
call s:hi("typescriptHtmlElemProperties",        s:gui.cyan,        "", "")
call s:hi("typescriptEventListenerKeywords",     s:gui.cyan,        "", "")
call s:hi("typescriptEventListenerMethods",      s:gui.cyan,        "", "")

call s:hi("typescriptSource",                    s:gui.red,         "", "") " import export from as
call s:hi("typescriptIdentifier",                s:gui.red,         "", "") " arguments this void
call s:hi("typescriptStorageClass",              s:gui.magenta,     "", "") " let var const
call s:hi("typescriptOperator",                  s:gui.magenta,     "", "") " delete new instanceof typeof
call s:hi("typescriptBoolean",                   s:gui.orange,      "", "") " true false
call s:hi("typescriptNull",                      s:gui.orange,      "", "") " null undefined
call s:hi("typescriptMessage",                   s:gui.green,       "", "") " alert confirm prompt status

call s:hi("typescriptConditional",               s:gui.cyan,        "", "") " if else switch
call s:hi("typescriptRepeat",                    s:gui.green,       "", "") " do while for in of
call s:hi("typescriptBranch",                    s:gui.cyan,        "", "") " break continue yield await
call s:hi("typescriptLabel",                     s:gui.cyan,        "", "") " case default async readonly
call s:hi("typescriptDecorators",                s:gui.selection,   "", "") " @action @computed, etc
call s:hi("typescriptStatement",                 s:gui.cyan,        "", "") " return with

call s:hi("typescriptGlobalObjects",             s:gui.blue,        "", "") " Array Boolean Date Function Infinity Math Number NaN Object Packages RegExp String Symbol
call s:hi("typescriptExceptions",                s:gui.green,       "", "") " try catch throw finally Error EvalError RangeError ReferenceError SyntaxError TypeError URIError
call s:hi("typescriptReserved",                  s:gui.blue,        "", "") " constructor as interface module enum int export interface static extends super class private implements import public type from get set keyof...
call s:hi("typescriptVars",                      s:gui.green,       "", "")
call s:hi("typescriptParameters",                s:gui.green,       "", "")
call s:hi("typescriptType",                      s:gui.yellow,      "", "") " void any string boolean number symbol never object

call s:hi("typescriptDomErrNo",                  s:gui.red,         "", "")
call s:hi("typescriptDomNodeConsts",             s:gui.red,         "", "")

call s:hi("typescriptHtmlEvents",                s:gui.blue,        "", "") " onblur onclick onfocus onkeydown onkeypress onkeyup ...

call s:hi("typescriptCssStyles",                 s:gui.red,         "", "") " not sure where these ever occur... ?

call s:hi("typescriptFuncKeyword",               s:gui.magenta,     "", "")
call s:hi("typescriptFunction",                  s:gui.blue,        "", "")

call s:hi("typescriptBraces",                    s:gui.yellow,      "", "")
call s:hi("typescriptParens",                    s:gui.magenta,     "", "")
call s:hi("typescriptOpSymbols",                 s:gui.cyan,        "", "")
call s:hi("typescriptEndColons",                 s:gui.cyan,        "", "")
call s:hi("typescriptLogicSymbols",              s:gui.magenta,     "", "")
call s:hi("typescriptDotNotation",               s:gui.cyan,        "", "")

" }}}

" Javascript colors

" vim-javascript
" call s:hi("jsArrowFuncArgs",   s:gui.green,      "", "")
" call s:hi("jsArrowFunction",   s:gui.magenta,    "", "")
" call s:hi("jsBooleanFalse",    s:gui.green,      "", "")
" call s:hi("jsBooleanTrue",     s:gui.green,      "", "")
" call s:hi("jsClassBraces",     s:gui.cyan,       "", "")
" call s:hi("jsClassDefinition", s:gui.yellow,     "", "")
" call s:hi("jsClassKeyword",    s:gui.red,        "", "")
" call s:hi("jsConditional",     s:gui.cyan,       "", "")
" call s:hi("jsFuncArgs",        s:gui.green,      "", "")
" call s:hi("jsFuncBraces",      s:gui.magenta,    "", "")
" call s:hi("jsFuncCall",        s:gui.cyan,       "", "")
" call s:hi("jsFuncParens",      s:gui.magenta,    "", "")
" call s:hi("jsFunction",        s:gui.blue,       "", "")
" call s:hi("jsFunctionKey",     s:gui.magenta,    "", "")
" call s:hi("jsGlobalObjects",   s:gui.yellow,     "", "")
" call s:hi("jsNoise",           s:gui.magenta,    "", "")
" call s:hi("jsObjectKey",       s:gui.foreground, "", "")
" call s:hi("jsOperator",        s:gui.magenta,    "", "")
" call s:hi("jsParens",          s:gui.magenta,    "", "")
" call s:hi("jsReturn",          s:gui.green,      "", "")
" call s:hi("jsStorageClass",    s:gui.blue,       "", "")
" call s:hi("jsThis",            s:gui.blue,       "", "")

" HTML colors
call s:hi("htmlTag",            s:gui.cyan,    "", "")
call s:hi("htmlEndTag",         s:gui.cyan,    "", "")
call s:hi("htmlTagName",        s:gui.magenta, "", "")
call s:hi("htmlSpecialTagName", s:gui.red,     "", "")
call s:hi("htmlArg",            s:gui.yellow,  "", "")

" JSX colors
call s:hi("tsxTag",             s:gui.yellow,    "", "")
call s:hi("tsxTagName",         s:gui.yellow,    "", "")
call s:hi("tsxCloseString",     s:gui.yellow,    "", "")
call s:hi("tsxCloseTag",        s:gui.cyan,      "", "")
call s:hi("tsxAttrib",          s:gui.magenta,   "", "")
call s:hi("tsxEqual",           s:gui.magenta,   "", "")
call s:hi("tsxIfOperator",      s:gui.magenta,   "", "")
call s:hi("tsxAttributeBraces", s:gui.yellow,    "", "")
call s:hi("tsxElseOperator",    s:gui.cyan,      "", "")

call s:hi("xmlTag",     s:gui.cyan,    "", "")
call s:hi("xmlEndTag",  s:gui.cyan,    "", "")
call s:hi("xmlTagName", s:gui.magenta, "", "")
call s:hi("xmlAttrib",  s:gui.yellow,  "", "")
