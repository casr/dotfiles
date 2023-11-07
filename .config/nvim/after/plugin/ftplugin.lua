local augroup = vim.api.nvim_create_augroup("after_plugin_ftplugin", {})

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
    vim.opt_local.expandtab = true
    vim.opt_local.formatexpr = "v:lua.require'conform'.formatexpr()"
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "gitcommit", "gitsendmail", "mail", "markdown", "text" },
  callback = function()
    vim.opt_local.spelllang = "en_gb"
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
