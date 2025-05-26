if exists('current_compiler')
  finish
endif
let current_compiler = 'pyright'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

let &l:errorformat =
      \ '  %f:%l:%c - %trror: %m,' .
      \ '  %f:%l:%c - %tarning: %m,' .
      \ '%-G%.%#'

CompilerSet makeprg=pyright
silent CompilerSet errorformat

let &cpo = s:cpo_save
unlet s:cpo_save
