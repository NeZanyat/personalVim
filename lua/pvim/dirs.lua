local helpers = require "pvim.helpers"
local M = {}

function M:get_config_dir()
  local pvim_config_dir = os.getenv "PERSONALVIM_CONFIG_DIR"
  if not pvim_config_dir then
    return vim.call("stdpath", "config")
  end
  return pvim_config_dir
end

function M:get_runtime_dir()
  local pvim_runtime_dir = os.getenv "PERSONALVIM_RUNTIME_DIR"
  if not pvim_runtime_dir then
    return vim.call("stdpath", "data")
  end
  return pvim_runtime_dir
end

function M:get_cache_dir()
  local pvim_cache_dir = os.getenv "PERSONALVIM_CACHE_DIR"
  if not pvim_cache_dir then
    return vim.call("stdpath", "cache")
  end
  return pvim_cache_dir
end

function M:get_src_root()
  local pvim_runtime_dir = M:get_runtime_dir()

  return helpers:join_paths(pvim_runtime_dir, "pvim", "lua")
end

return M
