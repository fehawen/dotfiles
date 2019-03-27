" Initialisation:"{{{
" ----------------------------------------------------------------------------
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "flamingo"

"}}}

" Palettes:"{{{
" ----------------------------------------------------------------------------

let s:palette = {}

let s:palette.fg          = {'default': "#F4EFE7"}
let s:palette.bg          = {'default': "#274C59"}
let s:palette.guide       = {'default': "#315967"}
let s:palette.comment     = {'default': "#406674"}
let s:palette.red         = {'default': "#F094AD"}
let s:palette.green       = {'default': "#6DB58D"}
let s:palette.yellow      = {'default': "#FFFEAC"}
let s:palette.blue        = {'default': "#5392CC"}
let s:palette.magenta     = {'default': "#F1A6FA"}
let s:palette.cyan        = {'default': "#A5E8FC"}

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

exe "let s:fmt_none = ' gui=NONE".          " cterm=NONE".          " term=NONE"        ."'"
exe "let s:fmt_bold = ' gui=NONE".s:b.      " cterm=NONE".s:b.      " term=NONE".s:b    ."'"
exe "let s:fmt_bldi = ' gui=NONE".s:b.      " cterm=NONE".s:b.      " term=NONE".s:b    ."'"
exe "let s:fmt_undr = ' gui=NONE".s:u.      " cterm=NONE".s:u.      " term=NONE".s:u    ."'"
exe "let s:fmt_undb = ' gui=NONE".s:u.s:b.  " cterm=NONE".s:u.s:b.  " term=NONE".s:u.s:b."'"
exe "let s:fmt_undi = ' gui=NONE".s:u.      " cterm=NONE".s:u.      " term=NONE".s:u    ."'"
exe "let s:fmt_curl = ' gui=NONE".s:c.      " cterm=NONE".s:c.      " term=NONE".s:c    ."'"
exe "let s:fmt_ital = ' gui=NONE".s:i.      " cterm=NONE".s:i.      " term=NONE".s:i    ."'"
exe "let s:fmt_stnd = ' gui=NONE".s:s.      " cterm=NONE".s:s.      " term=NONE".s:s    ."'"
exe "let s:fmt_revr = ' gui=NONE".s:r.      " cterm=NONE".s:r.      " term=NONE".s:r    ."'"
exe "let s:fmt_revb = ' gui=NONE".s:r.s:b.  " cterm=NONE".s:r.s:b.  " term=NONE".s:r.s:b."'"

"}}}


" Vim Highlighting:"{{{
" ----------------------------------------------------------------------------
exe "hi! Normal"        .s:fg_fg          .s:bg_bg          .s:fmt_none
exe "hi! EndOfBuffer"   .s:fg_bg          .s:bg_bg          .s:fmt_none
exe "hi! ColorColumn"   .s:fg_none        .s:bg_comment     .s:fmt_none
" Conceal, Cursor, CursorIM
exe "hi! CursorColumn"  .s:fg_none        .s:bg_comment     .s:fmt_none
exe "hi! CursorLine"    .s:fg_none        .s:bg_guide       .s:fmt_none
exe "hi! CursorLineNr"  .s:fg_magenta     .s:bg_comment     .s:fmt_none
exe "hi! LineNr"        .s:fg_comment     .s:bg_none        .s:fmt_none

exe "hi! Directory"     .s:fg_fg          .s:bg_none        .s:fmt_none
exe "hi! DiffAdd"       .s:fg_green       .s:bg_fg          .s:fmt_none
exe "hi! DiffChange"    .s:fg_blue        .s:bg_fg          .s:fmt_none
exe "hi! DiffText"      .s:fg_fg          .s:bg_fg          .s:fmt_none
exe "hi! ErrorMsg"      .s:fg_red         .s:bg_bg          .s:fmt_none
exe "hi! VertSplit"     .s:fg_bg          .s:bg_guide       .s:fmt_none
exe "hi! Folded"        .s:fg_fg          .s:bg_fg          .s:fmt_none
exe "hi! FoldColumn"    .s:fg_none        .s:bg_fg          .s:fmt_none
exe "hi! SignColumn"    .s:fg_none        .s:bg_fg          .s:fmt_none
"   Incsearch"

exe "hi! MatchParen"    .s:fg_bg          .s:bg_green       .s:fmt_undr
exe "hi! ModeMsg"       .s:fg_green       .s:bg_none        .s:fmt_none
exe "hi! MoreMsg"       .s:fg_green       .s:bg_none        .s:fmt_none
exe "hi! NonText"       .s:fg_bg          .s:bg_none        .s:fmt_none
exe "hi! Pmenu"         .s:fg_fg          .s:bg_comment     .s:fmt_none
exe "hi! PmenuSel"      .s:fg_fg          .s:bg_comment     .s:fmt_revr
"   PmenuSbar"
"   PmenuThumb"
exe "hi! Question"      .s:fg_green       .s:bg_none        .s:fmt_none
exe "hi! Search"        .s:fg_bg          .s:bg_cyan        .s:fmt_none
exe "hi! SpecialKey"    .s:fg_comment     .s:bg_none        .s:fmt_none
exe "hi! SpellCap"      .s:fg_blue        .s:bg_none        .s:fmt_undr
exe "hi! SpellLocal"    .s:fg_magenta     .s:bg_none        .s:fmt_undr
exe "hi! SpellBad"      .s:fg_red         .s:bg_none        .s:fmt_undr
exe "hi! SpellRare"     .s:fg_cyan        .s:bg_none        .s:fmt_undr
exe "hi! StatusLine"    .s:fg_fg          .s:bg_guide       .s:fmt_none
exe "hi! StatusLineNC"  .s:fg_bg          .s:bg_guide       .s:fmt_none
exe "hi! WildMenu"      .s:fg_bg          .s:bg_red         .s:fmt_none
exe "hi! TabLine"       .s:fg_fg          .s:bg_fg          .s:fmt_revr
"   TabLineFill"
"   TabLineSel"
exe "hi! Title"         .s:fg_magenta     .s:bg_none        .s:fmt_none
exe "hi! Visual"        .s:fg_none        .s:bg_comment     .s:fmt_none
"   VisualNos"
exe "hi! WarningMsg"    .s:fg_yellow      .s:bg_bg          .s:fmt_none
"...ALE"
exe "hi! AleText"       .s:fg_red         .s:bg_bg          .s:fmt_none
exe "hi! AleWarning"    .s:fg_red         .s:bg_bg          .s:fmt_none
exe "hi! AleLine"       .s:fg_red         .s:bg_bg          .s:fmt_none

hi link ALEErrorSign    AleText
hi link ALEWarningSign  AleText
hi link ALEErrorLine    AleLine
hi link ALEInfoLine     AleLine
"}}}

" Generic Syntax Highlighting:"{{{
" ----------------------------------------------------------------------------
exe "hi! Comment"             .s:fg_comment     .s:bg_none        .s:fmt_none

exe "hi! Constant"            .s:fg_cyan        .s:bg_none        .s:fmt_none
exe "hi! String"              .s:fg_green       .s:bg_none        .s:fmt_none
exe "hi! Number"              .s:fg_red         .s:bg_none        .s:fmt_none
exe "hi! Boolean"             .s:fg_red         .s:bg_none        .s:fmt_none
"   Character"
"   Float"

exe "hi! Identifier"          .s:fg_blue        .s:bg_none        .s:fmt_none
exe "hi! Function"            .s:fg_cyan        .s:bg_none        .s:fmt_none

exe "hi! Statement"           .s:fg_magenta     .s:bg_none        .s:fmt_none
exe "hi! Conditional"         .s:fg_cyan        .s:bg_none        .s:fmt_none
"   Repeat"
"   Label"
exe "hi! Operator"            .s:fg_yellow      .s:bg_none        .s:fmt_none
"   Keyword"
"   Exception"

exe "hi! PreProc"             .s:fg_magenta     .s:bg_none        .s:fmt_none
"   Include"
"   Define"
"   Macro"
"   PreCondit"

exe "hi! Type"                .s:fg_cyan        .s:bg_none        .s:fmt_none
"   StorageClass"
exe "hi! Structure"           .s:fg_magenta     .s:bg_none        .s:fmt_none
" exe "hi! Typedef"             .s:fg_yellow      .s:bg_none        .s:fmt_none

exe "hi! Special"             .s:fg_magenta     .s:bg_none        .s:fmt_none
exe "hi! Tag"                 .s:fg_yellow      .s:bg_none        .s:fmt_none
"   SpecialChar"
"   Tag"
"   Delimiter"
"   SpecialComment"
"   Debug"
"
exe "hi! Underlined"          .s:fg_blue        .s:bg_none        .s:fmt_undr

exe "hi! Ignore"              .s:fg_none        .s:bg_none        .s:fmt_none

exe "hi! Error"               .s:fg_fg          .s:bg_red         .s:fmt_none

exe "hi! Todo"                .s:fg_red         .s:bg_none        .s:fmt_none

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
  let g:terminal_color_0            =  s:palette.comment[s:style]
  let g:terminal_color_1            =  s:palette.red[s:style]
  let g:terminal_color_2            =  s:palette.green[s:style]
  let g:terminal_color_3            =  s:palette.yellow[s:style]
  let g:terminal_color_4            =  s:palette.blue[s:style]
  let g:terminal_color_5            =  s:palette.magenta[s:style]
  let g:terminal_color_6            =  s:palette.cyan[s:style]
  let g:terminal_color_7            =  s:palette.fg[s:style]
  let g:terminal_color_8            =  s:palette.comment[s:style]
  let g:terminal_color_9            =  s:palette.red[s:style]
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
exe "hi! NERDTreeOpenable"          .s:fg_fg     .s:bg_none        .s:fmt_none
exe "hi! NERDTreeClosable"          .s:fg_magenta      .s:bg_none        .s:fmt_none
" exe "hi! NERDTreeBookmarksHeader"   .s:fg_pink        .s:bg_none        .s:fmt_none
" exe "hi! NERDTreeBookmarksLeader"   .s:fg_bg          .s:bg_none        .s:fmt_none
" exe "hi! NERDTreeBookmarkName"      .s:fg_magenta     .s:bg_none        .s:fmt_none
" exe "hi! NERDTreeCWD"               .s:fg_pink        .s:bg_none        .s:fmt_none
exe "hi! NERDTreeUp"                .s:fg_fg    .s:bg_none        .s:fmt_none
exe "hi! NERDTreeDir"               .s:fg_fg    .s:bg_none        .s:fmt_none
exe "hi! NERDTreeFile"              .s:fg_fg    .s:bg_none        .s:fmt_none
exe "hi! NERDTreeDirSlash"          .s:fg_guide      .s:bg_none        .s:fmt_none


" GitGutter
" ---------
exe "hi! GitGutterAdd"          .s:fg_green     .s:bg_none        .s:fmt_none
exe "hi! GitGutterChange"       .s:fg_blue        .s:bg_none        .s:fmt_none
exe "hi! GitGutterDelete"       .s:fg_red     .s:bg_none        .s:fmt_none
exe "hi! GitGutterChangeDelete" .s:fg_blue   .s:bg_none        .s:fmt_none

"}}}

" TODO: Language Specific Highlighting
" https://github.com/joshdick/onedark.vim/blob/master/colors/onedark.vim

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