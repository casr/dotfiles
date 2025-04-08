" ft:ledger {{{
let g:ledger_align_at = 58
let g:ledger_commodity_before = 0
let g:ledger_commodity_sep = ' '
let g:ledger_default_commodity = 'GBP'
let g:ledger_fold_blanks = 1
let g:ledger_maxwidth = 61
" }}}

" ft:sh {{{
let g:is_posix = 1
" }}}

" ft:tmux {{{
let g:tmux_syntax_colors = 0
" }}}

" terminal {{{
if !has('nvim')
  augroup plugin_filetype
    autocmd!
    autocmd TerminalOpen * setlocal nolist nonumber signcolumn=no
  augroup END
endif
" }}}
