" Vim color file
" Description: Low-colour theme with light and dark variants
" Maintainer: Chris Rawnsley <chris@puny.agency>
" Version: 0.8.0
" Source: https://github.com/casr/vim-colors-chromatine
" Modified: 2025 Mar 10

hi clear
if exists('syntax_on')
	syntax reset
endif

let g:colors_name = 'chromatine'

" Palette {{{

hi chromatineAdded NONE
hi chromatineBold NONE term=bold cterm=bold gui=bold
hi chromatineComment NONE
hi chromatineCursor NONE term=reverse cterm=reverse
hi chromatineCursorLine NONE
hi chromatineErrorMsg NONE
hi chromatineLine NONE term=reverse cterm=reverse
hi chromatineLineNC NONE
hi chromatineMargin NONE
hi chromatineNone NONE
hi chromatineRemoved NONE
hi chromatineSearch NONE
hi chromatineUnderlined NONE term=underline cterm=underline gui=underline
hi chromatineVisual NONE term=reverse cterm=reverse
hi chromatineVisualNOS NONE term=reverse cterm=reverse
hi chromatineWinSeparator NONE

" }}}

" Vim {{{

hi! link ColorColumn chromatineLineNC
hi! link Conceal chromatineNone
hi! link CurSearch chromatineSearch
hi! link Cursor chromatineCursor
hi! link CursorColumn chromatineNone
hi! link CursorLine chromatineCursorLine
hi! link CursorLineFold chromatineCursorLine
hi! link CursorLineNr chromatineCursorLine
hi! link CursorLineSign chromatineCursorLine
hi! link DiagnosticError chromatineErrorMsg
hi! link DiagnosticHint chromatineLineNC
hi! link DiagnosticInfo chromatineNone
hi! link DiagnosticOk chromatineNone
hi! link DiagnosticWarn chromatineVisual
hi! link DiffAdd chromatineAdded
hi! link DiffChange chromatineNone
hi! link DiffDelete chromatineRemoved
hi! link DiffText chromatineAdded
hi! link Directory chromatineNone
hi! link ErrorMsg chromatineErrorMsg
hi! link FoldColumn chromatineMargin
hi! link Folded chromatineMargin
hi! link IncSearch chromatineVisual
hi! link LineNr chromatineMargin
hi! link LspReferenceRead chromatineLineNC
hi! link LspReferenceText chromatineLineNC
hi! link LspReferenceWrite chromatineLineNC
hi! link MatchParen chromatineSearch
hi! link ModeMsg chromatineNone
hi! link MoreMsg chromatineNone
hi! link NonText chromatineMargin
hi! link Pmenu chromatineLineNC
hi! link PmenuSbar chromatineLine
hi! link PmenuSel chromatineVisual
hi! link PmenuThumb chromatineVisual
hi! link Question chromatineNone
hi! link QuickFixLine chromatineVisual
hi! link Search chromatineSearch
hi! link SignColumn chromatineMargin
hi! link SpecialKey chromatineMargin
hi! link SpellBad chromatineUnderlined
hi! link SpellCap chromatineUnderlined
hi! link SpellLocal chromatineUnderlined
hi! link SpellRare chromatineNone
hi! link StatusLine chromatineLine
hi! link StatusLineNC chromatineLineNC
hi! link StatusLineTerm chromatineLine
hi! link StatusLineTermNC chromatineLineNC
hi! link TabLineFill chromatineLineNC
hi! link TabLineSel chromatineLine
hi! link Tabline chromatineLineNC
hi! link Terminal Normal
hi! link Title chromatineBold
hi! link VertSplit chromatineWinSeparator
hi! link Visual chromatineVisual
hi! link VisualNOS chromatineVisual
hi! link WarningMsg chromatineVisual
hi! link Whitespace chromatineMargin
hi! link WildMenu chromatineVisual
hi! link WinSeparator chromatineWinSeparator
hi! link lCursor chromatineCursor

" }}}

" Syntax {{{

hi! link Added chromatineAdded
hi! link Boolean chromatineNone
hi! link Changed chromatineNone
hi! link Character chromatineNone
hi! link Comment chromatineComment
hi! link Conditional chromatineNone
hi! link Constant chromatineNone
hi! link Debug chromatineNone
hi! link Define chromatineNone
hi! link Delimiter chromatineNone
hi! link Error chromatineNone
hi! link Exception chromatineNone
hi! link Float chromatineNone
hi! link Function chromatineNone
hi! link Identifier chromatineNone
hi! link Ignore chromatineNone
hi! link Include chromatineNone
hi! link Keyword chromatineNone
hi! link Label chromatineNone
hi! link Macro chromatineNone
hi! link Number chromatineNone
hi! link Operator chromatineNone
hi! link PreCondit chromatineNone
hi! link PreProc chromatineNone
hi! link Removed chromatineRemoved
hi! link Repeat chromatineNone
hi! link Special chromatineNone
hi! link SpecialChar chromatineNone
hi! link SpecialComment chromatineNone
hi! link Statement chromatineNone
hi! link StorageClass chromatineNone
hi! link String chromatineNone
hi! link Structure chromatineNone
hi! link Tag chromatineNone
hi! link Todo chromatineNone
hi! link Type chromatineNone
hi! link Typedef chromatineNone
hi! link Underlined chromatineUnderlined

" ft:css {{{
hi! link cssMediaComma chromatineNone
" }}}

" ft:diff {{{
hi! link diffAdded chromatineAdded
hi! link diffChanged chromatineNone
hi! link diffRemoved chromatineRemoved
hi! link diffSubname chromatineComment
hi! link diffLine chromatineComment
hi! link diffFile chromatineComment
hi! link diffOldFile chromatineComment
hi! link diffNewFile chromatineComment
hi! link diffIndexLine chromatineComment
" }}}

" ft:help {{{
hi! link helpHyperTextJump chromatineHighlight
" }}}

" ft:html {{{
hi! link htmlH1 chromatineNone
hi! link htmlTitle chromatineNone
" }}}

" ft:typescript {{{
hi! link typescriptSymbols chromatineNone
hi! link typescriptParens chromatineNone
" }}}

" ft:vim {{{
hi! link vimEmbedError chromatineNone
hi! link vimCommentTitle chromatineComment
hi! link vimUserFunc chromatineNone
" }}}

" }}}

if !(has('gui_running') || &t_Co >= 256) | finish | endif

" Helper functions {{{
command! -nargs=+ Hi :call s:hi(<f-args>)

function! s:c(xc)
  if a:xc <# 16
    echoerr 'colors 0-15 are terminal specific and cannot be converted'
    return
  endif
  if a:xc <# 232
    let l:clamp = float2nr(a:xc) - 16
    let l:r = float2nr(l:clamp / 36)
    let l:g = float2nr(fmod(l:clamp / 6, 6))
    let l:b = float2nr(fmod(l:clamp, 6))
    return printf('#%02x%02x%02x',
          \ l:r ? l:r * 40 + 55 : 0,
          \ l:g ? l:g * 40 + 55 : 0,
          \ l:b ? l:b * 40 + 55 : 0)
  endif
  if a:xc <# 256
    let l:clamp = a:xc - 232
    let l:level = l:clamp * 10 + 8
    return printf('#%02x%02x%02x', l:level, l:level, l:level)
  endif
  echoerr 'not a valid XTerm color'
endfunction

let s:color_map = {'ctermbg': 'guibg', 'ctermfg': 'guifg'}
function! s:hi(...)
  let l:group = a:1
  let l:rest = []
  let l:i = 1
  if a:0 > 1
    for l:i in range(1, a:0 - 1)
      call add(l:rest, a:000[l:i])
      let l:kwarg = split(a:000[l:i], '=')
      if len(l:kwarg) != 2
        continue
      endif
      let l:key = l:kwarg[0]
      let l:v = l:kwarg[1]
      if l:v ==# 'NONE' || l:v ==# 'bg' || l:v ==# 'fg'
        continue
      endif
      if has_key(s:color_map, l:key)
        let l:mapped_key = s:color_map[l:key]
        call add(l:rest, l:mapped_key . '=' . s:c(str2nr(l:v)))
      endif
    endfor
  endif
  execute 'hi ' . l:group . ' ' . join(l:rest, ' ')
endfunction
" }}}

" Colours {{{

if &background ==# 'light'
  Hi Normal NONE ctermbg=231 ctermfg=235

  Hi chromatineAdded NONE ctermbg=195 ctermfg=23
  Hi chromatineComment NONE ctermfg=239
  Hi chromatineCursor NONE ctermbg=86
  Hi chromatineCursorLine NONE ctermbg=255
  Hi chromatineErrorMsg NONE ctermbg=224
  Hi chromatineLine NONE ctermbg=255 ctermfg=20
  Hi chromatineLineNC NONE ctermbg=253
  Hi chromatineMargin NONE ctermfg=246
  Hi chromatineRemoved NONE ctermbg=225 ctermfg=90
  Hi chromatineSearch NONE ctermbg=222 ctermfg=52
  Hi chromatineVisual NONE ctermbg=117
  Hi chromatineWinSeparator NONE ctermfg=253
else
  Hi Normal NONE ctermbg=237 ctermfg=254

  Hi chromatineAdded NONE ctermbg=17 ctermfg=147
  Hi chromatineComment NONE ctermfg=250
  Hi chromatineCursor NONE ctermbg=23
  Hi chromatineCursorLine NONE ctermbg=236
  Hi chromatineErrorMsg NONE ctermbg=52
  Hi chromatineLine NONE ctermbg=235 ctermfg=153
  Hi chromatineLineNC NONE ctermbg=239
  Hi chromatineMargin NONE ctermfg=245
  Hi chromatineRemoved NONE ctermbg=53 ctermfg=183
  Hi chromatineSearch NONE ctermbg=58 ctermfg=229
  Hi chromatineVisual NONE ctermbg=233
  Hi chromatineWinSeparator NONE ctermfg=59
endif

hi chromatineVisualNOS NONE ctermbg=fg ctermfg=bg

let s:term_theme = &background ==# 'light'
      \ ? map([ 234, 131,  28, 172, 17,  96,  66, 253,
      \         243, 131,  28, 172, 17,  96,  66, 231 ], 's:c(v:val)')
      \ : map([ 236, 131, 108, 222, 61, 139, 109, 253,
      \         243, 131, 108, 222, 61, 139, 109, 254 ], 's:c(v:val)')

if has('nvim')
  for s:i in range(len(s:term_theme))
    execute 'let g:terminal_color_' . s:i . ' = "' . s:term_theme[s:i] . '"'
  endfor
else
  let g:terminal_ansi_colors = s:term_theme
endif

" }}}

" vim: noet fdm=marker sw=2
