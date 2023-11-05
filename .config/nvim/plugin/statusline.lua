-- Sample status line:
-- [23] .dotfiles/.vim/vimrc [+]                   [dos] 10, 70/218
-- [23] options.txt [Help][-][RO]                        10, 70/218
vim.opt.statusline = table.concat({
  -- buffer number
  " [%n]",
  -- truncate at start, full path
  " %<%f",
  -- help, preview, modified, read-only
  " %h%w%m%r",
  -- separation point
  "%=",
  -- show file format if not unix
  "%{&ff!='unix'?'['.&ff.'] ':''}",
  -- ruler stats
  "%-14.(%l,%c%V%) %(%L %)",
})
