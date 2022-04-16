local M = {}

local uv = vim.loop
local path_sep = uv.os_uname().version:match "Windows" and "\\" or "/"

function M:apply_defaults(config, defaults)
  local result = vim.tbl_extend("keep", config, defaults)

  return result
end

function M:join_paths(...)
  local result = table.concat({ ... }, path_sep)
  return result
end

function M:is_file(path)
  local stat = uv.fs_stat(path)
  return stat and stat.type == "file" or false
end

return M
