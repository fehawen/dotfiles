highlight clear

if exists("syntax_on")
	syntax reset
endif

let s:style = get(g:, "debris_style", "default")
let g:colors_name = "debris"

let s:gui = {}
let s:cterm = {}

let s:gui.none       = { "default": "NONE" }
let s:gui.foreground = { "default": "#C9CFDA" }
let s:gui.background = { "default": "#1B212C" }

let s:gui.cursorline = { "default": "#3B4252" }
let s:gui.listchars  = { "default": "#434C5E" }
let s:gui.comment    = { "default": "#4C566A" }
let s:gui.search     = { "default": "#82858C" }
let s:gui.selection  = { "default": "#AAAEB7" }

let s:gui.black      = { "default": "#4C566A" }
let s:gui.grey       = { "default": "#8A909A" }
let s:gui.red        = { "default": "#AA7B7B" }
let s:gui.green      = { "default": "#8CAA7B" }
let s:gui.yellow     = { "default": "#AA9F7B" }
let s:gui.orange     = { "default": "#AA897A" }
let s:gui.blue       = { "default": "#7B93AA" }
let s:gui.magenta    = { "default": "#AA7B98" }
let s:gui.cyan       = { "default": "#7BA6AA" }

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
	if exists("g:debris_style")
		return a:color[s:style]
	else
		return a:color["default"]
	endif
endfunction

" NEOVIM TERMINAL COLORS
if has("nvim")
	let g:terminal_color_0  = s:gui(s:gui.black)
	let g:terminal_color_1  = s:gui(s:gui.red)
	let g:terminal_color_2  = s:gui(s:gui.green)
	let g:terminal_color_3  = s:gui(s:gui.yellow)
	let g:terminal_color_4  = s:gui(s:gui.blue)
	let g:terminal_color_5  = s:gui(s:gui.magenta)
	let g:terminal_color_6  = s:gui(s:gui.cyan)
	let g:terminal_color_7  = s:gui(s:gui.foreground)
	let g:terminal_color_8  = s:gui(s:gui.black)
	let g:terminal_color_9  = s:gui(s:gui.red)
	let g:terminal_color_10 = s:gui(s:gui.green)
	let g:terminal_color_11 = s:gui(s:gui.yellow)
	let g:terminal_color_12 = s:gui(s:gui.blue)
	let g:terminal_color_13 = s:gui(s:gui.magenta)
	let g:terminal_color_14 = s:gui(s:gui.cyan)
	let g:terminal_color_15 = s:gui(s:gui.foreground)
endif

" EDITOR COLORS
call s:hi("User1",              s:gui.background,    s:gui.background,    "")
call s:hi("User2",              s:gui.red,           s:gui.background,    "bold")
call s:hi("User3",              s:gui.green,         s:gui.background,    "bold")
call s:hi("User4",              s:gui.yellow,        s:gui.background,    "bold")
call s:hi("User5",              s:gui.blue,          s:gui.background,    "bold")
call s:hi("User6",              s:gui.magenta,       s:gui.background,    "bold")
call s:hi("User7",              s:gui.cyan,          s:gui.background,    "bold")
call s:hi("User8",              s:gui.comment,       s:gui.background,    "bold")

" STATUSLINE COLORS (basic/fallback as we have a separate statusline in ./plugin)
call s:hi("StatusLine",         s:gui.background,    s:gui.background,    "none")
call s:hi("StatusLineNC",       s:gui.cursorline,    s:gui.background,    "none")
call s:hi("StatusLineTerm",     s:gui.background,    s:gui.background,    "none")
call s:hi("StatusLineTemrNC",   s:gui.cursorline,    s:gui.background,    "none")

"call"
" NERDTREE COLORS
call s:hi("NERDTreeOpenable",   s:gui.black,         s:gui.none,          "")
call s:hi("NERDTreeClosable",   s:gui.black,         s:gui.none,          "")
call s:hi("NERDTreeCWD",        s:gui.blue,          s:gui.none,          "")
call s:hi("NERDTreeDir",        s:gui.grey,          s:gui.none,          "bold")
call s:hi("NERDTreeDirSlash",   s:gui.background,    s:gui.none,          "")
call s:hi("NERDTreeExecFile",   s:gui.blue,          s:gui.none,          "")

" ALE COLORS
call s:hi("ALEInfoSign",         s:gui.yellow,       s:gui.none,          "italic")
call s:hi("ALEErrorSign",        s:gui.red,          s:gui.none,          "italic")
call s:hi("ALEWarningSign",      s:gui.yellow,       s:gui.none,          "italic")
call s:hi("ALEStyleErrorSign",   s:gui.red,          s:gui.none,          "italic")
call s:hi("ALEStyleWarningSign", s:gui.yellow,       s:gui.none,          "italic")
call s:hi("ALEInfoLine",         s:gui.yellow,       s:gui.none,          "italic")
call s:hi("ALEErrorLine",        s:gui.red,          s:gui.none,          "italic")
call s:hi("ALEWarningLine",      s:gui.yellow,       s:gui.none,          "italic")

call s:hi("EndOfBuffer",  s:gui.background, "",               "")
call s:hi("ColorColumn",  s:gui.none,       s:gui.black,      "")
call s:hi("Cursor",       s:gui.foreground, "",               "")
call s:hi("CursorColumn", s:gui.none,       s:gui.none,       "")
call s:hi("SignColumn",   s:gui.red,        s:gui.none,       "")
call s:hi("LineNr",       s:gui.cursorline, s:gui.background, "")
call s:hi("CursorLine",   s:gui.none,       s:gui.none,       "")
call s:hi("CursorLineNr", s:gui.cursorline, s:gui.background, "bold")
call s:hi("Directory",    s:gui.blue,       "",               "")
call s:hi("FoldColumn",   "",               s:gui.none,       "")
call s:hi("Folded",       s:gui.background, s:gui.black,      "")
call s:hi("PMenu",        s:gui.blue,       s:gui.cursorline, "")
call s:hi("PMenuSel",     s:gui.cursorline, s:gui.blue,       "")
call s:hi("ErrorMsg",     s:gui.red,        s:gui.none,       "")
call s:hi("Error",        s:gui.red,        s:gui.none,       "")
call s:hi("WarningMsg",   s:gui.yellow,     "",               "")
call s:hi("SpellBad",     s:gui.red,        s:gui.none,       "none")
call s:hi("VertSplit",    s:gui.black,      s:gui.none,       "none")
call s:hi("Conceal",      s:gui.comment,    s:gui.none,       "")

call s:hi("DiffAdded",    s:gui.green,      "", "")
call s:hi("DiffRemoved",  s:gui.red,        "", "")

call s:hi("DiffAdd",      "",               s:gui.cyan,       "")
call s:hi("DiffChange",   "",               s:gui.cyan,       "")
call s:hi("DiffDelete",   s:gui.red,        s:gui.black,      "")
call s:hi("DiffText",     s:gui.background, s:gui.black,      "")

call s:hi("NonText",      s:gui.listchars,  "",               "none")
call s:hi("helpExample",  s:gui.blue,       "",               "")
call s:hi("MatchParen",   s:gui.background, s:gui.black,      "")
call s:hi("Title",        s:gui.cyan,       "",               "")
call s:hi("Comment",      s:gui.comment,    "",               "")
call s:hi("String",       s:gui.green,      "",               "")
call s:hi("Normal",       s:gui.foreground, s:gui.none,       "")
call s:hi("Visual",       s:gui.background, s:gui.selection,  "")
call s:hi("Constant",     s:gui.blue,       "",               "")
call s:hi("Type",         s:gui.blue,       "",               "")
call s:hi("Define",       s:gui.cyan,       "",               "")
call s:hi("Statement",    s:gui.blue,       "",               "")
call s:hi("Function",     s:gui.magenta,    "",               "")
call s:hi("Conditional",  s:gui.cyan,       "",               "")
call s:hi("Float",        s:gui.green,      "",               "")
call s:hi("Noise",        s:gui.cyan,       "",               "")
call s:hi("Number",       s:gui.yellow,     "",               "")
call s:hi("Identifier",   s:gui.blue,       "",               "")
call s:hi("Operator",     s:gui.cyan,       "",               "")
call s:hi("PreProc",      s:gui.blue,       "",               "")
call s:hi("Search",       s:gui.background, s:gui.search,     "")
call s:hi("InSearch",     s:gui.background, s:gui.search,     "")
call s:hi("Todo",         s:gui.comment,    "",               "")
call s:hi("Special",      s:gui.magenta,    "",               "") " @observable etc...

" TYPESCRIPT
call s:hi("typescriptImport",               s:gui.cyan,        "", "")
call s:hi("typescriptExport",               s:gui.cyan,        "", "")
call s:hi("typescriptAssign",               s:gui.blue,        "", "")
call s:hi("typescriptAssign",               s:gui.magenta,     "", "")
call s:hi("typescriptVariable",             s:gui.magenta,     "", "")
call s:hi("typescriptVariableDeclaration",  s:gui.red,         "", "")
call s:hi("typescriptCastKeyword",          s:gui.cyan,        "", "")
call s:hi("typescriptTypeBrackets",         s:gui.cyan,        "", "")
call s:hi("typescriptTypeReference",        s:gui.yellow,      "", "")
call s:hi("typescriptTypeAnnotation",       s:gui.magenta,     "", "")
call s:hi("typescriptTypeArguments",        s:gui.red,         "", "")
call s:hi("typescriptTypeQuery",            s:gui.magenta,     "", "")
call s:hi("typescriptBraces",               s:gui.blue,        "", "")
call s:hi("typescriptParens",               s:gui.blue,        "", "")
call s:hi("typescriptCall",                 s:gui.foreground,  "", "")
call s:hi("typescriptDotAnnotation",        s:gui.cyan,        "", "")
call s:hi("typescriptDotNotation",          s:gui.cyan,        "", "")
call s:hi("typescriptArrowFunc",            s:gui.magenta,     "", "")
call s:hi("typescriptFuncType",             s:gui.red,         "", "")
call s:hi("typescriptFuncCallArg",          s:gui.foreground,  "", "")
call s:hi("typescriptParenExp",             s:gui.foreground,  "", "")
call s:hi("typescriptAliasKeyword",         s:gui.magenta,     "", "")
call s:hi("typescriptEndColons",            s:gui.cyan,        "", "")
call s:hi("typescriptMember",               s:gui.foreground,  "", "")
call s:hi("typescriptMemberOptionality",    s:gui.magenta,     "", "")
call s:hi("typescriptPredefinedType",       s:gui.grey,        "", "")
call s:hi("typescriptArrayMethod",          s:gui.blue,        "", "")
call s:hi("typescriptNumber",               s:gui.orange,      "", "")
call s:hi("typescriptBoolean",              s:gui.orange,      "", "")
call s:hi("typescriptNull",                 s:gui.orange,      "", "")
call s:hi("typescriptObjectLabel",          s:gui.foreground,  "", "")
call s:hi("typescriptObjectLiteral",        s:gui.cyan,        "", "")
call s:hi("typescriptObjectSpread",         s:gui.magenta,     "", "")
call s:hi("typescriptInterfaceKeyword",     s:gui.magenta,     "", "")
call s:hi("typescriptAliasKeyword",         s:gui.magenta,     "", "")
call s:hi("typescriptInterfaceName",        s:gui.yellow,      "", "")
call s:hi("typescriptAliasDeclaration",     s:gui.yellow,      "", "")
call s:hi("typescriptInterfaceHeritage",    s:gui.green,       "", "")
call s:hi("typescriptInterfaceExtends",     s:gui.magenta,     "", "")
call s:hi("typescriptUnion",                s:gui.magenta,     "", "")
call s:hi("typescriptParamImpl",            s:gui.cyan,        "", "")
call s:hi("typescriptTemplate",             s:gui.green,       "", "")
call s:hi("typescriptTemplateSB",           s:gui.cyan,        "", "")
call s:hi("typescriptTemplateSubstitution", s:gui.foreground,  "", "")
call s:hi("typescriptTernaryOp",            s:gui.cyan,        "", "")
call s:hi("typescriptBinaryOp",             s:gui.cyan,        "", "")

" TSX / JSX
call s:hi("jsxOpenPunct",                   s:gui.cyan,        "", "")
call s:hi("jsxClosePunct",                  s:gui.cyan,        "", "")
call s:hi("jsxCloseString",                 s:gui.cyan,        "", "")
call s:hi("jsxTagName",                     s:gui.red,         "", "")
call s:hi("jsxComponentName",               s:gui.yellow,      "", "")
call s:hi("jsxAttrib",                      s:gui.magenta,     "", "")
call s:hi("jsxElement",                     s:gui.magenta,     "", "")
call s:hi("jsxString",                      s:gui.green,       "", "")
call s:hi("jsxBraces",                      s:gui.cyan,        "", "")


" Javascript colors
" yajs
" call s:hi("javascriptArrayMethod",      s:gui.blue,       "", "")
" call s:hi("javascriptBlock",            s:gui.cyan,       "", "")
" call s:hi("javascriptBraces",           s:gui.cyan,       "", "")
" call s:hi("javascriptBrackets",         s:gui.cyan,       "", "")
" call s:hi("javascriptClassName",        s:gui.magenta,    "", "")
" call s:hi("javascriptClassSuperName",   s:gui.yellow,     "", "")
" call s:hi("javascriptExport",           s:gui.red,        "", "")
" call s:hi("javascriptFuncKeyword",      s:gui.magenta,    "", "")
" call s:hi("javascriptIdentifierName",   s:gui.foreground, "", "")
" call s:hi("javascriptLabel",            s:gui.foreground, "", "")
" call s:hi("javascriptMethod",           s:gui.blue,       "", "")
" call s:hi("javascriptObjectLabel",      s:gui.foreground, "", "")
" call s:hi("javascriptObjectLabelColon", s:gui.cyan,       "", "")
" call s:hi("javascriptObjectMethodName", s:gui.blue,       "", "")
" call s:hi("javascriptOperator",         s:gui.magenta,    "", "")
" call s:hi("javascriptProperty",         s:gui.cyan,       "", "")
" call s:hi("javascriptStringMethod",     s:gui.blue,       "", "")
" call s:hi("javascriptVariable",         s:gui.magenta,    "", "")

" vim-javascript
call s:hi("jsArrowFuncArgs",   s:gui.green,       "", "")
call s:hi("jsArrowFunction",   s:gui.magenta,     "", "")
call s:hi("jsBooleanFalse",    s:gui.yellow,      "", "")
call s:hi("jsBooleanTrue",     s:gui.yellow,      "", "")
call s:hi("jsClassBraces",     s:gui.cyan,        "", "")
call s:hi("jsClassDefinition", s:gui.yellow,      "", "")
call s:hi("jsClassKeyword",    s:gui.cyan,        "", "")
call s:hi("jsCommentTodo",     s:gui.comment,     "", "")
call s:hi("jsConditional",     s:gui.cyan,        "", "")
call s:hi("jsFuncArgs",        s:gui.green,       "", "")
call s:hi("jsFuncBraces",      s:gui.magenta,     "", "")
call s:hi("jsFuncCall",        s:gui.cyan,        "", "")
call s:hi("jsFuncParens",      s:gui.cyan,        "", "")
call s:hi("jsFunction",        s:gui.blue,        "", "")
call s:hi("jsFunctionKey",     s:gui.magenta,     "", "")
call s:hi("jsGlobalObjects",   s:gui.yellow,      "", "")
call s:hi("jsNoise",           s:gui.magenta,     "", "")
call s:hi("jsObjectKey",       s:gui.foreground,  "", "")
call s:hi("jsOperator",        s:gui.magenta,     "", "")
call s:hi("jsNumber",          s:gui.yellow,      "", "")
call s:hi("jsParens",          s:gui.cyan,        "", "")
call s:hi("jsReturn",          s:gui.green,       "", "")
call s:hi("jsStorageClass",    s:gui.magenta,     "", "")
call s:hi("jsThis",            s:gui.blue,        "", "")

" HTML colors
call s:hi("htmlTag",            s:gui.cyan,    "", "")
call s:hi("htmlEndTag",         s:gui.cyan,    "", "")
call s:hi("htmlTagName",        s:gui.magenta, "", "")
call s:hi("htmlSpecialTagName", s:gui.green,   "", "")
call s:hi("htmlArg",            s:gui.yellow,  "", "")

" XML
call s:hi("xmlTag",     s:gui.cyan,    "", "")
call s:hi("xmlEndTag",  s:gui.cyan,    "", "")
call s:hi("xmlTagName", s:gui.magenta, "", "")
call s:hi("xmlAttrib",  s:gui.yellow,  "", "")

" VIM
call s:hi("VimVar",     s:gui.yellow,  "", "")
call s:hi("VimString",  s:gui.blue,    "", "")
call s:hi("VimFuncVar", s:gui.green,   "", "")
call s:hi("VimNumber",  s:gui.yellow,  "", "")

" Shell
call s:hi("shSetList",     s:gui.green,      "", "")
call s:hi("shTestOpr",     s:gui.blue,       "", "")
call s:hi("shNumber",      s:gui.yellow,     "", "")
call s:hi("shConditional", s:gui.cyan,       "", "")
