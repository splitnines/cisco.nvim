local M = {}

local function get_line(bufnr, lnum)
  return (vim.api.nvim_buf_get_lines(bufnr, lnum - 1, lnum, false)[1] or "")
end

function M.detect(_, bufnr)
  local firstline = get_line(bufnr, 1)
  local secondline = get_line(bufnr, 2)

  if firstline:match("^!Current Configuration") then
    return "cisco"
  end

  if secondline:match("^! Last configuration change at") then
    return "cisco"
  end

  return nil
end

function M.register()
  vim.filetype.add({
    extension = {
      cisco = "cisco",
    },
    pattern = {
      [".*"] = M.detect,
    },
  })
end

return M
