local opts = { silent = true }

vim.keymap.set("n", "<leader>di", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts)

vim.keymap.set("n", "<leader>t", "<Plug>(PickerEdit)")
vim.keymap.set("n", "<leader>b", "<Plug>(PickerBuffer)")
vim.keymap.set("n", "<leader>s", "<Plug>(PickerVsplit)")
