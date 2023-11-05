local augroup = vim.api.nvim_create_augroup("after_plugin_ftplugin", {})

vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup,
  pattern = "*/nvim/init.lua",
  callback = function()
    vim.wo.foldmethod = "marker"
  end
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = {
    "css",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "sass",
    "scss",
    "typescript",
    "typescriptreact",
  },
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "gitcommit", "gitsendmail", "mail", "markdown", "text" },
  callback = function()
    vim.wo.spell = true
    vim.bo.spelllang = "en_gb"
    if vim.fn.executable("par") then
      vim.bo.formatprg = "par -w" .. (vim.bo.textwidth > 0 and vim.bo.textwidth or 74)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "ledger",
  callback = function(args)
    vim.keymap.set(
      "n",
      "<leader>f",
      ":LedgerAlign<CR>",
      { silent = true, buffer = args.buf }
    )
  end,
})
