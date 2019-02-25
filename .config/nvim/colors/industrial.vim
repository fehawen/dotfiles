highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "industrial"

let s:gui = {}
let s:cterm = {}

let s:gui.background = { 'dark': '#0E1014', 'light': '#0E1014' }
let s:gui.foreground = { 'dark': '#CFD8DC', 'light': '#CFD8DC' }
let s:gui.none       = { 'dark': 'NONE',    'light': 'NONE',   }
let s:gui.selection  = { 'dark': '#B0BEC5', 'light': '#B0BEC5' }
let s:gui.line       = { 'dark': '#FF6E2C', 'light': '#FF6E2C' }
let s:gui.comment    = { 'dark': '#263238', 'light': '#263238' }

let s:gui.black        = { 'dark': '#263238', 'light': '#263238' }
let s:gui.red          = { 'dark': '#37474F', 'light': '#37474F' }
let s:gui.yellow       = { 'dark': '#455A64', 'light': '#455A64' }
let s:gui.green        = { 'dark': '#546E7A', 'light': '#546E7A' }
let s:gui.cyan         = { 'dark': '#607D8B', 'light': '#607D8B' }
let s:gui.blue         = { 'dark': '#546E7A', 'light': '#546E7A' }
let s:gui.orange       = { 'dark': '#F4511E', 'light': '#F4511E' }

if !exists('g:industrial_style')
  let g:industrial_style='default'
endif

function! s:hi(group, guifg, guibg, ctermfg, ctermbg, attr)
  if s:gui(a:guifg) != ""
    exec "hi " . a:group . " guifg=" . s:gui(a:guifg)
  endif
  if s:gui(a:guibg) != ""
    exec "hi " . a:group . " guibg=" . s:gui(a:guibg)
  endif
  if a:ctermfg != ""
    exec "hi " . a:group . " ctermfg=" . a:ctermfg
  endif
  if a:ctermbg != ""
    exec "hi " . a:group . " ctermbg=" . a:ctermbg
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
endfunction

function! s:gui(color)
  if &background == "light"
    return a:color['light']
  else
    if g:industrial_style == 'default'
      return a:color['dark']
    else
      return a:color[g:industrial_style]
    endif
  endif
endfunction

" Neovim Terminal colors
if has("nvim")
  let g:terminal_color_0  = s:gui(s:gui.background)
  let g:terminal_color_1  = s:gui(s:gui.red)
  let g:terminal_color_2  = s:gui(s:gui.green)
  let g:terminal_color_3  = s:gui(s:gui.yellow)
  let g:terminal_color_4  = s:gui(s:gui.blue)
  let g:terminal_color_5  = s:gui(s:gui.orange)
  let g:terminal_color_6  = s:gui(s:gui.cyan)
  let g:terminal_color_7  = s:gui(s:gui.foreground)
  let g:terminal_color_8  = s:gui(s:gui.selection)
  let g:terminal_color_9  = s:gui(s:gui.red)
  let g:terminal_color_10 = s:gui(s:gui.green)
  let g:terminal_color_11 = s:gui(s:gui.yellow)
  let g:terminal_color_12 = s:gui(s:gui.blue)
  let g:terminal_color_13 = s:gui(s:gui.orange)
  let g:terminal_color_14 = s:gui(s:gui.cyan)
  let g:terminal_color_15 = s:gui(s:gui.foreground)
endif

" Editor Colors
call s:hi("ColorColumn",  s:gui.none,       s:gui.line,       "", "", "")
call s:hi("Cursor",       s:gui.yellow,     "",               "", "", "")
call s:hi("CursorColumn", s:gui.none,       s:gui.line,       "", "", "")
call s:hi("LineNr",       s:gui.red,        "",               "", "", "")
call s:hi("CursorLine",   s:gui.none,       s:gui.none,       "", "", "")
call s:hi("CursorLineNr", s:gui.orange,     s:gui.none,       "", "", "")
call s:hi("Directory",    s:gui.blue,       "",               "", "", "")
call s:hi("FoldColumn",   "",               s:gui.none,       "", "", "")
call s:hi("Folded",       s:gui.comment,    s:gui.line,       "", "", "")
call s:hi("PMenu",        s:gui.foreground, s:gui.line,       "", "", "")
call s:hi("PMenuSel",     s:gui.cyan,       s:gui.none,       "", "", "")
call s:hi("ErrorMsg",     s:gui.orange,     s:gui.none,       "", "", "")
call s:hi("Error",        s:gui.orange,     s:gui.none,       "", "", "")
call s:hi("WarningMsg",   s:gui.orange,     "",               "", "", "")
call s:hi("VertSplit",    s:gui.black,      s:gui.none,       "", "", "")
call s:hi("Conceal",      s:gui.comment,    s:gui.none,       "", "", "")

call s:hi("DiffAdded",    s:gui.green,      "", "", "", "")
call s:hi("DiffRemoved",  s:gui.red,        "", "", "", "")

call s:hi("DiffAdd",      "",               s:gui.cyan,       "", "", "")
call s:hi("DiffChange",   "",               s:gui.cyan,       "", "", "")
call s:hi("DiffDelete",   s:gui.red,        s:gui.black,      "", "", "")
call s:hi("DiffText",     "",               s:gui.selection,  "", "", "")

call s:hi("NonText",      s:gui.comment,    "",               "", "", "")
call s:hi("helpExample",  s:gui.blue,       "",               "", "", "")
call s:hi("MatchParen",   "",               s:gui.selection,  "", "", "")
call s:hi("Title",        s:gui.cyan,       "",               "", "", "")
call s:hi("Comment",      s:gui.comment,    "",               "", "", "italic")
call s:hi("String",       s:gui.green,      "",               "", "", "")
call s:hi("Normal",       s:gui.foreground, s:gui.none,       "", "", "")
call s:hi("Visual",       "",               s:gui.selection,  "", "", "")
call s:hi("Constant",     s:gui.blue,       "",               "", "", "bold")
call s:hi("Type",         s:gui.blue,       "",               "", "", "bold")
call s:hi("Define",       s:gui.cyan,       "",               "", "", "")
call s:hi("Statement",    s:gui.blue,       "",               "", "", "italic")
call s:hi("Function",     s:gui.blue,       "",               "", "", "bold")
call s:hi("Conditional",  s:gui.red,        "",               "", "", "bold")
call s:hi("Float",        s:gui.green,      "",               "", "", "bold")
call s:hi("Noise",        s:gui.cyan,       "",               "", "", "")
call s:hi("Number",       s:gui.green,      "",               "", "", "bold")
call s:hi("Identifier",   s:gui.blue,       "",               "", "", "bold")
call s:hi("Operator",     s:gui.cyan,       "",               "", "", "")
call s:hi("PreProc",      s:gui.blue,       "",               "", "", "")
call s:hi("Search",       s:gui.none,       s:gui.none,       "", "", "underline")
call s:hi("InSearch",     s:gui.black,      s:gui.foreground, "", "", "")
call s:hi("Todo",         s:gui.red,        s:gui.foreground, "", "", "italic")
call s:hi("Special",      s:gui.cyan,       "",               "", "", "italic") " @observable etc...

" Ale
call s:hi("AleText",      s:gui.orange,     s:gui.none, "", "", "")
call s:hi("AleWarning",   s:gui.orange,     s:gui.none, "", "", "")
call s:hi("AleLine",      "",               s:gui.none, "", "", "")

hi link ALEErrorSign    AleText
hi link ALEWarningSign  AleText
hi link ALEErrorLine    AleLine
hi link ALEInfoLine     AleLine

" TYPESCRIPT COLORS
" leafgarland/typescript-vim

" ts comments
call s:hi("typescriptComment",       s:gui.comment,       "", "", "", "italic")
call s:hi("typescriptLineComment",   s:gui.comment,       "", "", "", "italic")
call s:hi("typescriptRefComment",    s:gui.comment,       "", "", "", "italic")
call s:hi("typescriptRefD",          s:gui.comment,       "", "", "", "italic")
call s:hi("typescriptRefS",          s:gui.comment,       "", "", "", "italic")
call s:hi("typescriptCommentSkip",   s:gui.comment,       "", "", "", "italic")
call s:hi("typescriptComment",       s:gui.comment,       "", "", "", "italic")

" jsdoc comments
call s:hi("typescriptDocComment",    s:gui.comment,       "", "", "", "italic")
call s:hi("typescriptDocTags",       s:gui.comment,       "", "", "", "italic")
call s:hi("typescriptDocParam",      s:gui.comment,       "", "", "", "italic")
call s:hi("typescriptDocSeeTag",     s:gui.comment,       "", "", "", "italic")

" general code
call s:hi("typescriptSpecial",                   s:gui.yellow,          "", "", "", "")
call s:hi("typescriptStringD",                   s:gui.yellow,          "", "", "", "")
call s:hi("typescriptStringS",                   s:gui.yellow,          "", "", "", "")
call s:hi("typescriptStringB",                   s:gui.yellow,          "", "", "", "")
call s:hi("typescriptInterpolation",             s:gui.green,           "", "", "", "italic")
call s:hi("typescriptNumber",                    s:gui.green,           "", "", "", "bold")
call s:hi("typescriptRegexpString",              s:gui.cyan,            "", "", "", "")
call s:hi("typescriptPrototype",                 s:gui.red,             "", "", "", "italic")
call s:hi("typescriptBrowserObjects",            s:gui.red,             "", "", "", "bold")
call s:hi("typescriptDOMObjects",                s:gui.blue,            "", "", "", "bold")
call s:hi("typescriptDOMMethods",                s:gui.yellow,          "", "", "", "italic")
call s:hi("typescriptDOMProperties",             s:gui.yellow,          "", "", "", "italic")
call s:hi("typescriptHtmlElemProperties",        s:gui.cyan,            "", "", "", "italic")
call s:hi("typescriptEventListenerKeywords",     s:gui.cyan,            "", "", "", "italic")
call s:hi("typescriptEventListenerMethods",      s:gui.cyan,            "", "", "", "italic")

" program keywords
call s:hi("typescriptSource",            s:gui.yellow,       "", "", "", "italic") " import export from as
call s:hi("typescriptIdentifier",        s:gui.blue,         "", "", "", "bold") " arguments this void
call s:hi("typescriptStorageClass",      s:gui.blue,         "", "", "", "bold") " let var const
call s:hi("typescriptOperator",          s:gui.blue,         "", "", "", "bold") " delete new instanceof typeof
call s:hi("typescriptBoolean",           s:gui.green,        "", "", "", "bold") " true false
call s:hi("typescriptNull",              s:gui.green,        "", "", "", "bold") " null undefined
call s:hi("typescriptMessage",           s:gui.green,        "", "", "", "bold") " alert confirm prompt status

" statement keywords
call s:hi("typescriptConditional",       s:gui.green,       "", "", "", "italic") " if else switch
call s:hi("typescriptRepeat",            s:gui.green,       "", "", "", "italic") " do while for in of
call s:hi("typescriptBranch",            s:gui.green,       "", "", "", "italic") " break continue yield await
call s:hi("typescriptLabel",             s:gui.green,       "", "", "", "italic") " case default async readonly
call s:hi("typescriptStatement",         s:gui.green,       "", "", "", "italic") " return with

" dom objects, etc
call s:hi("typescriptGlobalObjects",     s:gui.blue,             "", "", "", "bold") " Array Boolean Date Function Infinity Math Number NaN Object Packages RegExp String Symbol
call s:hi("typescriptExceptions   ",     s:gui.green,            "", "", "", "italic") " try catch throw finally Error EvalError RangeError ReferenceError SyntaxError TypeError URIError
call s:hi("typescriptReserved",          s:gui.yellow,           "", "", "", "italic") " constructor as interface module enum int export interface static extends super class private implements import public type from get set keyof...
call s:hi("typescriptVars",              s:gui.green,            "", "", "", "")
call s:hi("typescriptParameters",        s:gui.green,            "", "", "", "")
call s:hi("typescriptType",              s:gui.green,            "", "", "", "bold") " void any string boolean number symbol never object

" dom constants
call s:hi("typescriptDomErrNo",          s:gui.red,              "", "", "", "bold")
call s:hi("typescriptDomNodeConsts",     s:gui.red,              "", "", "", "bold")

" html events
call s:hi("typescriptHtmlEvents",        s:gui.foreground,       "", "", "", "italic") " onblur onclick onfocus onkeydown onkeypress onkeyup ...

" ts css
call s:hi("typescriptCssStyles",         s:gui.red,              "", "", "", "bold") " not sure where these ever occur... ?

" functions
call s:hi("typescriptFuncKeyword",        s:gui.foreground,      "", "", "", "italic")
call s:hi("typescriptFunction",           s:gui.foreground,      "", "", "", "bold")

" braces, brackets, operators, colons etc
call s:hi("typescriptBraces",             s:gui.orange,           "", "", "", "")
call s:hi("typescriptParens",             s:gui.orange,           "", "", "", "")
call s:hi("typescriptOpSymbols",          s:gui.orange,           "", "", "", "")
call s:hi("typescriptEndColons",          s:gui.orange,           "", "", "", "")
call s:hi("typescriptLogicSymbols",       s:gui.orange,           "", "", "", "")







" Javascript colors
" yajs
" call s:hi("javascriptArrayMethod",      s:gui.blue,       "", "", "", "")
" call s:hi("javascriptBlock",            s:gui.cyan,       "", "", "", "")
" call s:hi("javascriptBraces",           s:gui.cyan,       "", "", "", "")
" call s:hi("javascriptBrackets",         s:gui.cyan,       "", "", "", "")
" call s:hi("javascriptClassName",        s:gui.orange,    "", "", "", "bold")
" call s:hi("javascriptClassSuperName",   s:gui.yellow,     "", "", "", "")
" call s:hi("javascriptExport",           s:gui.red,        "", "", "", "italic")
" call s:hi("javascriptFuncKeyword",      s:gui.orange,    "", "", "", "bold")
" call s:hi("javascriptIdentifierName",   s:gui.foreground, "", "", "", "")
" call s:hi("javascriptLabel",            s:gui.foreground, "", "", "", "")
" call s:hi("javascriptMethod",           s:gui.blue,       "", "", "", "")
" call s:hi("javascriptObjectLabel",      s:gui.foreground, "", "", "", "")
" call s:hi("javascriptObjectLabelColon", s:gui.cyan,       "", "", "", "")
" call s:hi("javascriptObjectMethodName", s:gui.blue,       "", "", "", "")
" call s:hi("javascriptOperator",         s:gui.orange,    "", "", "", "")
" call s:hi("javascriptProperty",         s:gui.cyan,       "", "", "", "")
" call s:hi("javascriptStringMethod",     s:gui.blue,       "", "", "", "")
" call s:hi("javascriptVariable",         s:gui.orange,    "", "", "", "")

" vim-javascript
" call s:hi("jsArrowFuncArgs",   s:gui.red,        "", "", "", "")
" call s:hi("jsArrowFunction",   s:gui.orange,    "", "", "", "")
" call s:hi("jsBooleanFalse",    s:gui.orange,    "", "", "", "")
" call s:hi("jsBooleanTrue",     s:gui.orange,    "", "", "", "")
" call s:hi("jsClassBraces",     s:gui.cyan,       "", "", "", "")
" call s:hi("jsClassDefinition", s:gui.yellow,     "", "", "", "bold")
" call s:hi("jsClassKeyword",    s:gui.orange,    "", "", "", "italic")
" call s:hi("jsConditional",     s:gui.cyan,       "", "", "", "bold")
" call s:hi("jsFuncArgs",        s:gui.red,        "", "", "", "")
" call s:hi("jsFuncBraces",      s:gui.cyan,       "", "", "", "")
" call s:hi("jsFuncCall",        s:gui.blue,       "", "", "", "")
" call s:hi("jsFuncParens",      s:gui.cyan,       "", "", "", "")
" call s:hi("jsFunction",        s:gui.red,        "", "", "", "italic")
" call s:hi("jsFunctionKey",     s:gui.orange,    "", "", "", "bold")
" call s:hi("jsGlobalObjects",   s:gui.yellow,     "", "", "", "")
" call s:hi("jsNoise",           s:gui.cyan,       "", "", "", "")
" call s:hi("jsObjectKey",       s:gui.foreground, "", "", "", "")
" call s:hi("jsOperator",        s:gui.orange,    "", "", "", "")
" call s:hi("jsParens",          s:gui.cyan,       "", "", "", "")
" call s:hi("jsReturn",          s:gui.cyan,       "", "", "", "italic")
" call s:hi("jsStorageClass",    s:gui.orange,    "", "", "", "")
" call s:hi("jsThis",            s:gui.red,        "", "", "", "")

" yats
" call s:hi("typescriptAccessibilityModifier", s:gui.orange,  "", "", "", "")
" call s:hi("typescriptCall",                  s:gui.orange,  "", "", "", "")
" call s:hi("typescriptClassName",             s:gui.yellow,  "", "", "", "bold")
" call s:hi("typescriptExport",                s:gui.red,     "", "", "", "italic")
" call s:hi("typescriptImport",                s:gui.blue,    "", "", "", "italic")
" call s:hi("typescriptInterfaceName",         s:gui.yellow,  "", "", "", "bold")
" call s:hi("typescriptPredefinedType",        s:gui.cyan,    "", "", "", "")
" call s:hi("typescriptVariable",              s:gui.orange,  "", "", "", "italic")
" call s:hi("typescriptOperator",              s:gui.orange,  "", "", "", "")

" HTML colors
call s:hi("htmlTag",            s:gui.cyan,   "", "", "", "")
call s:hi("htmlEndTag",         s:gui.cyan,   "", "", "", "")
call s:hi("htmlTagName",        s:gui.orange, "", "", "", "")
call s:hi("htmlSpecialTagName", s:gui.red,    "", "", "", "")
call s:hi("htmlArg",            s:gui.yellow, "", "", "", "")

" jsx colors
call s:hi("xmlTag",     s:gui.cyan,   "", "", "", "")
call s:hi("xmlEndTag",  s:gui.cyan,   "", "", "", "")
call s:hi("xmlTagName", s:gui.orange, "", "", "", "")
call s:hi("xmlAttrib",  s:gui.yellow, "", "", "", "")