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

local timer = assert(vim.uv.new_timer())
local DEBOUNCE_MS = 400

vim.api.nvim_create_autocmd(
  { "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" },
  {
    group = augroup,
    callback = function(args)
      timer:stop()
      timer:start(
        DEBOUNCE_MS,
        0,
        vim.schedule_wrap(function()
          if not vim.api.nvim_buf_is_valid(args.buf) then
            return
          end

          local names = lint._resolve_linter_by_ft(vim.bo[args.buf].filetype)
          names = vim.tbl_filter(function(name)
            local linter = lint.linters[name]
            assert(linter, "nvim-lint: linter not found " .. name)
            local cmd = type(linter.cmd) == "function" and linter.cmd()
              or linter.cmd
            if vim.fn.exepath(cmd) == "" then
              vim.notify_once("nvim-lint: cannot find executable " .. cmd)
              return false
            end
            return true
          end, names)

          local opts = { ignore_errors = args.event ~= "BufWritePost" }

          local clients = vim.lsp.get_clients({ bufnr = 0 })
          local key, client = next(clients)
          while key do
            assert(client)
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

          vim.api.nvim_buf_call(args.buf, function()
            lint.try_lint(names, opts)
          end)
        end)
      )
    end,
  }
)
