local r_conform, conform = pcall(require, "conform")

if not r_conform then
  return
end

conform.setup({
  formatters_by_ft = {
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    lua = { "stylua" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    conform.format({ bufnr = args.buf })
  end,
})
