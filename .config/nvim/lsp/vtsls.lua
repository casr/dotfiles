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

return {
  cmd = { "vtsls", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
  },
  root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
  settings = {
    typescript = vim.tbl_extend("force", inlayHints, {}),
    javascript = vim.tbl_extend("force", inlayHints, {}),
  },
}
