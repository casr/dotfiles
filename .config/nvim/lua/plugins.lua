local packer_bootstrap = nil
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system(
    { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  )
  vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
  local augroup = vim.api.nvim_create_augroup("plugins_autocmd", {})

  use "wbthomason/packer.nvim"

  use "AndrewRadev/splitjoin.vim"
  use "editorconfig/editorconfig-vim"
  use "casr/vim-colors-chromatine"
  use {
    "ledger/vim-ledger",
    config = function()
      vim.g.ledger_maxwidth = 61
      vim.g.ledger_fold_blanks = 1
      vim.g.ledger_align_at = 58
      vim.g.ledger_default_commodity = "GBP"
      vim.g.ledger_commodity_before = 0
      vim.g.ledger_commodity_sep = " "

      vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        pattern = "ledger",
        callback = function(args)
          vim.wo.foldenable = true
          vim.wo.foldcolumn = "2"
          vim.wo.foldmethod = "syntax"
          vim.keymap.set("n", "<leader>f", ":LedgerAlign<CR>", { silent = true, buffer = args.buf })
        end
      })
    end,
  }
  use {
    "mhinz/vim-signify",
    config = function()
      vim.g.signify_sign_add = "＋"
      vim.g.signify_sign_delete = "－"
      vim.g.signify_sign_delete_first_line = "－"
      vim.g.signify_sign_change = "～"
      vim.g.signify_sign_change_delete = "～"
    end
  }
  use "reedes/vim-pencil"
  use {
    "srstevenson/vim-picker",
    config = function()
      vim.keymap.set("n", "<leader>t", "<Plug>(PickerEdit)")
      vim.keymap.set("n", "<leader>s", "<Plug>(PickerVsplit)")
      vim.keymap.set("n", "<leader>b", "<Plug>(PickerBuffer)")
    end
  }
  use "tmhedberg/SimpylFold"
  use "tpope/vim-commentary"
  use "tpope/vim-apathy"
  use "tpope/vim-eunuch"
  use "tpope/vim-fugitive"
  use { "tpope/vim-rhubarb", requires = { "tpope/vim-fugitive" } }
  use "tpope/vim-rsi"
  use "tpope/vim-surround"
  use "tpope/vim-unimpaired"

  use {
    "hrsh7th/nvim-cmp",
    requires = {
      { "L3MON4D3/LuaSnip", requires = { "rafamadriz/friendly-snippets" } },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require "cmp"
      local luasnip = require "luasnip"
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = cmp.config.sources {
          { name = "luasnip" },
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "emoji" },
        }
      }

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources {
          { name = "path" },
          { name = "cmdline" },
        },
      })

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources {
          { name = "luasnip" },
          { name = "emoji" },
        }
      })
    end
  }

  use {
    "neovim/nvim-lspconfig",
    requires = "hrsh7th/cmp-nvim-lsp",
    config = function()
      local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

      local lsp_attach = function(args)
        vim.api.nvim_buf_set_option(args.buf, "omnifunc", "v:lua.vim.lsp.omnifunc")

        local mapopts = { silent = true, buffer = args.buf }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, mapopts)
        vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, mapopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, mapopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, mapopts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, mapopts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, mapopts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, mapopts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, mapopts)
        vim.keymap.set("n", "<leader>f", vim.lsp.buf.formatting, mapopts)
      end

      -- wrap around on_attach as this is changing in a later version of Neovim
      local on_attach = function(_, buf)
        lsp_attach({ buf = buf })
      end

      local lspconfig = require "lspconfig"

      local servers = { "pyright", "sourcekit", "tsserver" }
      for _, lsp in pairs(servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end

      lspconfig["sumneko_lua"].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
          },
        },
      }
    end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
