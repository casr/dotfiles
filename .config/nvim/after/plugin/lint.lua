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
    callback = function(args)
      local opts = { ignore_errors = args.event ~= "BufWritePost" }

      local clients = vim.lsp.get_clients({ bufnr = 0 })
      local key, client = next(clients)
      while key do
        if client.workspace_folders then
          for _, dir in pairs(client.workspace_folders) do
            if vim.fs.relpath(dir.name, vim.api.nvim_buf_get_name(0)) then
              opts.cwd = dir.name
            end
          end
        elseif client.root_dir then
          opts.cwd = client.root_dir
        end
        if opts.cwd then
          break
        end
        key, client = next(clients, key)
      end

      lint.try_lint(nil, opts)
    end,
  }
)
