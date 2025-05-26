local r_conform, conform = pcall(require, "conform")

if not r_conform then
  return
end

local augroup = vim.api.nvim_create_augroup("after_plugin_format", {})

conform.setup({
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return {}
  end,
  formatters_by_ft = {
    css = { "prettier" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    lua = { "stylua" },
    python = { "ruff_organize_imports", "ruff_format" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
  },
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = vim.tbl_keys(conform.formatters_by_ft),
  callback = function()
    vim.opt_local.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})
