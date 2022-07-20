local M = {}
local helpers = require "pvim.helpers"
local dirs = require "pvim.dirs"

function M:setup_vim_runtimepath()
  if os.getenv "PERSONALVIM_RUNTIME_DIR" then
    vim.opt.rtp:remove(helpers:join_paths(vim.fn.stdpath "data", "site"))
    vim.opt.rtp:remove(helpers:join_paths(vim.fn.stdpath "data", "site", "after"))
    vim.opt.rtp:prepend(helpers:join_paths(dirs:get_runtime_dir(), "site"))
    vim.opt.rtp:append(helpers:join_paths(dirs:get_runtime_dir(), "site", "after"))

    vim.opt.rtp:remove(vim.fn.stdpath "config")
    vim.opt.rtp:remove(helpers:join_paths(vim.fn.stdpath "config", "after"))
    vim.opt.rtp:prepend(dirs:get_config_dir())
    vim.opt.rtp:append(helpers:join_paths(dirs:get_config_dir(), "after"))

    vim.cmd [[let &packpath = &runtimepath]]
  end

  vim.fn.stdpath = function(what)
    if what == "cache" then
      return dirs:get_cache_dir()
    elseif what == "data" then
      return dirs:get_runtime_dir()
    elseif what == "config" then
      return dirs:get_config_dir()
    end
    return vim.call("stdpath", what)
  end
end

-- Loads and executes user configuration from config.lua
function M:load_user_config()
  local config_file = dirs:get_config_dir() .. "/config.lua"
  local ok, err = pcall(dofile, config_file)
  if not ok then
    if helpers:is_file(config_file) then
      print("Invalid configuration: " .. err)
    else
      print(string.format("Unable to find configuration file [%s]", config_file))
    end
  end
end

-- Updates vim runtimepath, inits plugin provider
function M:init()
  self:setup_vim_runtimepath()
  pvim = helpers:apply_defaults(pvim, require "pvim.defaults")

  require("pvim.plugins"):init()
end

return M
