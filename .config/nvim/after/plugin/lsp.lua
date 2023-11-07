local augroup = vim.api.nvim_create_augroup("after_plugin_lsp", {})

local float_config = { width = 60, border = "rounded" }

vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(vim.lsp.handlers.hover, float_config)

vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(vim.lsp.handlers.signature_help, float_config)

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(args)
    local mapopts = { silent = true, buffer = args.buf }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, mapopts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, mapopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, mapopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, mapopts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, mapopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, mapopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, mapopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, mapopts)
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, mapopts)
  end,
})
