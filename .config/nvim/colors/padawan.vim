" Initialisation:"{{{
" ----------------------------------------------------------------------------
hi clear
if exists("syntax_on")
  syntax reset
endif

let s:style = get(g:, 'padawan_style', 'default')
let g:colors_name = "padawan"

"}}}

" Palettes:"{{{
" ----------------------------------------------------------------------------

let s:palette = {}

let s:palette.fg          = {'default': "#A2A1A2"}
let s:palette.bg          = {'default': "#0B151D"}
let s:palette.guide       = {'default': "#17242E"}
let s:palette.comment     = {'default': "#243847"}
let s:palette.red         = {'default': "#96423F"}
let s:palette.green       = {'default': "#878D7D"}
let s:palette.yellow      = {'default': "#B09075"}
let s:palette.blue        = {'default': "#596E79"}
let s:palette.magenta     = {'default': "#AA718A"}
let s:palette.cyan        = {'default': "#7E9EB1"}

"}}}

" Highlighting Primitives:"{{{
" ----------------------------------------------------------------------------

function! s:build_prim(hi_elem, field)
  let l:vname = "s:" . a:hi_elem . "_" . a:field " s:bg_gray
  let l:gui_assign = "gui".a:hi_elem."=".s:palette[a:field][s:style] " guibg=...
  exe "let " . l:vname . " = ' " . l:gui_assign . "'"
endfunction

let s:bg_none = ' guibg=NONE ctermbg=NONE'
let s:fg_none = ' guifg=NONE ctermfg=NONE'
for [key_name, d_value] in items(s:palette)
  call s:build_prim('bg', key_name)
  call s:build_prim('fg', key_name)
endfor

" }}}

" Formatting Options:"{{{
" ----------------------------------------------------------------------------
let s:none   = "NONE"
let s:t_none = "NONE"
let s:n      = "NONE"
let s:c      = ",undercurl"
let s:r      = ",reverse"
let s:s      = ",standout"
let s:b      = ",bold"
let s:u      = ",underline"
let s:i      = ",italic"

exe "let s:fmt_none = ' gui=NONE".          " cterm=NONE".          " term=NONE"         ."'"
exe "let s:fmt_bold = ' gui=NONE".s:b.      " cterm=NONE".s:b.      " term=NONE".s:b     ."'"
exe "let s:fmt_bldi = ' gui=NONE".s:b.s:i   " cterm=NONE".s:b.s:i   " term=NONE".s:b.s:i ."'"
exe "let s:fmt_undr = ' gui=NONE".s:u.      " cterm=NONE".s:u.      " term=NONE".s:u     ."'"
exe "let s:fmt_undb = ' gui=NONE".s:u.s:b.  " cterm=NONE".s:u.s:b.  " term=NONE".s:u.s:b ."'"
exe "let s:fmt_undi = ' gui=NONE".s:u.      " cterm=NONE".s:u.      " term=NONE".s:u     ."'"
exe "let s:fmt_curl = ' gui=NONE".s:c.      " cterm=NONE".s:c.      " term=NONE".s:c     ."'"
exe "let s:fmt_ital = ' gui=NONE".s:i.      " cterm=NONE".s:i.      " term=NONE".s:i     ."'"
exe "let s:fmt_stnd = ' gui=NONE".s:s.      " cterm=NONE".s:s.      " term=NONE".s:s     ."'"
exe "let s:fmt_revr = ' gui=NONE".s:r.      " cterm=NONE".s:r.      " term=NONE".s:r     ."'"
exe "let s:fmt_revb = ' gui=NONE".s:r.s:b.  " cterm=NONE".s:r.s:b.  " term=NONE".s:r.s:b ."'"

"}}}


" Vim Highlighting:"{{{
" ----------------------------------------------------------------------------
exe "hi! Normal"        .s:fg_fg          .s:bg_none        .s:fmt_none
exe "hi! EndOfBuffer"   .s:fg_bg          .s:bg_none        .s:fmt_none
exe "hi! ColorColumn"   .s:fg_none        .s:bg_guide       .s:fmt_none
" Conceal, Cursor, CursorIM
exe "hi! CursorColumn"  .s:fg_fg          .s:bg_guide       .s:fmt_none
exe "hi! CursorLine"    .s:fg_blue        .s:bg_guide       .s:fmt_bold
exe "hi! CursorLineNr"  .s:fg_blue        .s:bg_guide       .s:fmt_bold
exe "hi! LineNr"        .s:fg_comment     .s:bg_none        .s:fmt_none

exe "hi! Directory"     .s:fg_fg          .s:bg_none        .s:fmt_none
exe "hi! DiffAdd"       .s:fg_green       .s:bg_fg          .s:fmt_none
exe "hi! DiffChange"    .s:fg_blue        .s:bg_fg          .s:fmt_none
exe "hi! DiffText"      .s:fg_fg          .s:bg_fg          .s:fmt_none
exe "hi! ErrorMsg"      .s:fg_red         .s:bg_none        .s:fmt_none
exe "hi! VertSplit"     .s:fg_bg          .s:bg_guide       .s:fmt_none
exe "hi! Folded"        .s:fg_fg          .s:bg_fg          .s:fmt_none
exe "hi! FoldColumn"    .s:fg_none        .s:bg_fg          .s:fmt_none
exe "hi! SignColumn"    .s:fg_none        .s:bg_bg          .s:fmt_none
"   Incsearch"

exe "hi! MatchParen"    .s:fg_bg          .s:bg_yellow      .s:fmt_none
exe "hi! ModeMsg"       .s:fg_green       .s:bg_none        .s:fmt_none
exe "hi! MoreMsg"       .s:fg_green       .s:bg_none        .s:fmt_none
exe "hi! NonText"       .s:fg_comment     .s:bg_none        .s:fmt_none
exe "hi! Pmenu"         .s:fg_fg          .s:bg_guide       .s:fmt_none
exe "hi! PmenuSel"      .s:fg_fg          .s:bg_guide       .s:fmt_revr
"   PmenuSbar"
"   PmenuThumb"
exe "hi! Question"      .s:fg_green       .s:bg_none        .s:fmt_none
exe "hi! Search"        .s:fg_bg          .s:bg_magenta     .s:fmt_none
exe "hi! SpecialKey"    .s:fg_magenta     .s:bg_none        .s:fmt_none
exe "hi! SpellCap"      .s:fg_red         .s:bg_none        .s:fmt_none
exe "hi! SpellLocal"    .s:fg_red         .s:bg_none        .s:fmt_none
exe "hi! SpellBad"      .s:fg_red         .s:bg_none        .s:fmt_none
exe "hi! SpellRare"     .s:fg_red         .s:bg_none        .s:fmt_none
exe "hi! StatusLine"    .s:fg_green       .s:bg_guide       .s:fmt_none
exe "hi! StatusLineNC"  .s:fg_blue        .s:bg_guide       .s:fmt_none
exe "hi! WildMenu"      .s:fg_bg          .s:bg_red         .s:fmt_none
exe "hi! TabLine"       .s:fg_fg          .s:bg_fg          .s:fmt_revr
"   TabLineFill"
"   TabLineSel"
exe "hi! Title"         .s:fg_magenta     .s:bg_none        .s:fmt_none
exe "hi! Visual"        .s:fg_bg          .s:bg_blue        .s:fmt_none
"   VisualNos"
exe "hi! WarningMsg"    .s:fg_yellow      .s:bg_none        .s:fmt_none

" ALE"
exe "hi! AleText"       .s:fg_red         .s:bg_none        .s:fmt_bold
exe "hi! AleWarning"    .s:fg_red         .s:bg_none        .s:fmt_bold
exe "hi! AleLine"       .s:fg_red         .s:bg_none        .s:fmt_bold

hi link ALEErrorSign    AleText
hi link ALEWarningSign  AleText
hi link ALEErrorLine    AleLine
hi link ALEInfoLine     AleLine
"}}}

" Generic Syntax Highlighting:"{{{
" ----------------------------------------------------------------------------
exe "hi! Comment"             .s:fg_comment     .s:bg_none        .s:fmt_none
exe "hi! Constant"            .s:fg_cyan        .s:bg_none        .s:fmt_none
exe "hi! String"              .s:fg_yellow      .s:bg_none        .s:fmt_none
exe "hi! Number"              .s:fg_red         .s:bg_none        .s:fmt_none
exe "hi! Float"	              .s:fg_red         .s:bg_none        .s:fmt_none
exe "hi! Boolean"             .s:fg_red         .s:bg_none        .s:fmt_none
exe "hi! Character"           .s:fg_fg          .s:bg_none        .s:fmt_none
" any variable name"
exe "hi! Identifier"          .s:fg_fg          .s:bg_none        .s:fmt_none
exe "hi! Function"            .s:fg_blue        .s:bg_none        .s:fmt_none
exe "hi! Statement"           .s:fg_cyan        .s:bg_none        .s:fmt_none
" if, then, else, endif, switch, etc"
exe "hi! Conditional"         .s:fg_cyan        .s:bg_none        .s:fmt_none
" for, do, while, etc"
exe "hi! Repeat"              .s:fg_cyan        .s:bg_none        .s:fmt_none
" case, default, etc"
exe "hi! Label"               .s:fg_cyan        .s:bg_none        .s:fmt_none
" sizeof, *, +, etc"
exe "hi! Operator"            .s:fg_cyan        .s:bg_none        .s:fmt_none
" try, catch, throw"
exe "hi! Exception"           .s:fg_cyan        .s:bg_none        .s:fmt_none
" any other keyword"
exe "hi! Keyword"             .s:fg_cyan        .s:bg_none        .s:fmt_none
" int, long, char, etc"
exe "hi! Type"                .s:fg_magenta     .s:bg_none        .s:fmt_none
exe "hi! Typedef"             .s:fg_magenta     .s:bg_none        .s:fmt_none
" struct, union, enum, etc"
exe "hi! Structure"           .s:fg_red         .s:bg_none        .s:fmt_none
" static, register, volatile, etc"
exe "hi! StorageClass"        .s:fg_red         .s:bg_none        .s:fmt_none
" any special symbol"
exe "hi! Special"             .s:fg_magenta     .s:bg_none        .s:fmt_none
exe "hi! Underlined"          .s:fg_blue        .s:bg_none        .s:fmt_undr
exe "hi! Ignore"              .s:fg_none        .s:bg_none        .s:fmt_none
exe "hi! Error"               .s:fg_fg          .s:bg_red         .s:fmt_none
exe "hi! Todo"                .s:fg_comment     .s:bg_none        .s:fmt_none

" Quickfix window highlighting
exe "hi! qfLineNr"            .s:fg_magenta     .s:bg_none        .s:fmt_none
"   qfFileName"
"   qfLineNr"
"   qfError"

exe "hi! Conceal"             .s:fg_comment     .s:bg_none        .s:fmt_none
exe "hi! CursorLineConceal"   .s:fg_comment     .s:bg_guide       .s:fmt_none


" Terminal in NVIM
" ---------
if has("nvim")
  let g:terminal_color_0            = s:palette.comment[s:style]
  let g:terminal_color_1            = s:palette.red[s:style]
  let g:terminal_color_2            = s:palette.green[s:style]
  let g:terminal_color_3            = s:palette.yellow[s:style]
  let g:terminal_color_4            = s:palette.blue[s:style]
  let g:terminal_color_5            = s:palette.magenta[s:style]
  let g:terminal_color_6            = s:palette.cyan[s:style]
  let g:terminal_color_7            = s:palette.fg[s:style]
  let g:terminal_color_8            = s:palette.comment[s:style]
  let g:terminal_color_9            = s:palette.red[s:style]
  let g:terminal_color_10           = s:palette.green[s:style]
  let g:terminal_color_11           = s:palette.yellow[s:style]
  let g:terminal_color_12           = s:palette.blue[s:style]
  let g:terminal_color_13           = s:palette.magenta[s:style]
  let g:terminal_color_14           = s:palette.cyan[s:style]
  let g:terminal_color_15           = s:palette.fg[s:style]
  let g:terminal_color_background   = s:palette.bg[s:style]
  let g:terminal_color_foreground   = s:palette.fg[s:style]
endif


" NerdTree
" ---------
exe "hi! NERDTreeOpenable"            .s:fg_blue        .s:bg_none        .s:fmt_none
exe "hi! NERDTreeClosable"            .s:fg_magenta     .s:bg_none        .s:fmt_none
" exe "hi! NERDTreeBookmarksHeader"   .s:fg_pink        .s:bg_none        .s:fmt_none
" exe "hi! NERDTreeBookmarksLeader"   .s:fg_bg          .s:bg_none        .s:fmt_none
" exe "hi! NERDTreeBookmarkName"      .s:fg_magenta     .s:bg_none        .s:fmt_none
exe "hi! NERDTreeCWD"                 .s:fg_red         .s:bg_none        .s:fmt_none
exe "hi! NERDTreeUp"                  .s:fg_fg          .s:bg_none        .s:fmt_none
exe "hi! NERDTreeDir"                 .s:fg_green       .s:bg_none        .s:fmt_none
exe "hi! NERDTreeFile"                .s:fg_yellow      .s:bg_none        .s:fmt_none
exe "hi! NERDTreeDirSlash"            .s:fg_yellow      .s:bg_none        .s:fmt_none


" GitGutter
" ---------
exe "hi! GitGutterAdd"                .s:fg_cyan       .s:bg_none         .s:fmt_none
exe "hi! GitGutterChange"             .s:fg_cyan       .s:bg_none         .s:fmt_none
exe "hi! GitGutterDelete"             .s:fg_magenta    .s:bg_none         .s:fmt_none
exe "hi! GitGutterChangeDelete"       .s:fg_magenta    .s:bg_none         .s:fmt_none

"}}}

" Language Specific HighLighting:"{{{
" ---------------------------------------------------------------------------
" CSS"
exe "hi! cssAttrComma"            .s:fg_magenta     .s:bg_none        .s:fmt_none
exe "hi! cssAttributeSelector"    .s:fg_red         .s:bg_none        .s:fmt_none
exe "hi! cssBraces"               .s:fg_magenta     .s:bg_none        .s:fmt_none
exe "hi! cssClassName"            .s:fg_yellow      .s:bg_none        .s:fmt_none
exe "hi! cssClassNameDot"         .s:fg_yellow      .s:bg_none        .s:fmt_none
exe "hi! cssDefinition"           .s:fg_red         .s:bg_none        .s:fmt_none
exe "hi! cssFontAttr"             .s:fg_red         .s:bg_none        .s:fmt_none
exe "hi! cssFontDescriptor"       .s:fg_red         .s:bg_none        .s:fmt_none
exe "hi! cssFunctionName"         .s:fg_blue        .s:bg_none        .s:fmt_none
exe "hi! cssIdentifier"           .s:fg_red         .s:bg_none        .s:fmt_none
exe "hi! cssImportant"            .s:fg_yellow      .s:bg_none        .s:fmt_none
exe "hi! cssInclude"              .s:fg_fg          .s:bg_none        .s:fmt_none
exe "hi! cssIncludeKeyword"       .s:fg_magenta     .s:bg_none        .s:fmt_none
exe "hi! cssMediaType"            .s:fg_yellow      .s:bg_none        .s:fmt_none
exe "hi! cssProp"                 .s:fg_fg          .s:bg_none        .s:fmt_none
exe "hi! cssPseudoClassId"        .s:fg_yellow      .s:bg_none        .s:fmt_none
exe "hi! cssSelectorOp"           .s:fg_yellow      .s:bg_none        .s:fmt_none
exe "hi! cssSelectorOp2"          .s:fg_yellow      .s:bg_none        .s:fmt_none
exe "hi! cssTagName"              .s:fg_yellow      .s:bg_none        .s:fmt_none

" TYPESCRIPT"
exe "hi! typescriptType"           .s:fg_yellow      .s:bg_none        .s:fmt_none
exe "hi! typescriptBraces"         .s:fg_red         .s:bg_none        .s:fmt_none
exe "hi! typescriptParens"         .s:fg_red         .s:bg_none        .s:fmt_none
exe "hi! typescriptOpSymbols"      .s:fg_blue        .s:bg_none        .s:fmt_none
exe "hi! typescriptReserved"       .s:fg_blue        .s:bg_none        .s:fmt_none
exe "hi! typescriptDecorators"     .s:fg_cyan        .s:bg_none        .s:fmt_none
exe "hi! typescriptEndColons"      .s:fg_cyan        .s:bg_none        .s:fmt_none
exe "hi! typescriptStorageClass"   .s:fg_magenta     .s:bg_none        .s:fmt_none
exe "hi! typescriptStringD"        .s:fg_green       .s:bg_none        .s:fmt_none
exe "hi! typescriptHtmlEvents"     .s:fg_blue        .s:bg_none        .s:fmt_none
exe "hi! typescriptBoolean"        .s:fg_red         .s:bg_none        .s:fmt_none
exe "hi! typescriptConditional"    .s:fg_yellow      .s:bg_none        .s:fmt_none

" VIM"
exe "hi! vimLineComment"           .s:fg_comment     .s:bg_none        .s:fmt_none
exe "hi! vimCommentTitle"          .s:fg_comment     .s:bg_none        .s:fmt_bold

"}}}

" Diff Syntax Highlighting:"{{{
" ----------------------------------------------------------------------------
" Diff
"   diffOldFile
"   diffNewFile
"   diffFile
"   diffOnly
"   diffIdentical
"   diffDiffer
"   diffBDiffer
"   diffIsA
"   diffNoEOL
"   diffCommon
hi! link diffRemoved Constant
"   diffChanged
hi! link diffAdded String
"   diffLine
"   diffSubname
"   diffComment

"}}}
"
" This is needed for some reason: {{{

let &background = s:style

" }}}
