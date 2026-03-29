local M = {}

local function assert_eq(actual, expected, label)
  if actual ~= expected then
    error(string.format("%s: expected %q, got %q", label, expected, actual))
  end
end

local function write_file(path, lines)
  vim.fn.writefile(lines, path)
end

local function with_temp_file(lines, suffix, fn)
  local path = vim.fn.tempname() .. (suffix or "")
  write_file(path, lines)
  local ok, err = pcall(fn, path)
  vim.fn.delete(path)
  if not ok then
    error(err)
  end
end

local function open_file(path)
  vim.cmd("silent edit " .. vim.fn.fnameescape(path))
end

local function test_extension_detection()
  with_temp_file({ "hostname switch-1" }, ".cisco", function(path)
    open_file(path)
    assert_eq(vim.bo.filetype, "cisco", "extension detection")
  end)
end

local function test_content_detection_first_line()
  with_temp_file({ "!Current Configuration", "hostname switch-1" }, "", function(path)
    open_file(path)
    assert_eq(vim.bo.filetype, "cisco", "content detection first line")
  end)
end

local function test_content_detection_second_line()
  with_temp_file({ "!", "! Last configuration change at 12:00:00 UTC Mon Mar 01 2026" }, "", function(path)
    open_file(path)
    assert_eq(vim.bo.filetype, "cisco", "content detection second line")
  end)
end

local function test_syntax_applied()
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(bufnr)
  vim.bo[bufnr].filetype = "cisco"
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "interface Ethernet1/1" })
  vim.cmd("doautocmd <nomodeline> FileType")
  assert_eq(vim.b[bufnr].current_syntax, "cisco", "syntax setup")
end

function M.run()
  test_extension_detection()
  test_content_detection_first_line()
  test_content_detection_second_line()
  test_syntax_applied()
  print("cisco.nvim tests: OK")
end

return M
