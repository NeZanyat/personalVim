local M = {}
local helpers = require "pvim.helpers"
local dirs = require "pvim.dirs"

function M:get_provider_install_dir()
  return helpers:join_paths(dirs:get_runtime_dir(), "site", "pack", "packer", "start", "packer.nvim")
end

function M:get_provider_cache()
  return helpers:join_paths(dirs.get_cache_dir(), "plugin", "packer_compiled.lua")
end

function M:setup_vim_runtimepath()
  if os.getenv "PERSONALVIM_RUNTIME_DIR" then
    -- vim.opt.rtp:append(os.getenv "LUNARVIM_RUNTIME_DIR" .. path_sep .. "lvim")
    vim.opt.rtp:remove(helpers:join_paths(vim.fn.stdpath "data", "site"))
    vim.opt.rtp:remove(helpers:join_paths(vim.fn.stdpath "data", "site", "after"))
    vim.opt.rtp:prepend(helpers:join_paths(dirs.get_runtime_dir(), "site"))
    vim.opt.rtp:append(helpers:join_paths(dirs.get_runtime_dir(), "site", "after"))

    vim.opt.rtp:remove(vim.fn.stdpath "config")
    vim.opt.rtp:remove(helpers:join_paths(vim.fn.stdpath "config", "after"))
    vim.opt.rtp:prepend(dirs.get_config_dir())
    vim.opt.rtp:append(helpers:join_paths(dirs.get_config_dir(), "after"))
    -- TODO: we need something like this: vim.opt.packpath = vim.opt.rtp

    vim.cmd [[let &packpath = &runtimepath]]
  end
end

function M:install()
  self:setup_vim_runtimepath()
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

return M
