local r_telescope, telescope = pcall(require, "telescope")

if not r_telescope then
  return
end

telescope.setup({
  defaults = {
    vimgrep_arguments = { "ag", "--hidden", "--silent", "--vimgrep" },
  },
})
