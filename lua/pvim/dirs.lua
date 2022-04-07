local M = {}

function M:get_config_dir()
  local pvim_config_dir = os.getenv "PERSONALVIM_CONFIG_DIR"
  if not pvim_config_dir then
    return vim.fn.stdpath "config"
  end
  return pvim_config_dir
end

function M:get_runtime_dir()
  local pvim_runtime_dir = os.getenv "PERSONALVIM_RUNTIME_DIR"
  if not pvim_runtime_dir then
    return vim.fn.stdpath "config"
  end
  return pvim_runtime_dir
end

function M:get_cache_dir()
  local pvim_cache_dir = os.getenv "PERSONALVIM_CACHE_DIR"
  if not pvim_cache_dir then
    return vim.fn.stdpath "config"
  end
  return pvim_cache_dir
end

return M
