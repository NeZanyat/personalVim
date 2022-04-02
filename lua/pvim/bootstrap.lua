local M = {}

if vim.fn.has "nvim-0.6.1" ~= 1 then
  vim.notify("Please upgrade your Neovim base installation. personalVim requires v0.6.1+", vim.log.levels.WARN)
  vim.wait(5000, function()
    return false
  end)
  vim.cmd "cquit"
end

local uv = vim.loop
local path_sep = uv.os_uname().version:match "Windows" and "\\" or "/"
local in_headless = #vim.api.nvim_list_uis() == 0

---Join path segments that were passed as input
---@return string
function _G.join_paths(...)
  local result = table.concat({ ... }, path_sep)
  return result
end

---Require a module in protected mode without relying on its cached value
---@param module string
---@return any
function _G.require_clean(module)
  package.loaded[module] = nil
  _G[module] = nil
  local _, requested = pcall(require, module)
  return requested
end

---Get the full path to `$PERSONALVIM_RUNTIME_DIR`
---@return string
function _G.get_runtime_dir()
  local pvim_runtime_dir = os.getenv "PERSONALVIM_RUNTIME_DIR"
  if not pvim_runtime_dir then
    -- when nvim is used directly
    return vim.fn.stdpath "data"
  end
  return pvim_runtime_dir
end

---Get the full path to `$PERSONALVIM_CONFIG_DIR`
---@return string
function _G.get_config_dir()
  local pvim_config_dir = os.getenv "PERSONALVIM_CONFIG_DIR"
  if not pvim_config_dir then
    return vim.fn.stdpath "config"
  end
  return pvim_config_dir
end

---Get the full path to `$PERSONALVIM_CACHE_DIR`
---@return string
function _G.get_cache_dir()
  local pvim_cache_dir = os.getenv "PERSONALVIM_CACHE_DIR"
  if not pvim_cache_dir then
    return vim.fn.stdpath "cache"
  end
  return pvim_cache_dir
end

---Initialize the `&runtimepath` variables and prepare for startup
---@return table
function M:init(base_dir)
  self.runtime_dir = get_runtime_dir()
  self.config_dir = get_config_dir()
  self.cache_dir = get_cache_dir()
  self.pack_dir = join_paths(self.runtime_dir, "site", "pack")
  self.packer_install_dir = join_paths(self.runtime_dir, "site", "pack", "packer", "start", "packer.nvim")
  self.packer_cache_path = join_paths(self.config_dir, "plugin", "packer_compiled.lua")

  ---Get the full path to personalVim's base directory
  ---@return string
  function _G.get_pvim_base_dir()
    return base_dir
  end

  if os.getenv "PERSONALVIM_RUNTIME_DIR" then
    vim.opt.rtp:remove(join_paths(vim.fn.stdpath "data", "site"))
    vim.opt.rtp:remove(join_paths(vim.fn.stdpath "data", "site", "after"))
    vim.opt.rtp:prepend(join_paths(self.runtime_dir, "site"))
    vim.opt.rtp:append(join_paths(self.runtime_dir, "site", "after"))

    vim.opt.rtp:remove(vim.fn.stdpath "config")
    vim.opt.rtp:remove(join_paths(vim.fn.stdpath "config", "after"))
    vim.opt.rtp:prepend(self.config_dir)
    vim.opt.rtp:append(join_paths(self.config_dir, "after"))

    vim.cmd [[let &packpath = &runtimepath]]
  end

  return self
end

function M:init_modules()
  for _, module in ipairs(PVIM_MODULES) do
    require(module):init()
  end
end

function M:load_modules()
  for _, module in ipairs(PVIM_MODULES) do
    require(module):load()
  end
end

return M
