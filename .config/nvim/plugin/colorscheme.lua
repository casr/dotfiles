local augroup = vim.api.nvim_create_augroup("plugin_colorscheme", {})

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  pattern = "chromatine",
  group = augroup,
  callback = function()
    vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
    vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
    vim.api.nvim_set_hl(0, "CmpItemAbbr", { link = "Comment" })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { link = "Normal" })
  end,
})

local cmd = { "get_interface_style" }

-- determine the current system interface style
--
-- @return "dark" | "light"
local function get_background_color()
  return vim.fn.trim(vim.fn.system(cmd))
end

-- @type "dark" | "light"
local last_background = get_background_color()

vim.opt.background = last_background
pcall(vim.cmd.colorscheme, "chromatine")

vim.api.nvim_create_autocmd({ "FocusGained" }, {
  group = augroup,
  callback = function()
    local bg = get_background_color()
    -- Only adjust the background automatically if the interface style is
    -- different to a previous invocation. This allows for this setting to be
    -- manually overridden.
    if last_background ~= bg then
      last_background = bg
      vim.opt.background = bg
    end
  end,
  -- Upon setting background, allow the ColorScheme autocmd to run afterwards
  nested = true,
})
