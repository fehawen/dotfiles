highlight clear

if exists("syntax_on")
	syntax reset
endif

let g:colors_name = "industrial"

let s:gui = {}
let s:cterm = {}

let s:gui.background = { 'default': '#263238' }
let s:gui.foreground = { 'default': '#CFD8DC' }
let s:gui.none       = { 'default': 'NONE',   }
let s:gui.selection  = { 'default': '#546E7A' }
let s:gui.line       = { 'default': '#37474F' }
let s:gui.comment    = { 'default': '#0E1014' }

let s:gui.black      = { 'default': '#0E1014' }
let s:gui.red        = { 'default': '#455A64' }
let s:gui.yellow     = { 'default': '#607D8B' }
let s:gui.green      = { 'default': '#78909C' }
let s:gui.cyan       = { 'default': '#90A4AE' }
let s:gui.blue       = { 'default': '#546E7A' }
let s:gui.accent     = { 'default': '#F4511E' }

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
	let g:terminal_color_0  = s:gui(s:gui.background)
	let g:terminal_color_1  = s:gui(s:gui.red)
	let g:terminal_color_2  = s:gui(s:gui.green)
	let g:terminal_color_3  = s:gui(s:gui.yellow)
	let g:terminal_color_4  = s:gui(s:gui.blue)
	let g:terminal_color_5  = s:gui(s:gui.accent)
	let g:terminal_color_6  = s:gui(s:gui.cyan)
	let g:terminal_color_7  = s:gui(s:gui.foreground)
	let g:terminal_color_8  = s:gui(s:gui.selection)
	let g:terminal_color_9  = s:gui(s:gui.red)
	let g:terminal_color_10 = s:gui(s:gui.green)
	let g:terminal_color_11 = s:gui(s:gui.yellow)
	let g:terminal_color_12 = s:gui(s:gui.blue)
	let g:terminal_color_13 = s:gui(s:gui.accent)
	let g:terminal_color_14 = s:gui(s:gui.cyan)
	let g:terminal_color_15 = s:gui(s:gui.foreground)
endif

" "EDITOR COLORS
call s:hi("User1",        s:gui.green,      s:gui.line,       "bold")
call s:hi("User2",        s:gui.background, s:gui.background, "bold")
call s:hi("User3",        s:gui.line,       s:gui.background, "bold")
call s:hi("User4",        s:gui.background, s:gui.line,       "bold")

call s:hi("StatusLine",       s:gui.line,   s:gui.foreground, "")
call s:hi("StatusLineNC",     s:gui.line,   s:gui.background, "")
call s:hi("StatusLineTerm",   s:gui.line,   s:gui.foreground, "")
call s:hi("StatusLineTemrNC",   s:gui.line, s:gui.background, "")

call s:hi("EndOfBuffer",  s:gui.background, s:gui.none,       "")
call s:hi("ColorColumn",  s:gui.none,       s:gui.line,       "")
call s:hi("Cursor",       s:gui.accent,     "",               "")
call s:hi("CursorColumn", s:gui.none,       s:gui.line,       "")
call s:hi("LineNr",       s:gui.line,       "",               "")
call s:hi("CursorLine",   s:gui.none,       s:gui.none,       "")
call s:hi("CursorLineNr", s:gui.accent,     s:gui.none,       "")
call s:hi("Directory",    s:gui.blue,       "",               "")
call s:hi("FoldColumn",   "",               s:gui.none,       "")
call s:hi("Folded",       s:gui.comment,    s:gui.line,       "")
call s:hi("PMenu",        s:gui.foreground, s:gui.line,       "")
call s:hi("PMenuSel",     s:gui.cyan,       s:gui.none,       "")
call s:hi("ErrorMsg",     s:gui.accent,     s:gui.none,       "")
call s:hi("Error",        s:gui.accent,     s:gui.none,       "")
call s:hi("WarningMsg",   s:gui.accent,     "",               "")
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
call s:hi("Normal",       s:gui.foreground, s:gui.none,       "")
call s:hi("Visual",       s:gui.background, s:gui.selection,  "")
call s:hi("Constant",     s:gui.blue,       "",               "")
call s:hi("Type",         s:gui.blue,       "",               "")
call s:hi("Define",       s:gui.cyan,       "",               "")
call s:hi("Statement",    s:gui.blue,       "",               "")
call s:hi("Function",     s:gui.accent,     "",               "")
call s:hi("Conditional",  s:gui.red,        "",               "")
call s:hi("Float",        s:gui.green,      "",               "")
call s:hi("Noise",        s:gui.cyan,       "",               "")
call s:hi("Number",       s:gui.green,      "",               "")
call s:hi("Identifier",   s:gui.blue,       "",               "")
call s:hi("Operator",     s:gui.cyan,       "",               "")
call s:hi("PreProc",      s:gui.blue,       "",               "")
call s:hi("Search",       s:gui.none,       s:gui.none,       "underline")
call s:hi("InSearch",     s:gui.black,      s:gui.foreground, "")
call s:hi("Todo",         s:gui.red,        s:gui.foreground, "")
call s:hi("Special",      s:gui.accent,     "",               "") " @observable etc...

" ALE COLORS
call s:hi("AleText",      s:gui.accent,     s:gui.line, "")
call s:hi("AleWarning",   s:gui.accent,     s:gui.line, "")
call s:hi("AleLine",      "",               s:gui.none, "")

hi link ALEErrorSign    AleText
hi link ALEWarningSign  AleText
hi link ALEErrorLine    AleLine
hi link ALEInfoLine     AleLine

" TYPESCRIPT COLORS
" leafgarland/typescript-vim

" ts comments
call s:hi("typescriptComment",       s:gui.comment,       "", "")
call s:hi("typescriptLineComment",   s:gui.comment,       "", "")
call s:hi("typescriptRefComment",    s:gui.comment,       "", "")
call s:hi("typescriptRefD",          s:gui.comment,       "", "")
call s:hi("typescriptRefS",          s:gui.comment,       "", "")
call s:hi("typescriptCommentSkip",   s:gui.comment,       "", "")
call s:hi("typescriptComment",       s:gui.comment,       "", "")

" jsdoc comments
call s:hi("typescriptDocComment",    s:gui.comment,       "", "")
call s:hi("typescriptDocTags",       s:gui.comment,       "", "")
call s:hi("typescriptDocParam",      s:gui.comment,       "", "")
call s:hi("typescriptDocSeeTag",     s:gui.comment,       "", "")

" general code
call s:hi("typescriptSpecial",                   s:gui.cyan,            "", "")
call s:hi("typescriptStringD",                   s:gui.cyan,            "", "")
call s:hi("typescriptStringS",                   s:gui.cyan,            "", "")
call s:hi("typescriptStringB",                   s:gui.cyan,            "", "")
call s:hi("typescriptInterpolation",             s:gui.green,           "", "")
call s:hi("typescriptNumber",                    s:gui.green,           "", "")
call s:hi("typescriptRegexpString",              s:gui.cyan,            "", "")
call s:hi("typescriptPrototype",                 s:gui.red,             "", "")
call s:hi("typescriptBrowserObjects",            s:gui.red,             "", "")
call s:hi("typescriptDOMObjects",                s:gui.blue,            "", "")
call s:hi("typescriptDOMMethods",                s:gui.yellow,          "", "")
call s:hi("typescriptDOMProperties",             s:gui.yellow,          "", "")
call s:hi("typescriptHtmlElemProperties",        s:gui.cyan,            "", "")
call s:hi("typescriptEventListenerKeywords",     s:gui.cyan,            "", "")
call s:hi("typescriptEventListenerMethods",      s:gui.cyan,            "", "")

" program keywords
call s:hi("typescriptSource",            s:gui.red,          "", "") " import export from as
call s:hi("typescriptIdentifier",        s:gui.blue,         "", "") " arguments this void
call s:hi("typescriptStorageClass",      s:gui.blue,         "", "") " let var const
call s:hi("typescriptOperator",          s:gui.blue,         "", "") " delete new instanceof typeof
call s:hi("typescriptBoolean",           s:gui.green,        "", "") " true false
call s:hi("typescriptNull",              s:gui.green,        "", "") " null undefined
call s:hi("typescriptMessage",           s:gui.green,        "", "") " alert confirm prompt status

" statement keywords
call s:hi("typescriptConditional",       s:gui.green,       "", "") " if else switch
call s:hi("typescriptRepeat",            s:gui.green,       "", "") " do while for in of
call s:hi("typescriptBranch",            s:gui.green,       "", "") " break continue yield await
call s:hi("typescriptLabel",             s:gui.green,       "", "") " case default async readonly
call s:hi("typescriptStatement",         s:gui.green,       "", "") " return with

" dom objects, etc
call s:hi("typescriptGlobalObjects",     s:gui.blue,             "", "") " Array Boolean Date Function Infinity Math Number NaN Object Packages RegExp String Symbol
call s:hi("typescriptExceptions   ",     s:gui.green,            "", "") " try catch throw finally Error EvalError RangeError ReferenceError SyntaxError TypeError URIError
call s:hi("typescriptReserved",          s:gui.red,              "", "") " constructor as interface module enum int export interface static extends super class private implements import public type from get set keyof...
call s:hi("typescriptVars",              s:gui.green,            "", "")
call s:hi("typescriptParameters",        s:gui.green,            "", "")
call s:hi("typescriptType",              s:gui.green,            "", "") " void any string boolean number symbol never object

" dom constants
call s:hi("typescriptDomErrNo",          s:gui.red,              "", "")
call s:hi("typescriptDomNodeConsts",     s:gui.red,              "", "")

" html events
call s:hi("typescriptHtmlEvents",        s:gui.cyan,       "", "") " onblur onclick onfocus onkeydown onkeypress onkeyup ...

" ts css
call s:hi("typescriptCssStyles",         s:gui.red,              "", "") " not sure where these ever occur... ?

" functions
call s:hi("typescriptFuncKeyword",        s:gui.accent,          "", "")
call s:hi("typescriptFunction",           s:gui.accent,          "", "")

" braces, brackets, operators, colons etc
call s:hi("typescriptBraces",             s:gui.accent,           "", "")
call s:hi("typescriptParens",             s:gui.accent,           "", "")
call s:hi("typescriptOpSymbols",          s:gui.accent,           "", "")
call s:hi("typescriptEndColons",          s:gui.accent,           "", "")
call s:hi("typescriptLogicSymbols",       s:gui.accent,           "", "")

" Javascript colors
" yajs
" call s:hi("javascriptArrayMethod",      s:gui.blue,       "", "")
" call s:hi("javascriptBlock",            s:gui.cyan,       "", "")
" call s:hi("javascriptBraces",           s:gui.cyan,       "", "")
" call s:hi("javascriptBrackets",         s:gui.cyan,       "", "")
" call s:hi("javascriptClassName",        s:gui.accent,    "", "")
" call s:hi("javascriptClassSuperName",   s:gui.yellow,     "", "")
" call s:hi("javascriptExport",           s:gui.red,        "", "")
" call s:hi("javascriptFuncKeyword",      s:gui.accent,    "", "")
" call s:hi("javascriptIdentifierName",   s:gui.foreground, "", "")
" call s:hi("javascriptLabel",            s:gui.foreground, "", "")
" call s:hi("javascriptMethod",           s:gui.blue,       "", "")
" call s:hi("javascriptObjectLabel",      s:gui.foreground, "", "")
" call s:hi("javascriptObjectLabelColon", s:gui.cyan,       "", "")
" call s:hi("javascriptObjectMethodName", s:gui.blue,       "", "")
" call s:hi("javascriptOperator",         s:gui.accent,    "", "")
" call s:hi("javascriptProperty",         s:gui.cyan,       "", "")
" call s:hi("javascriptStringMethod",     s:gui.blue,       "", "")
" call s:hi("javascriptVariable",         s:gui.accent,    "", "")

" vim-javascript
call s:hi("jsArrowFuncArgs",   s:gui.green,      "", "")
call s:hi("jsArrowFunction",   s:gui.accent,     "", "")
call s:hi("jsBooleanFalse",    s:gui.green,      "", "")
call s:hi("jsBooleanTrue",     s:gui.green,      "", "")
call s:hi("jsClassBraces",     s:gui.cyan,       "", "")
call s:hi("jsClassDefinition", s:gui.yellow,     "", "")
call s:hi("jsClassKeyword",    s:gui.red,        "", "")
call s:hi("jsConditional",     s:gui.cyan,       "", "")
call s:hi("jsFuncArgs",        s:gui.green,      "", "")
call s:hi("jsFuncBraces",      s:gui.accent,     "", "")
call s:hi("jsFuncCall",        s:gui.cyan,       "", "")
call s:hi("jsFuncParens",      s:gui.accent,     "", "")
call s:hi("jsFunction",        s:gui.blue,       "", "")
call s:hi("jsFunctionKey",     s:gui.accent,     "", "")
call s:hi("jsGlobalObjects",   s:gui.yellow,     "", "")
call s:hi("jsNoise",           s:gui.accent,     "", "")
call s:hi("jsObjectKey",       s:gui.foreground, "", "")
call s:hi("jsOperator",        s:gui.accent,     "", "")
call s:hi("jsParens",          s:gui.accent,     "", "")
call s:hi("jsReturn",          s:gui.green,      "", "")
call s:hi("jsStorageClass",    s:gui.blue,       "", "")
call s:hi("jsThis",            s:gui.blue,       "", "")

" yats
" call s:hi("typescriptAccessibilityModifier", s:gui.accent,  "", "")
" call s:hi("typescriptCall",                  s:gui.accent,  "", "")
" call s:hi("typescriptClassName",             s:gui.yellow,  "", "")
" call s:hi("typescriptExport",                s:gui.red,     "", "")
" call s:hi("typescriptImport",                s:gui.blue,    "", "")
" call s:hi("typescriptInterfaceName",         s:gui.yellow,  "", "")
" call s:hi("typescriptPredefinedType",        s:gui.cyan,    "", "")
" call s:hi("typescriptVariable",              s:gui.accent,  "", "")
" call s:hi("typescriptOperator",              s:gui.accent,  "", "")

" HTML colors
call s:hi("htmlTag",            s:gui.cyan,   "", "")
call s:hi("htmlEndTag",         s:gui.cyan,   "", "")
call s:hi("htmlTagName",        s:gui.accent, "", "")
call s:hi("htmlSpecialTagName", s:gui.red,    "", "")
call s:hi("htmlArg",            s:gui.yellow, "", "")

" jsx colors
call s:hi("xmlTag",     s:gui.cyan,   "", "")
call s:hi("xmlEndTag",  s:gui.cyan,   "", "")
call s:hi("xmlTagName", s:gui.accent, "", "")
call s:hi("xmlAttrib",  s:gui.yellow, "", "")
