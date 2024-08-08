local r_treesitter, treesitter = pcall(require, "nvim-treesitter.configs")

if not r_treesitter then
  return
end

treesitter.setup({
  parser_install_dir = vim.fn.stdpath("data") .. "/site",
  highlight = { enable = true },
  indent = { enable = true },
  modules = {},
  sync_install = true,
  auto_install = false,
  ensure_installed = {
    "bash",
    "css",
    "diff",
    "dockerfile",
    "editorconfig",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "glsl",
    "graphql",
    "hlsl",
    "html",
    "ini",
    "javascript",
    "jq",
    "jsdoc",
    "json",
    "jsonc",
    "ledger",
    "make",
    "python",
    "rust",
    "scss",
    "toml",
    "tsx",
    "typescript",
    "yaml",
  },
  ignore_install = {},
})
