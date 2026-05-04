if exists('g:loaded_restorecursor')
  finish
endif
let g:loaded_restorecursor = 1

if has('autocmd')
  augroup plugin_autocmd
    autocmd!

    " :help restore-cursor
    autocmd BufReadPre * autocmd FileType <buffer> ++once
          \ let line = line("'\"")
          \ | if line >= 1 && line <= line("$") && &filetype !~# 'commit'
          \      && index(['xxd', 'gitrebase'], &filetype) == -1
          \      && !&diff
          \ |   execute "normal! g`\"zz"
          \ | endif
  augroup END
endif
