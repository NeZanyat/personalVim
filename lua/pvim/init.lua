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
    -- TODO: we need something like this: vim.opt.packpath = vim.opt.rtp

    vim.cmd [[let &packpath = &runtimepath]]
  end
end

function M:init()
  self:setup_vim_runtimepath()
  pvim = helpers:apply_defaults(pvim, require "pvim.defaults")

  require("pvim.plugins"):init()
end

return M
