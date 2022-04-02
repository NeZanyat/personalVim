local M = {}

function M:init()
  require("pvim.core.config"):init()
  require("pvim.core.plugins"):init()
end

function M:load()
  require("pvim.core.config"):load()
  require("pvim.core.plugins"):load()
end

return M
