" Vim color file
" Description: Low-colour theme with light and dark variants
" Maintainer: Chris Rawnsley <chris@puny.agency>
" Version: 0.7.0
" Source: https://github.com/casr/vim-colors-chromatine
" Modified: 2023 Nov 05

hi clear
if exists('syntax_on')
	syntax reset
endif

let g:colors_name = 'chromatine'

" Reset Vim's default settings so that we have a monochrome colour palette
" from which we can build upon.
" Plain terminal {{{

hi chromatineSelection term=reverse cterm=reverse gui=reverse
hi chromatineHighlight term=bold cterm=bold gui=bold
hi chromatineUI term=reverse cterm=reverse gui=reverse
hi chromatineUIActive NONE

hi Visual NONE | hi link Visual chromatineSelection
hi VertSplit NONE
hi LineNr NONE | hi link LineNr chromatineUIMuted
hi MatchParen NONE | hi link MatchParen chromatineHighlight

hi NonText NONE | hi link NonText chromatineUIMuted
hi SpecialKey NONE | hi link SpecialKey chromatineUIMuted

hi Pmenu NONE | hi link Pmenu chromatineUI
hi PmenuSel NONE term=nocombine cterm=nocombine gui=nocombine
hi PmenuSbar NONE | hi link PmenuSbar chromatineUIActive
hi PmenuThumb NONE | hi link PmenuThumb chromatineSelection

hi StatusLine NONE term=reverse cterm=reverse gui=reverse
hi StatusLineNC NONE term=nocombine cterm=nocombine gui=nocombine

hi Tabline NONE | hi link TabLine TabLineFill
hi TabLineSel NONE | hi link TabLineSel chromatineUIActive
hi TabLineFill NONE | hi link TabLineFill chromatineUI

hi Title NONE cterm=bold gui=bold
hi Directory NONE

hi CursorLineNr NONE term=bold cterm=bold gui=bold

hi Search NONE
hi IncSearch NONE | hi link IncSearch chromatineSelection

hi ErrorMsg NONE
hi ModeMsg NONE
hi MoreMsg NONE
hi Question NONE
hi WarningMsg NONE | hi link WarningMsg chromatineSelection

if has('clipboard')
	hi VisualNOS NONE | hi link VisualNOS Visual
endif

if has('diff')
	hi DiffAdd NONE
	hi DiffChange NONE
	hi DiffDelete NONE
	hi DiffText NONE term=bold cterm=bold gui=bold
endif

if has('gui_running')
	hi Cursor NONE | hi link Cursor chromatineUI
	hi lCursor NONE | hi link lCursor Cursor
endif

if has('folding')
	hi Folded NONE | hi link Folded chromatineUIMuted
	hi FoldColumn NONE | hi link FoldColumn chromatineUIMuted
endif

if has('spell')
	hi SpellBad NONE term=underline cterm=underline gui=undercurl
	hi SpellCap NONE | hi link SpellCap SpellBad
	hi SpellLocal NONE | hi link SpellLocal SpellBad
	hi SpellRare NONE
endif

if has('syntax')
	hi ColorColumn NONE | hi link ColorColumn chromatineUI
	hi CursorLine NONE
	hi CursorColumn NONE | hi link CursorColumn CursorLine

	hi Comment NONE
	hi Constant NONE
	hi Special NONE
	hi Identifier NONE
	hi Statement NONE
	hi PreProc NONE
	hi Type NONE
	hi Underlined NONE term=underline cterm=underline gui=underline
	hi Ignore NONE
	hi Error NONE term=underline cterm=underline gui=underline
	hi Todo NONE
endif

if has('wildmenu')
	hi WildMenu NONE
endif

if has('conceal')
	hi Conceal NONE
endif

if has('signs')
	hi SignColumn NONE
endif

if has('terminal')
	hi StatusLineTerm NONE | hi link StatusLineTerm StatusLine
	hi StatusLineTermNC NONE | hi link StatusLineTermNC StatusLineNC
endif

if has('nvim')
	hi DiagnosticError NONE
	hi DiagnosticWarn NONE
	hi DiagnosticInfo NONE
	hi DiagnosticHint NONE
	hi DiagnosticUnderlineError NONE term=underline cterm=underline gui=underline
	hi DiagnosticUnderlineWarn NONE term=underline cterm=underline gui=underline
	hi DiagnosticUnderlineInfo NONE term=underline cterm=underline gui=underline
	hi DiagnosticUnderlineHint NONE term=underline cterm=underline gui=underline

	hi LspReferenceText NONE | hi link LspReferenceText chromatineUI
	hi LspReferenceRead NONE | hi link LspReferenceRead LspReferenceText
	hi LspReferenceWrite NONE | hi link LspReferenceWrite LspReferenceText
endif
" }}}

" 256 color terminal / GUI {{{
if !(has('gui_running') || &t_Co >= 256) | finish | endif

let s:accent = get(g:, 'chromatine_accent', { 'light': 32, 'dark': 75 })

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
	let l:rest = {}
	let l:i = 1
	while l:i <# a:0
		let l:kwarg = split(a:000[l:i], '=')
		let l:key = l:kwarg[0]
		let l:v = get(s:accent, l:kwarg[1], l:kwarg[1])
		let l:rest[l:key] = l:v

		if has_key(s:color_map, l:key)
			let l:mapped_key = s:color_map[l:key]
			if !has_key(l:rest, l:mapped_key)
				if l:v ==# 'NONE' || l:v ==# 'bg' || l:v ==# 'fg'
					let l:rest[l:mapped_key] = l:v
				else
					let l:rest[l:mapped_key] = s:c(str2nr(l:v))
				endif
			endif
		endif

		let l:i += 1
	endwhile
	let l:cmd = 'hi '.l:group
	for kw in keys(l:rest)
		let l:cmd .= ' '.kw.'='.l:rest[kw]
	endfor
	execute l:cmd
endfunction
" }}}

hi chromatineSelection NONE
hi chromatineUI NONE

hi PmenuSel NONE | hi link PmenuSel chromatineSelection

hi StatusLine NONE | hi link StatusLine chromatineUIActive
hi StatusLineNC NONE | hi link StatusLineNC chromatineUI

hi CursorLineNr NONE

hi QuickFixLine NONE | hi link QuickFixLine chromatineHighlight

if has('syntax')
	hi Todo cterm=bold,underline gui=bold,underline
endif

if has('wildmenu')
	hi link WildMenu chromatineSelection
endif

if &background ==# 'light'
	Hi Normal ctermfg=235 ctermbg=231

	Hi chromatineSelection ctermfg=bg ctermbg=light
	Hi chromatineHighlight ctermfg=light
	Hi chromatineUI ctermbg=253
	Hi chromatineUIActive ctermfg=light ctermbg=255
	Hi chromatineUIMuted ctermfg=246

	Hi VertSplit ctermfg=253

	Hi CursorLineNr ctermfg=235

	Hi Search ctermfg=fg ctermbg=222

	hi ErrorMsg ctermbg=217

	if has('diff')
		Hi DiffAdd ctermbg=194
		Hi DiffChange ctermbg=254
		Hi DiffDelete ctermbg=224
		Hi DiffText ctermbg=230
	endif

	if has('folding')
		Hi FoldColumn ctermfg=246
	endif

	if has('syntax')
		Hi CursorLine ctermbg=255

		Hi Comment ctermfg=240
		Hi Error ctermbg=224
	endif

	Hi chromatineDiffAdd ctermfg=28
	Hi chromatineDiffChange ctermfg=100
	Hi chromatineDiffDelete ctermfg=131

	if has('nvim')
		Hi DiagnosticError ctermfg=131
		Hi DiagnosticUnderlineError ctermfg=131
		Hi DiagnosticWarn ctermfg=172
		Hi DiagnosticHint ctermfg=243
	endif
else
	Hi Normal ctermfg=253 ctermbg=234

	Hi chromatineSelection ctermfg=bg ctermbg=dark
	Hi chromatineHighlight ctermfg=dark
	Hi chromatineUI ctermbg=238
	Hi chromatineUIActive ctermfg=dark ctermbg=236
	Hi chromatineUIMuted ctermfg=245

	Hi VertSplit ctermfg=238

	Hi CursorLineNr ctermfg=250

	Hi Search ctermfg=fg ctermbg=94

	hi ErrorMsg ctermbg=131

	if has('diff')
		Hi DiffAdd ctermbg=22
		Hi DiffChange ctermbg=235
		Hi DiffDelete ctermbg=52
		Hi DiffText ctermbg=58
	endif

	if has('folding')
		Hi FoldColumn ctermfg=242
	endif

	if has('syntax')
		Hi CursorLine ctermbg=236

		Hi Comment ctermfg=248
		Hi Error ctermbg=52
	endif

	Hi chromatineDiffAdd ctermfg=65
	Hi chromatineDiffChange ctermfg=142
	Hi chromatineDiffDelete ctermfg=130

	if has('nvim')
		Hi DiagnosticError ctermfg=131
		Hi DiagnosticUnderlineError ctermfg=131
		Hi DiagnosticWarn ctermfg=222
		Hi DiagnosticHint ctermfg=245
	endif
endif

if has('clipboard')
	Hi VisualNOS ctermfg=bg ctermbg=fg
endif

let s:term_theme = &background ==# 'light'
	\ ? ['#1c1c1c', '#af5f5f', '#008700', '#d78700', '#00005f', '#875f87', '#5f8787', '#dadada',
           \ '#767676', '#af5f5f', '#008700', '#d78700', '#00005f', '#875f87', '#5f8787', '#ffffff']
	\ : ['#303030', '#af5f5f', '#87af87', '#ffd787', '#5f5faf', '#af87af', '#87afaf', '#dadada',
           \ '#767676', '#af5f5f', '#87af87', '#ffd787', '#5f5faf', '#af87af', '#87afaf', '#e4e4e4']

if (has('termguicolors') && &termguicolors) || has('gui_running')
	if has('nvim')
		let s:i = 0
		for c in s:term_theme
			execute 'let g:terminal_color_' . s:i . ' = "' . c . '"'
			let s:i += 1
		endfor
	else
		let g:terminal_ansi_colors = s:term_theme
	endif
endif

" Syntax tweaks {{{
if has('syntax')
	" ft:css {{{
	hi link cssMediaComma NONE
	" }}}

	" ft:diff {{{
	hi link diffAdded DiffAdd
	hi link diffChanged DiffChange
	hi link diffRemoved DiffDelete
	hi link diffSubname Comment
	hi link diffLine Comment
	hi link diffFile Comment
	hi link diffOldFile Comment
	hi link diffNewFile Comment
	hi link diffIndexLine Comment
	" }}}

	" ft:help {{{
	hi link helpHyperTextJump chromatineHighlight
	" }}}

	" ft:typescript {{{
	hi link typescriptSymbols NONE
	hi link typescriptParens NONE
	" }}}

	" ft:vim {{{
	hi link vimEmbedError NONE
	hi link vimCommentTitle Comment
	hi link vimUserFunc NONE
	" }}}
endif
" }}}

" Plugin tweaks {{{

" Signify {{{
hi link SignifySignAdd chromatineDiffAdd
hi link SignifySignChange chromatineDiffChange
hi link SignifySignDelete chromatineDiffDelete
" }}}

" }}}

delcommand Hi
" }}}

" vim: noet fdm=marker ts=8
