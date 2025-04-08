setlocal shiftwidth=4
nnoremap <buffer> <silent> <leader>F :<C-u>LedgerAlign<CR>

if exists('b:undo_ftplugin')
	let b:undo_ftplugin .= '| setlocal shiftwidth<' . " | execute 'nunmap <buffer> <leader>F'"
else
	let b:undo_ftplugin = 'setlocal shiftwidth<' . " | execute 'nunmap <buffer> <leader>F'"
endif
