local M = {}
local helpers = require "pvim.helpers"

function M:init()
  pvim = helpers:apply_defaults(pvim, require "pvim.defaults")
  require("pvim.plugins"):init()
end

return M
