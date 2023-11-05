vim.opt.breakindent = true
vim.opt.breakindentopt = { "sbr", "shift:2" }
vim.opt.colorcolumn = "+1"
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.cursorline = true
vim.opt.fillchars = {
  vert = "│",
  foldopen = "┌",
  foldclose = "╓",
  foldsep = "│",
}
vim.opt.foldcolumn = "4"
vim.opt.ignorecase = true
vim.opt.linebreak = true
vim.opt.listchars = {
  tab = "› ",
  trail = "•",
  extends = "›",
  precedes = "‹",
  nbsp = ".",
}
vim.opt.modeline = false
vim.opt.mouse = { c = true, n = true, v = true }
vim.opt.shortmess:append({ I = true })
vim.opt.showbreak = "…"
vim.opt.showtabline = 2
vim.opt.signcolumn = "number"
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.updatetime = 400

if vim.fn.executable("ag") then
  vim.opt.grepformat = "%f:%l:%c:%m"
  vim.opt.grepprg = "ag --vimgrep $*"
end
