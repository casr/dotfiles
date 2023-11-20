vim.opt.breakindent = true
vim.opt.breakindentopt = { "list:-1", "sbr", "shift:2" }
vim.opt.colorcolumn = "+1"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.cpoptions:append({ n = true })
vim.opt.diffopt = {
  "algorithm:histogram",
  "filler",
  "indent-heuristic",
  "internal",
  "linematch:60",
}
vim.opt.fillchars = {
  vert = "│",
  foldopen = "┌",
  foldclose = "╓",
  foldsep = "│",
}
vim.opt.foldcolumn = "auto:4"
vim.opt.formatoptions:append({ n = true, o = true, r = true })
vim.opt.ignorecase = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = {
  tab = "› ",
  trail = "•",
  extends = "›",
  precedes = "‹",
  nbsp = ".",
}
vim.opt.modeline = false
vim.opt.mouse = { c = true, n = true, v = true }
vim.opt.number = true
vim.opt.pumheight = 10
vim.opt.shortmess:append({ I = true })
vim.opt.showbreak = "+++ "
vim.opt.showtabline = 2
vim.opt.signcolumn = "auto:2-4"
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.updatetime = 400
vim.opt.wildmode = { "longest:full", "full" }

if vim.fn.executable("ag") then
  vim.opt.grepformat = "%f:%l:%c:%m"
  vim.opt.grepprg = "ag --vimgrep $*"
end

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.loaded_2html_plugin = 0
vim.g.loaded_gzip = 0
vim.g.loaded_man = 0
vim.g.loaded_tarPlugin = 0
vim.g.loaded_tutor_mode_plugin = 0
vim.g.loaded_zipPlugin = 0
