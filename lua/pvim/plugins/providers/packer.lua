local M = {
  name = "packer.nvim",
}
local helpers = require "pvim.helpers"
local dirs = require "pvim.dirs"

function M:init_packer()
  local init_opts = {
    package_root = M:get_plugins_install_dir(),
    compile_path = M:get_provider_compile_path(),
    log = { level = "warn" },
    git = {
      clone_timeout = 300,
    },
  }
  local status_ok, packer = pcall(require, "packer")
  if status_ok then
    packer.init(init_opts)
    return packer
  end
  return false
end

function M:get_provider_install_dir()
  return helpers:join_paths(dirs:get_runtime_dir(), "site", "pack", "packer", "start", "packer.nvim")
end

function M:get_plugins_install_dir()
  return helpers:join_paths(dirs:get_runtime_dir(), "site", "pack")
end

function M:get_provider_compile_path()
  return helpers:join_paths(dirs:get_config_dir(), "plugin", "packer_compiled.lua")
end

function M:install()
  vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    self:get_provider_install_dir(),
  }
  vim.cmd "packadd packer.nvim"
end

function M:load()
  local packer = self:init_packer()
  if not packer then
    print "skipping loading plugins until Packer is installed"
    return
  end
  local status_ok, _ = xpcall(function()
    for _, plugin in ipairs(pvim.plugins) do
      packer.use(plugin)
    end
  end, debug.traceback)
  if not status_ok then
    print "Problem detected while loading plugins"
    print(debug.traceback())
    return
  end
end

return M
