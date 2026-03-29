local M = {}

local function get_lines(bufnr, start_lnum, end_lnum)
  return vim.api.nvim_buf_get_lines(bufnr, start_lnum - 1, end_lnum, false)
end

function M.detect(_, bufnr)
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  local max_lines = math.min(line_count, 10)
  local lines = get_lines(bufnr, 1, max_lines)

  for _, line in ipairs(lines) do
    if line:match("^!Current Configuration") then
      return "cisco"
    end

    if line:match("^! Last configuration change at") then
      return "cisco"
    end
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
