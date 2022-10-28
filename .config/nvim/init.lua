-- Built-in {{{
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

vim.o.shortmess = vim.o.shortmess .. "I"
vim.o.mouse = "nvc"
vim.o.background = "light"
vim.cmd [[colorscheme chromatine]]
-- Wrap and indent lines by the current line's plus shift
vim.o.breakindent = true
vim.o.breakindentopt = "shift:2,sbr"
vim.o.linebreak = true

vim.o.fillchars = "vert:│,fold:═,foldopen:┌,foldclose:╓,foldsep:│"
vim.o.showbreak = "…"
vim.o.list = true
vim.o.listchars = "tab:› ,trail:•,extends:›,precedes:‹,nbsp:."

vim.o.splitbelow = true
vim.o.splitright = true

if vim.fn.executable("ag") then
  vim.o.grepprg = "ag --vimgrep $*"
  vim.o.grepformat = "%f:%l:%c:%m"
end
vim.o.colorcolumn = "+1"
vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.foldcolumn = "4"
vim.o.signcolumn = "number"

-- Do not let random files mess with the settings
vim.o.modeline = false
vim.o.completeopt = "menuone,noselect"

vim.o.swapfile = false
vim.o.undofile = true

-- Sample status line:
-- [23] .dotfiles/.vim/vimrc [+]                   [dos] 10, 70/218
-- [23] options.txt [Help][-][RO]                        10, 70/218
vim.o.statusline = table.concat({
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
vim.o.showtabline = 2
-- }}}

-- Plugin settings {{{
vim.g.netrw_dirhistmax = 0
vim.g.netrw_banner = 0
vim.g.netrw_list_hide = table.concat({
  "netrw_gitignore#Hide()",
  ",\\(^\\|\\s\\s\\)\\zs\\.\\S\\+",
})

-- So syntax highlighting understands $(...)
vim.g.is_posix = 1

vim.g.tmux_syntax_colors = 0
-- }}}

-- Autocmds {{{

local augroup = vim.api.nvim_create_augroup("init_autocmd", {})

-- Web {{{
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "css", "javascript", "javascriptreact", "json", "sass", "scss", "typescript", "typescriptreact" },
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
  end
})
-- }}}
-- Ledger {{{
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "ledger",
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
  end
})
-- }}}
-- Lua {{{
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "lua",
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
  end
})
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup,
  pattern = "*/nvim/init.lua",
  callback = function()
    vim.wo.foldmethod = "marker"
  end
})
-- }}}
-- Vim {{{
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "vim",
  callback = function()
    vim.wo.foldmethod = "marker"
  end
})
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "help",
  callback = function()
    vim.wo.colorcolumn = ""
  end
})
-- }}}
-- Prose {{{
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "gitcommit", "gitsendmail", "mail", "markdown", "text" },
  callback = function()
    vim.wo.spell = true
    vim.bo.spelllang = "en_gb"
    if vim.fn.executable("par") then
      vim.bo.formatprg = "par -w" .. (vim.bo.textwidth > 0 and vim.bo.textwidth or 74)
    end
  end
})
-- }}}

-- }}}

-- Custom mappings {{{
local opts = { silent = true }

vim.keymap.set("n", "<C-g><C-g>", ":let @+=@%<CR>", opts)

vim.keymap.set("n", "<leader>q", require("toggle_list").toggle_list_fn("quickfix"), opts)
vim.keymap.set("n", "<leader>l", require("toggle_list").toggle_list_fn("loclist"), opts)

vim.keymap.set("n", "<leader>di", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts)

local function get_syntax_stack(col_offset)
  local function id_to_name(id)
    return vim.fn.synIDattr(id, "name")
  end
  return function()
    if not vim.fn.exists("*synstack") then
      return
    end
    local groupNames = vim.tbl_map(
      id_to_name,
      vim.fn.synstack(vim.fn.line('.'), vim.fn.col('.') + col_offset)
    )
    print(vim.inspect(groupNames))
  end
end
vim.keymap.set("n", "<leader>zi", get_syntax_stack(0))
vim.keymap.set("n", "<leader>zn", get_syntax_stack(1))
-- }}}

require "plugins"
