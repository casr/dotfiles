local r_cmp, cmp = pcall(require, "cmp")

vim.keymap.set("n", "<leader>ff", "<Plug>(PickerEdit)", { unique = true })
vim.keymap.set("n", "<leader>fb", "<Plug>(PickerBuffer)", { unique = true })
vim.keymap.set("n", "<leader>sh", "<Plug>(PickerHelp)", { unique = true })

vim.keymap.set("n", "yoe", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

vim.keymap.set("n", "yog", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end)

if r_cmp then
  -- regular omnicompletion will fail with the extra capabilities from nvim-cmp
  -- so force the use of nvim-cmp
  vim.keymap.set("i", "<C-x><C-o>", cmp.complete)
end
