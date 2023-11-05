--- return info about the window
--- @param winid number
--- @return { winid: number, type: string, filewinid: number }
local get_win_info = function(winid)
  local filewinid = vim.fn.getloclist(winid, { filewinid = 1 })["filewinid"]
  return {
    winid = winid,
    type = vim.fn.win_gettype(winid),
    filewinid = filewinid > 0 and filewinid or nil,
  }
end

--- toggle a list
--- @param list_kind "loclist"|"quickfix"
--- @return nil
local function toggle_list(list_kind)
  local cur_win = get_win_info(vim.api.nvim_get_current_win())

  if cur_win.type == list_kind then
    if cur_win.filewinid then
      vim.api.nvim_set_current_win(cur_win.filewinid)
    end
    vim.api.nvim_win_close(cur_win.winid, false)
  else
    -- toggle it
    local wins = vim.api.nvim_tabpage_list_wins(0)
    local list_winid = nil
    for _, winid in pairs(wins) do
      local other_win = get_win_info(winid)
      if other_win.type == list_kind then
        if
          list_kind == "loclist" and other_win.filewinid == cur_win.winid
          or list_kind == "quickfix"
        then
          list_winid = winid
          break
        end
      end
    end

    if list_winid then
      vim.api.nvim_win_close(list_winid, false)
    else
      if list_kind == "loclist" then
        local length = 0
        for _, _ in pairs(vim.fn.getloclist(0)) do
          length = length + 1
        end
        if length > 0 then
          vim.cmd([[ lopen ]])
        else
          print("Location list is empty")
        end
      else
        vim.cmd([[ copen ]])
      end
    end
  end
end

local opts = { silent = true }

vim.keymap.set("n", "<leader>q", function()
  toggle_list("quickfix")
end, opts)
vim.keymap.set("n", "<leader>l", function()
  toggle_list("loclist")
end, opts)
