local M = {}

function M:init_core_plugins()
  local config = require "pvim.core.config"

  pvim = config.apply_defaults(pvim, {
    core = {
      which_key = require("pvim.core.plugins.settings.whichkey"):defaults(),
      terminal = require("pvim.core.plugins.settings.terminal"):defaults(),
    },
  })
end

function M:init()
  self.init_core_plugins()
  -- TODO: that should be extracted to upper level for consistency beetween modules
  require("pvim.core.plugins.loader").init {
    package_root = dirs.pack_dir,
    install_path = dirs.packer_install_dir,
  }
end

function M:load()
  -- TODO: that should be extracted to upper level for consistency beetween modules
  local plugins = {}
  for _, module in ipairs(PVIM_MODULES) do
    plugins = vim.list_extend(plugins, require(module .. ".plugins.registry"))
  end
  plugins = vim.list_extend(plugins, pvim.plugins)

  require("pvim.core.plugins.loader").load { plugins }
end

return M
