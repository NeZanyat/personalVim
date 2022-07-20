local helpers = require "pvim.helpers"
local M = {}

function M:collect_configuration()
  for _, module in pairs(PVIM_MODULES) do
    pvim = helpers:apply_defaults(pvim, require("modules." .. module .. ".defaults"))
  end
end

-- Iterates over modules from global `PVIM_MODULES` variable and adds them to `pvim.plugins`
function M:collect_plugins()
  for _, module_name in pairs(PVIM_MODULES) do
    local module = require("modules." .. module_name .. ".plugins")
    for _, plugin in ipairs(module:get()) do
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

-- Collects default configuration into `pvim` variable
-- Collects plugins from modules
function M:init()
  M:collect_configuration()
  M:collect_plugins()
end

-- Loads plugins into runtime
-- Applies vim settings from global `pvim` variable
function M:load()
  M:load_plugins()
  M:apply_vim_settings()
end

return M
