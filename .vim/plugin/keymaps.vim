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

function! s:git_merge_base() abort
	return trim(system('git merge-base origin HEAD'))
endfunction

nmap <leader>gs <Cmd>Git<CR>
nmap <leader>gb <Cmd>Git blame<CR>
nmap <leader>gd :<C-u>Gvdiffsplit!<Space>
nmap <leader>gD :<C-u>Gvdiffsplit! <C-r>=<SID>git_merge_base()<CR><CR>
nmap <leader>gr :<C-u>Git difftool -y <C-r>=<SID>git_merge_base()<CR><CR>
nmap <leader>gf :<C-u>Git difftool --name-only <C-r>=<SID>git_merge_base()<CR><CR>

nmap <leader>fg :<C-u>silent grep -iF '<C-r>=expand('<cWORD>')<CR>' \| redraw!<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
nmap <leader>ff <Plug>(SelectProjectFile)
nmap <leader>fb <Plug>(SelectBuffer)

nmap <leader>q <Plug>(qf_qf_switch)
