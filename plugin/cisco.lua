if vim.g.loaded_cisco_nvim then
  return
end

vim.g.loaded_cisco_nvim = 1

require("cisco.filetype").register()

local augroup = vim.api.nvim_create_augroup("cisco_nvim", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "cisco",
  callback = function()
    require("cisco.syntax").apply()
  end,
})
