local r_treesitter, treesitter = pcall(require, "nvim-treesitter.configs")

if not r_treesitter then
  return
end

treesitter.setup({
  highlight = { enable = true },
  indent = { enable = true },
  sync_install = true,
  parser_install_dir = vim.fn.stdpath("data") .. "/site",
  ensure_installed = {
    "bash",
    "css",
    "diff",
    "dockerfile",
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
    "json5",
    "jsonc",
    "ledger",
    "make",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "rust",
    "scss",
    "toml",
    "tsx",
    "typescript",
    "yaml",
  },
})
