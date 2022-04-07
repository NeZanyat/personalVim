local helpers = require "pvim.helpers"
local M = {}

function M:init()
  for _, module in pairs(PVIM_MODULES) do
    pvim = helpers:apply_defaults(pvim, require("modules." .. module .. ".defaults"))
  end
end

return M
