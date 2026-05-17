setlocal formatoptions-=t

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| setlocal formatoptions<'
else
  let b:undo_ftplugin = 'setlocal formatoptions<'
endif
