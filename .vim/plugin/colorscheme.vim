function! s:background_color() abort
  return trim(system('get_interface_style'))
endfunction

function! s:set_background_color() abort
  let l:bg = s:background_color()
  " Only adjust the background automatically if the interface style is
  " different to a previous invocation. This allows for this setting to be
  " manually overridden.
  if s:last_background !=# l:bg
    let s:last_background = l:bg
    let &background=l:bg
  endif
endfunction

function! s:chromatine_additions()
  hi! link NormalFloat Normal
  " hrsh7th/nvim-cmp
  hi! link CmpItemAbbr chromatineComment
  hi! link CmpItemAbbrMatch chromatineBold

  " prabirshrestha/vim-lsp
  hi! link LspInformationText chromatineComment
  hi! link LspInformationVirtualText LspInformationText
  hi! link LspInformationHighlight chromatineUnderlined
  hi! link LspErrorText chromatineErrorMsg
  hi! link LspWarningText chromatineVisual
  hi! link LspHintText chromatineLineNC
  hi! link LspErrorHighlight chromatineUnderlined
  hi! link LspWarningHighlight chromatineUnderlined
  hi! link LspHintHighlight chromatineUnderlined
  hi! link LspErrorVirtualText chromatineErrorMsg
  hi! link LspWarningVirtualText chromatineVisual
  hi! link LspHintVirtualText chromatineLineNC
endfunction

augroup plugin_colorscheme
  autocmd!
  autocmd ColorScheme chromatine call s:chromatine_additions()
  autocmd FocusGained * ++nested call s:set_background_color()
augroup END

let s:last_background = s:background_color()
let &background = s:last_background
colorscheme chromatine
