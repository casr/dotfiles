" continue for vim-specific commands
if has('nvim')
  finish
endif

command! Inspect :call me#inspect()
