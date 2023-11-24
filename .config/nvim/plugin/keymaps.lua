local r_cmp, cmp = pcall(require, "cmp")

local augroup = vim.api.nvim_create_augroup("plugin_keymaps", {})
local opts = { silent = true }

vim.keymap.set("n", "<leader>di", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts)

vim.keymap.set("n", "<leader>ff", "<Plug>(PickerEdit)", { unique = true })
vim.keymap.set("n", "<leader>fb", "<Plug>(PickerBuffer)", { unique = true })
vim.keymap.set("n", "<leader>sh", "<Plug>(PickerHelp)", { unique = true })

vim.keymap.set("n", "gs", "<Cmd>G<CR>", opts) -- toggle fugitive's status view

if r_cmp then
  -- regular omnicompletion will fail with the extra capabilities from nvim-cmp
  -- so force the use of nvim-cmp
  vim.keymap.set("i", "<C-x><C-o>", cmp.complete)
end

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
