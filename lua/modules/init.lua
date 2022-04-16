local helpers = require "pvim.helpers"
local M = {}

function M:collect_configuration()
  for _, module in pairs(PVIM_MODULES) do
    pvim = helpers:apply_defaults(pvim, require("modules." .. module .. ".defaults"))
  end
end

function M:collect_plugins()
  for _, module in pairs(PVIM_MODULES) do
    local module = require("modules." .. module .. ".plugins")
    pvim.plugins = helpers:apply_defaults(pvim.plugins, module:get())
  end
end

function M:init()
  M:collect_configuration()
  M:collect_plugins()
end

return M
