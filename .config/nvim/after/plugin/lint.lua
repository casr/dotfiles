local r_lint, lint = pcall(require, "lint")

if not r_lint then
  return
end

local augroup = vim.api.nvim_create_augroup("after_plugin_lint", {})

lint.linters_by_ft = {
  bash = { "shellcheck" },
  gitcommit = { "commitlint" },
  css = { "stylelint" },
  javascript = { "eslint" },
  javascriptreact = { "eslint" },
  lua = { "luacheck" },
  sass = { "stylelint" },
  scss = { "stylelint" },
  sh = { "shellcheck" },
  typescript = { "eslint" },
  typescriptreact = { "eslint" },
  yaml = { "actionlint" },
}

vim.api.nvim_create_autocmd(
  { "BufReadPost", "BufWritePost", "InsertLeave", "TextChanged" },
  {
    group = augroup,
    callback = function()
      lint.try_lint(nil, { ignore_errors = true })
    end,
  }
)
