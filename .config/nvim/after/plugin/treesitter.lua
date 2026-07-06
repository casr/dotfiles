local r_treesitter, treesitter = pcall(require, "nvim-treesitter")

if not r_treesitter then
  return
end

local augroup = vim.api.nvim_create_augroup("after_plugin_treesitter", {})

local ts_langs = {
  "bash",
  "c",
  "cpp",
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
  "ledger",
  "lua",
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
  "vim",
  "vimdoc",
  "yaml",
}

if vim.fn.executable("tree-sitter") then
  treesitter.install(ts_langs):wait()
end

local ts_filetypes =
  vim.tbl_map(vim.treesitter.language.get_filetypes, ts_langs)
local ts_filetypes_flat = vim.iter(ts_filetypes):flatten():totable()

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = ts_filetypes_flat,
  callback = function(ev)
    if not ev.match then
      return
    end
    local lang = vim.treesitter.language.get_lang(ev.match)
    if not lang then
      return
    end
    vim.treesitter.start(ev.buf, lang)
    if vim.treesitter.query.get(lang, "folds") ~= nil then
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo.foldmethod = "expr"
    end
  end,
})
