local M = {}

function M:defaults()
  return {}
end

function M:setup()
  local which_key = require "which-key"

  which_key.setup(pvim.core.which_key.setup)

  local opts = pvim.core.which_key.opts
  local vopts = pvim.core.which_key.vopts

  local mappings = pvim.core.which_key.mappings
  local vmappings = pvim.core.which_key.vmappings

  which_key.register(mappings, opts)
  which_key.register(vmappings, vopts)
end

return M
