" Vim color file
" Maintainer: Chris Rawnsley <chris@puny.agency>
" Last change: 2020 May 3

" Resets highlighting groups to defaults and then removes all colour
runtime colors/normalize.vim

let g:colors_name = 'chromatine'

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
		let l:r = l:clamp / 36
		let l:r_r = float2nr(fmod(l:clamp, 36))
		let l:g = l:r_r / 6
		let l:b = float2nr(fmod(l:r_r, 6))
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
		let l:rest[l:key] = l:kwarg[1]

		if has_key(s:color_map, l:key)
			let l:mapped_key = s:color_map[l:key]
			if !has_key(l:rest, l:mapped_key)
				let l:v = l:kwarg[1]
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
	Hi VertSplit ctermfg=254 ctermbg=254
	execute 'Hi IncSearch ctermfg='.s:accent['light']
	execute 'Hi MatchParen ctermfg='.s:accent['light']
	Hi Pmenu ctermfg=255 ctermbg=241
	execute 'Hi PmenuSel ctermbg='.s:accent['light']
	Hi Search ctermfg=222 ctermbg=fg
	Hi StatusLine ctermfg=240
	Hi StatusLineNC ctermbg=254
	Hi TabLine ctermfg=240 ctermbg=254
	Hi TabLineFill ctermfg=254
	execute 'Hi Visual ctermfg=bg ctermbg='.s:accent['light']
	execute 'Hi WarningMsg ctermfg='.s:accent['light']

	if has('diff')
		Hi DiffAdd ctermbg=194
		Hi DiffChange ctermbg=255
		Hi DiffDelete ctermbg=224
		Hi DiffText ctermbg=228
	endif

	if has('folding')
		execute 'Hi Folded ctermfg='.s:accent['light']
	endif

	if has('syntax')
		Hi ColorColumn ctermfg=254
		Hi CursorColumn ctermbg=254
		Hi CursorLine ctermbg=254

		Hi Comment ctermfg=243
		Hi Statement ctermfg=242
		execute 'Hi Todo ctermfg='.s:accent['light']
	endif

	if has('terminal')
		Hi StatusLineTerm ctermfg=240
		Hi StatusLineTermNC ctermbg=254
	endif
else
	Hi Normal ctermfg=253 ctermbg=235
	Hi VertSplit ctermfg=237 ctermbg=237
	execute 'Hi IncSearch ctermfg='.s:accent['dark']
	execute 'Hi MatchParen ctermfg='.s:accent['dark']
	Hi Pmenu ctermfg=255 ctermbg=244
	execute 'Hi PmenuSel ctermbg='.s:accent['dark']
	Hi Search ctermfg=222 ctermbg=bg
	Hi StatusLine ctermfg=250
	Hi StatusLineNC ctermbg=237
	Hi TabLine ctermfg=250 ctermbg=237
	Hi TabLineFill ctermfg=237
	execute 'Hi Visual ctermfg=bg ctermbg='.s:accent['dark']
	execute 'Hi WarningMsg ctermfg='.s:accent['dark']

	if has('diff')
		Hi DiffAdd ctermbg=65
		Hi DiffChange ctermbg=236
		Hi DiffDelete ctermbg=95
		Hi DiffText ctermbg=58
	endif

	if has('folding')
		execute 'Hi Folded ctermfg='.s:accent['dark']
	endif

	if has('syntax')
		Hi ColorColumn ctermfg=237
		Hi CursorColumn ctermbg=237
		Hi CursorLine ctermbg=237

		Hi Comment ctermfg=246
		execute 'Hi Todo ctermfg='.s:accent['dark']
	endif

	if has('terminal')
		Hi StatusLineTerm ctermfg=250
		Hi StatusLineTermNC ctermbg=237
	endif
endif

Hi ErrorMsg ctermfg=160 ctermbg=231
Hi LineNr ctermfg=246
Hi MatchParen cterm=bold gui=bold
Hi NonText cterm=NONE ctermfg=246 gui=NONE
Hi Pmenu cterm=NONE gui=NONE
Hi PmenuSel ctermfg=231
Hi PmenuSbar ctermbg=fg
Hi PmenuThumb ctermbg=240
Hi SpecialKey cterm=NONE ctermfg=246 gui=NONE
Hi TabLine cterm=NONE gui=NONE
Hi Visual cterm=NONE ctermfg=bg gui=NONE

if has('diff')
	Hi DiffAdd cterm=NONE ctermfg=fg gui=NONE
	Hi DiffChange cterm=NONE gui=NONE
	Hi DiffDelete cterm=NONE ctermfg=fg gui=NONE
	Hi DiffText cterm=bold gui=bold
endif

if has('folding')
	Hi Folded cterm=NONE gui=NONE
endif


if has('syntax')
	Hi ColorColumn ctermbg=fg
	Hi Todo cterm=bold gui=bold
endif

if has('clipboard')
	Hi VisualNOS cterm=NONE ctermfg=bg ctermbg=fg gui=NONE
endif

" Cleanup {{{
delcommand Hi
" }}}

" vim: noet fdm=marker ts=8
