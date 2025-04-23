function! s:git_merge_base() abort
  return FugitiveExecute(['merge-base', 'origin', 'HEAD']).stdout[0]
endfunction

nmap <leader>gs <Cmd>Git<CR>
nmap <leader>gb <Cmd>Git blame<CR>
nmap <leader>gd :<C-u>Gvdiffsplit!<Space>
nmap <leader>gD :<C-u>Gvdiffsplit! <C-r>=<SID>git_merge_base()<CR><CR>
nmap <leader>gr :<C-u>Git difftool -y <C-r>=<SID>git_merge_base()<CR><CR>
nmap <leader>gf :<C-u>Git difftool --name-only <C-r>=<SID>git_merge_base()<CR><CR>

nmap <leader>fg :<C-u>silent grep -iF '<C-r>=expand('<cWORD>')<CR>' \| redraw!<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

nmap <leader>q <Plug>(qf_qf_toggle)
nmap <leader>l <Plug>(qf_loc_toggle)

nmap <leader>yf <Cmd>let @+=fnamemodify(resolve(expand('%:p')), ':.')<CR>
nmap <leader>yF <Cmd>let @+=resolve(expand('%:p'))<CR>
nmap <leader>yy mm0"+y$`m
xmap <leader>yy "+ygv
nmap <leader>yG mmgg"+yG`m

nmap <leader>F mmgggqG`m

" continue for vim-specific keymaps
" nvim-specific ones in keymap.lua
if has('nvim')
  finish
endif

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> K <Plug>(lsp-hover)
endfunction

augroup lsp_install
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

nmap grn <Plug>(lsp-rename)
nmap gra <Plug>(lsp-code-action)
nmap grr <Plug>(lsp-references)
nmap gri <Plug>(lsp-implementation)
nmap gO <Plug>(lsp-document-symbol)

nmap ]d <Cmd>LspNextDiagnostic<CR>
nmap [d <Cmd>LspPreviousDiagnostic<CR>

nmap <leader>ff <Cmd>Select casr_file<CR>
nmap <leader>fb <Cmd>Select buffer<CR>

nmap <leader>tt <Cmd>TestNearest<CR>
nmap <leader>tT <Cmd>TestFile<CR>
nmap <leader>ta <Cmd>TestSuite<CR>
nmap <leader>tl <Cmd>TestLast<CR>
nmap <leader>tf <Cmd>TestFile<CR>
