" Vim color file
" Description: Low-colour theme with light and dark variants
" Maintainer: Chris Rawnsley <chris@puny.agency>
" Version: 0.5.0
" Source: https://github.com/casr/vim-colors-chromatine
" Last change: 2022 Aug 5

hi clear
if exists('syntax_on')
	syntax reset
endif

let g:colors_name = 'chromatine'

" Reset Vim's default settings so that we have a monochrome colour palette
" from which we can build upon.
" Plain terminal {{{

hi Normal ctermfg=NONE ctermbg=NONE

hi Directory term=NONE ctermfg=NONE guifg=NONE
hi ErrorMsg term=reverse cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guifg=NONE guibg=NONE
hi LineNr term=NONE ctermfg=NONE guifg=NONE
hi CursorLineNr cterm=bold ctermfg=NONE guifg=NONE
hi MatchParen term=bold cterm=bold ctermbg=NONE guibg=NONE
hi ModeMsg term=NONE cterm=NONE gui=NONE
hi MoreMsg term=NONE ctermfg=NONE gui=NONE guifg=NONE
hi NonText term=NONE ctermfg=NONE gui=NONE guifg=NONE
hi Pmenu term=reverse cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guibg=NONE
hi PmenuSel ctermfg=NONE ctermbg=NONE guibg=NONE
hi PmenuSbar ctermbg=NONE guibg=NONE
hi PmenuThumb ctermbg=NONE guibg=NONE
hi Question term=NONE ctermfg=NONE gui=NONE guifg=NONE
hi Search cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guifg=NONE guibg=NONE
hi SpecialKey term=NONE ctermfg=NONE guifg=NONE
hi StatusLine term=reverse cterm=reverse gui=reverse
hi StatusLineNC term=NONE cterm=NONE gui=NONE
hi TabLine term=reverse cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guibg=NONE
hi TabLineSel term=NONE cterm=NONE gui=NONE
hi Title cterm=bold ctermfg=NONE gui=bold guifg=NONE
hi Visual term=reverse cterm=reverse ctermbg=NONE gui=reverse guibg=NONE
hi WarningMsg term=reverse cterm=reverse ctermfg=NONE gui=reverse guifg=NONE

if has('clipboard')
	hi VisualNOS term=reverse cterm=reverse gui=reverse
endif

if has('diff')
	hi DiffAdd cterm=bold ctermbg=NONE gui=bold guibg=NONE
	hi DiffChange cterm=bold ctermbg=NONE gui=bold guibg=NONE
	hi DiffDelete cterm=bold ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
	hi DiffText cterm=reverse ctermbg=NONE gui=reverse guibg=NONE
endif

if has('folding')
	hi Folded term=reverse cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guifg=NONE guibg=NONE
	hi FoldColumn term=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
endif

if has('spell')
	hi SpellBad term=underline cterm=underline ctermbg=NONE guisp=NONE
	hi SpellCap term=underline cterm=underline ctermbg=NONE guisp=NONE
	hi SpellLocal term=underline cterm=underline ctermbg=NONE guisp=NONE
	hi SpellRare term=NONE ctermbg=NONE guisp=NONE
endif

if has('syntax')
	hi ColorColumn cterm=reverse ctermbg=NONE gui=reverse guibg=NONE
	hi CursorColumn term=NONE ctermbg=NONE guibg=NONE
	hi CursorLine term=NONE cterm=NONE guibg=NONE

	hi Comment term=NONE ctermfg=NONE guifg=NONE
	hi Constant term=NONE ctermfg=NONE guifg=NONE
	hi Special term=NONE ctermfg=NONE guifg=NONE
	hi Identifier term=NONE cterm=NONE ctermfg=NONE guifg=NONE
	hi Statement term=NONE ctermfg=NONE gui=NONE guifg=NONE
	hi PreProc term=NONE ctermfg=NONE guifg=NONE
	hi Type term=NONE ctermfg=NONE gui=NONE guifg=NONE
	hi Underlined ctermfg=NONE guifg=NONE
	hi Ignore ctermfg=NONE guifg=NONE
	hi Error cterm=reverse ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
	hi Todo term=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
endif

if has('wildmenu')
	hi WildMenu term=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
endif

if has('conceal')
	hi Conceal ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
endif

if has('signs')
	hi SignColumn term=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
endif

if has('terminal')
	hi StatusLineTerm term=reverse cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guifg=NONE guibg=NONE
	hi StatusLineTermNC term=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
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

if &background ==# 'light'
	Hi Normal ctermfg=235 ctermbg=231
	Hi VertSplit ctermfg=250 ctermbg=254
	Hi IncSearch ctermfg=bg ctermbg=light
	Hi MatchParen ctermfg=light
	Hi Pmenu ctermfg=255 ctermbg=241
	Hi PmenuSel ctermbg=light
	Hi Search ctermfg=fg ctermbg=222
	Hi StatusLine ctermfg=bg ctermbg=240
	Hi StatusLineNC ctermbg=254
	Hi TabLine ctermfg=240 ctermbg=254
	Hi TabLineFill ctermbg=240
	Hi Visual ctermfg=bg ctermbg=light
	Hi WarningMsg ctermfg=bg ctermbg=light

	if has('diff')
		Hi DiffAdd ctermfg=fg ctermbg=194
		Hi DiffChange ctermbg=255
		Hi DiffDelete ctermfg=fg ctermbg=224
		Hi DiffText ctermbg=228
	endif

	if has('folding')
		Hi Folded ctermfg=light
	endif

	if has('syntax')
		Hi ColorColumn ctermfg=fg ctermbg=254
		Hi CursorColumn ctermbg=254
		Hi CursorLine ctermbg=254

		Hi Comment ctermfg=243
		Hi Statement ctermfg=242
		Hi Error ctermbg=224
		Hi Todo ctermfg=light
	endif

	if has('terminal')
		Hi StatusLineTerm ctermfg=bg ctermbg=240
		Hi StatusLineTermNC ctermbg=254
	endif
else
	Hi Normal ctermfg=253 ctermbg=234
	Hi VertSplit ctermfg=240 ctermbg=237
	Hi IncSearch ctermfg=bg ctermbg=dark
	Hi MatchParen ctermfg=dark
	Hi Pmenu ctermfg=255 ctermbg=244
	Hi PmenuSel ctermbg=dark
	Hi Search ctermfg=bg ctermbg=222
	Hi StatusLine ctermfg=bg ctermbg=250
	Hi StatusLineNC ctermbg=237
	Hi TabLine ctermfg=250 ctermbg=237
	Hi TabLineFill ctermbg=250
	Hi Visual ctermfg=bg ctermbg=dark
	Hi WarningMsg ctermfg=bg ctermbg=dark

	if has('diff')
		Hi DiffAdd ctermfg=fg ctermbg=65
		Hi DiffChange ctermbg=236
		Hi DiffDelete ctermfg=fg ctermbg=95
		Hi DiffText ctermbg=58
	endif

	if has('folding')
		Hi Folded ctermfg=dark
	endif

	if has('syntax')
		Hi ColorColumn ctermfg=fg ctermbg=237
		Hi CursorColumn ctermbg=237
		Hi CursorLine ctermbg=237

		Hi Comment ctermfg=246
		Hi Error ctermbg=95
		Hi Todo ctermfg=dark
	endif

	if has('terminal')
		Hi StatusLineTerm ctermfg=bg ctermbg=250
		Hi StatusLineTermNC ctermbg=237
	endif
endif

Hi VertSplit cterm=NONE gui=NONE
Hi IncSearch cterm=NONE gui=NONE
Hi ErrorMsg cterm=NONE ctermfg=231 ctermbg=160 gui=NONE
Hi LineNr ctermfg=246
Hi MatchParen cterm=bold gui=bold
Hi NonText cterm=NONE ctermfg=246 gui=NONE
Hi Pmenu cterm=NONE gui=NONE
Hi PmenuSel ctermfg=231
Hi PmenuSbar ctermbg=fg
Hi PmenuThumb ctermbg=240
Hi Search cterm=NONE gui=NONE
Hi SpecialKey cterm=NONE ctermfg=246 gui=NONE
Hi StatusLine cterm=NONE gui=NONE
Hi TabLine cterm=NONE gui=NONE
Hi TabLineFill cterm=NONE gui=NONE
Hi Visual cterm=NONE gui=NONE
Hi WarningMsg cterm=NONE gui=NONE

if has('diff')
	Hi DiffAdd cterm=NONE gui=NONE
	Hi DiffChange cterm=NONE gui=NONE
	Hi DiffDelete cterm=NONE gui=NONE
	Hi DiffText cterm=bold gui=bold
endif

if has('folding')
	Hi Folded cterm=NONE gui=NONE
endif

if has('syntax')
	Hi ColorColumn cterm=NONE gui=NONE
	Hi Todo cterm=bold gui=bold
	Hi Error cterm=NONE gui=NONE

	" ft:diff {{{
	hi! link diffAdded DiffAdd
	hi! link diffChanged DiffChange
	hi! link diffRemoved DiffDelete
	hi! link diffSubname Comment
	hi! link diffLine Comment
	hi! link diffFile Comment
	hi! link diffOldFile Comment
	hi! link diffNewFile Comment
	hi! link diffIndexLine Comment
	" }}}
endif

if has('clipboard')
	Hi VisualNOS cterm=NONE ctermfg=bg ctermbg=fg gui=NONE
endif

if has('terminal')
	Hi StatusLineTerm cterm=NONE gui=NONE
endif

delcommand Hi
" }}}

" vim: noet fdm=marker ts=8
