local r_cmp, cmp = pcall(require, "cmp")
local r_fzy, fzy = pcall(require, "fzy")
local r_q, q = pcall(require, "qwahl")

local opts = { silent = true }

vim.keymap.set("n", "<leader>di", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts)

if r_fzy then
  vim.keymap.set("n", "<leader>fF", function()
    fzy.execute(
      "find -L . -mindepth 1 2>/dev/null",
      fzy.sinks.edit_file,
      "any file > "
    )
  end, opts)
  vim.keymap.set("n", "<leader>ff", function()
    fzy.execute(
      "git ls-files --cached --exclude-standard --others",
      fzy.sinks.edit_file,
      "tracked files > "
    )
  end, opts)
  vim.keymap.set("n", "<leader>fm", function()
    fzy.execute(
      "git ls-files --exclude-standard --modified --others",
      fzy.sinks.edit_file,
      "modified files > "
    )
  end, opts)
end

if r_q then
  vim.keymap.set("n", "<leader>f/", q.buf_lines, opts)
  vim.keymap.set("n", "<leader>fb", q.buffers, opts)
  vim.keymap.set("n", "<leader>fd", q.diagnostic, opts)
  vim.keymap.set("n", "<leader>fh", q.helptags, opts)
  vim.keymap.set("n", "<leader>ft", function()
    q.try(q.lsp_tags, q.buf_tags)
  end, opts)
  vim.keymap.set("n", "<leader>fq", q.quickfix, opts)
end

if r_cmp then
  -- regular omnicompletion will fail with the extra capabilities from nvim-cmp
  -- so force the use of nvim-cmp
  vim.keymap.set("i", "<C-x><C-o>", cmp.complete)
end
