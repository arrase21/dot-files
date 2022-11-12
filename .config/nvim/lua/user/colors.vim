highlight clear

function s:highlight(group, bg, fg, style)
  let gui = a:style == '' ? '' : 'gui=' . a:style
  let fg = a:fg == '' ? '' : 'guifg=' . a:fg
  let bg = a:bg == '' ? '' : 'guibg=' . a:bg
  exec 'hi ' . a:group . ' ' . bg . ' ' . fg  . ' ' . gui
endfunction

let s:Color17 = '#200a0e'
let s:Color11 = '#BB77FF'
let s:Color20 = '#777777'
let s:Color3 = '#666666'
let s:Color0 = ''
let s:Color7 = '#FF7F00'
let s:Color2 = '#FF7EFF'
let s:Color8 = '#FF8800'
let s:Color21 = '#ffffff'
let s:Color15 = '#8f93a2'
let s:Color9 = '#F78C6C'
let s:Color10 = '#FF5370'
let s:Color18 = '#232638'
let s:Color5 = '#7FFF00'
let s:Color12 = '#FFFF00'
let s:Color1 = '#FFFF7E'
let s:Color4 = '#7EFFFF'
let s:Color13 = '#00ffff'
let s:Color6 = '#FF3B3B'
let s:Color14 = '#000000'
let s:Color16 = '#10130b'
let s:Color19 = '#1d1f28'

call s:highlight('Constant', '', s:Color0, 'bold')
call s:highlight('Operator', '', s:Color1, '')
call s:highlight('String', '', s:Color2, '')
call s:highlight('Comment', '', s:Color3, '')
call s:highlight('Identifier', '', s:Color4, '')
call s:highlight('Function', '', s:Color5, 'italic')
call s:highlight('Conditional', '', s:Color6, '')
call s:highlight('Repeat', '', s:Color6, '')
call s:highlight('Conditional', '', s:Color7, '')
call s:highlight('Type', '', s:Color8, '')
call s:highlight('TSCharacter', '', s:Color9, '')
call s:highlight('Error', '', s:Color10, '')
call s:highlight('Keyword', '', s:Color11, '')
call s:highlight('Number', '', s:Color12, '')
call s:highlight('StatusLine', s:Color13, s:Color14, '')
call s:highlight('WildMenu', s:Color14, s:Color15, '')
call s:highlight('Pmenu', s:Color14, s:Color15, '')
call s:highlight('PmenuSel', s:Color15, '', '')
call s:highlight('PmenuThumb', s:Color14, s:Color15, '')
call s:highlight('DiffAdd', s:Color16, '', '')
call s:highlight('DiffDelete', s:Color17, '', '')
call s:highlight('Normal', s:Color14, s:Color15, '')
call s:highlight('Visual', s:Color18, '', '')
call s:highlight('CursorLine', s:Color18, '', '')
call s:highlight('ColorColumn', s:Color18, '', '')
call s:highlight('SignColumn', s:Color14, '', '')
call s:highlight('LineNr', '', s:Color19, '')
call s:highlight('TabLine', s:Color14, s:Color20, '')
call s:highlight('TabLineSel', s:Color21, '', '')
call s:highlight('TabLineFill', s:Color14, s:Color20, '')
call s:highlight('TSPunctDelimiter', '', s:Color15, '')

highlight! link Macro Function
highlight! link CursorLineNr Identifier
highlight! link Repeat Conditional
highlight! link TelescopeNormal Normal
highlight! link TSType Type
highlight! link TSComment Comment
highlight! link TSConditional Conditional
highlight! link TSRepeat Repeat
highlight! link TSNamespace TSType
highlight! link TSTagDelimiter Type
highlight! link NonText Comment
highlight! link TSTag MyTag
highlight! link TSPunctSpecial TSPunctDelimiter
highlight! link TSConstant Constant
highlight! link TSKeyword Keyword
highlight! link TSString String
highlight! link TSPunctBracket MyTag
highlight! link TSConstBuiltin TSVariableBuiltin
highlight! link Folded Comment
highlight! link TSParameterReference TSParameter
highlight! link TSNumber Number
highlight! link TSFloat Number
highlight! link Operator Keyword
highlight! link TSField Constant
highlight! link Conditional Operator
highlight! link TSOperator Operator
highlight! link TSParameter Constant
highlight! link TSFuncMacro Macro
highlight! link TSLabel Type
highlight! link TSProperty TSField
highlight! link Whitespace Comment
highlight! link TSFunction Function
