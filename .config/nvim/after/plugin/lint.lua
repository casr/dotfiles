local r_lint, lint = pcall(require, "lint")

if not r_lint then
  return
end

lint.linters_by_ft = {
  bash = { "shellcheck" },
  gitcommit = { "commitlint" },
  css = { "stylelint" },
  javascript = { "eslint" },
  javascriptreact = { "eslint" },
  sass = { "stylelint" },
  scss = { "stylelint" },
  sh = { "shellcheck" },
  typescript = { "eslint" },
  typescriptreact = { "eslint" },
  yaml = { "actionlint" },
  zsh = { "shellcheck" },
}
