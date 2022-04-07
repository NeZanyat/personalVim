local M = {}
local provider = require("pvim.plugins.providers." .. PLUGINS_PROVIDER)

function M:init()
  if vim.fn.empty(vim.fn.glob(provider:get_provider_install_dir())) == 1 then
    provider:install()
  end
end

return M
