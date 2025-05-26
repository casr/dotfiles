setlocal formatoptions-=t
compiler pyright

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| setlocal formatoptions<'
else
  let b:undo_ftplugin = 'setlocal formatoptions<'
endif
