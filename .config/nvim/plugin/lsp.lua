local inlayHints = {
  inlayHints = {
    parameterNames = { enabled = "all" },
    parameterTypes = { enabled = true },
    variableTypes = { enabled = true },
    propertyDeclarationTypes = { enabled = true },
    functionLikeReturnTypes = { enabled = true },
    enumMemberValues = { enabled = true },
  },
}

vim.lsp.config("vtsls", {
  settings = {
    typescript = vim.tbl_extend("force", inlayHints, {}),
    javascript = vim.tbl_extend("force", inlayHints, {}),
  },
})
