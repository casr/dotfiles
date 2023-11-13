local r_fzy, fzy = pcall(require, "fzy")

if not r_fzy then
  return
end

---@diagnostic disable-next-line: duplicate-set-field
function fzy.new_popup()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_keymap(buf, "t", "<ESC>", "<C-\\><C-c>", {})
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  local columns = vim.api.nvim_get_option("columns")
  local lines = vim.api.nvim_get_option("lines")
  local width = math.floor(columns * 0.9)
  local height = math.floor(lines * 0.6)
  local win_opts = {
    relative = "editor",
    style = "minimal",
    row = math.floor((lines - height) * 0.5) - 2,
    col = math.floor((columns - width) * 0.5),
    width = width,
    height = height,
    border = "rounded",
    title = " fzy ",
  }
  local win = vim.api.nvim_open_win(buf, true, win_opts)
  vim.api.nvim_win_set_option(
    win,
    "winhighlight",
    "NormalFloat:Normal,FloatBorder:Normal"
  )
  return win, buf
end
