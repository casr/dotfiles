local r_cmp, cmp = pcall(require, "cmp")

vim.keymap.set("n", "<leader>ff", "<Plug>(PickerEdit)", { unique = true })
vim.keymap.set("n", "<leader>fb", "<Plug>(PickerBuffer)", { unique = true })
vim.keymap.set("n", "<leader>sh", "<Plug>(PickerHelp)", { unique = true })

if r_cmp then
  -- regular omnicompletion will fail with the extra capabilities from nvim-cmp
  -- so force the use of nvim-cmp
  vim.keymap.set("i", "<C-x><C-o>", cmp.complete)
end
