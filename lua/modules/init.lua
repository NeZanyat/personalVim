local helpers = require "pvim.helpers"
local M = {}

function M:collect_configuration()
  for _, module in pairs(PVIM_MODULES) do
    pvim = helpers:apply_defaults(pvim, require("modules." .. module .. ".defaults"))
  end
end

function M:collect_plugins()
  for _, module_name in pairs(PVIM_MODULES) do
    local module = require("modules." .. module_name .. ".plugins")
    for i, plugin in ipairs(module:get()) do
      table.insert(pvim.plugins, plugin)
    end
  end
end

function M:load_plugins()
  local provider = require("pvim.plugins.providers." .. PLUGINS_PROVIDER)
  provider:load()
end

function M:apply_vim_settings()
  for _, module_name in pairs(PVIM_MODULES) do
    local module = require("modules." .. module_name)
    module:apply_vim_settings()
  end
end

function M:init()
  M:collect_configuration()
  M:collect_plugins()
end

function M:load()
  M:load_plugins()
  M:apply_vim_settings()
end

return M
