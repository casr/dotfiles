local r_builtin, builtin = pcall(require, "telescope.builtin")
local r_cmp, cmp = pcall(require, "cmp")

local augroup = vim.api.nvim_create_augroup("plugin_keymaps", {})
local opts = { silent = true }

vim.keymap.set("n", "<leader>di", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts)

if r_builtin then
  vim.keymap.set("n", "<leader>f/", builtin.current_buffer_fuzzy_find, opts)
  vim.keymap.set("n", "<leader>fF", function()
    builtin.find_files({ hidden = true })
  end, opts)
  vim.keymap.set("n", "<leader>fb", builtin.buffers, opts)
  vim.keymap.set("n", "<leader>fd", builtin.diagnostics, opts)
  vim.keymap.set("n", "<leader>ff", function()
    builtin.git_files({ show_untracked = true })
  end, opts)
  vim.keymap.set("n", "<leader>fg", builtin.live_grep, opts)
  vim.keymap.set("n", "<leader>fh", builtin.help_tags, opts)
  vim.keymap.set("n", "<leader>fq", builtin.quickfix, opts)
end

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

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, mapopts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, mapopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, mapopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, mapopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, mapopts)
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, mapopts)

    if r_builtin then
      vim.keymap.set("n", "gd", builtin.lsp_definitions, mapopts)
      vim.keymap.set("n", "gi", builtin.lsp_implementations, mapopts)
      vim.keymap.set("n", "gr", builtin.lsp_references, mapopts)
    else
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, mapopts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, mapopts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, mapopts)
    end
  end,
})
