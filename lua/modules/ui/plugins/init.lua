local M = {}

function M:get()
  return {
    {
      "cpea2506/one_monokai.nvim",
      config = function()
        require("pvim.plugins"):setup_plugin_config("ui", "one_monokai")
      end,
    },
  }
end

return M
