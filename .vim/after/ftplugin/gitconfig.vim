setlocal noexpandtab shiftwidth=0

if exists('b:undo_ftplugin')
	let b:undo_ftplugin .= '| setlocal expandtab< shiftwidth<'
else
	let b:undo_ftplugin = 'setlocal expandtab< shiftwidth<'
endif
