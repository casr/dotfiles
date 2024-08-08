vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.HINT] = "•",
      [vim.diagnostic.severity.INFO] = "⊙",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.ERROR] = "✖︎",
    },
  },
  float = {
    border = "rounded",
    source = true,
    width = 60,
  },
  severity_sort = true,
})

local ns = vim.api.nvim_create_namespace("single_sign")

local orig_signs_handler = vim.diagnostic.handlers.signs

vim.diagnostic.handlers.signs = {
  show = function(_, bufnr, _, opts)
    local diagnostics = vim.diagnostic.get(bufnr)

    local max_severity_per_line = {}
    for _, d in pairs(diagnostics) do
      local m = max_severity_per_line[d.lnum]
      if not m or d.severity < m.severity then
        max_severity_per_line[d.lnum] = d
      end
    end

    local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
    orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
  end,
  hide = function(_, bufnr)
    orig_signs_handler.hide(ns, bufnr)
  end,
}
