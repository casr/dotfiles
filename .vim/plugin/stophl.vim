if exists('g:loaded_stophl')
  finish
endif
let g:loaded_stophl = 1

if has('autocmd')
  noremap <expr> <Plug>(StopHL) execute('nohlsearch')[-1]
  noremap! <expr> <Plug>(StopHL) execute('nohlsearch')[-1]

  function s:StopHL()
    if !v:hlsearch
      return
    else
      call feedkeys("\<Plug>(StopHL)", "m")
    endif
  endfunction

  augroup plugin_stophl
    autocmd!

    autocmd InsertEnter * call <SID>StopHL()
  augroup END
endif
