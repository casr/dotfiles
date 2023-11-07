local r_cmp, cmp = pcall(require, "cmp")
local r_snippy, snippy = pcall(require, "snippy")

if not (r_cmp and r_snippy) then
  return
end

-- @return boolean
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  -- stylua: ignore
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif snippy.can_expand_or_advance() then
        snippy.expand_or_advance()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif snippy.can_jump(-1) then
        snippy.previous()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  snippet = {
    expand = function(args)
      snippy.expand_snippet(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "snippy" },
  }, {
    { name = "buffer" },
    { name = "emoji" },
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "emoji" },
  }),
})
