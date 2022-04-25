local M = {}

function M:get()
  return {
    {
      "cpea2506/one_monokai.nvim",
      config = function()
        require("pvim.plugins"):setup_plugin_config("ui", "one_monokai")
      end,
    },
    {
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons", -- optional, for file icon
      },
      config = function()
        require("pvim.plugins"):setup_plugin_config("ui", "nvim-tree")
      end,
    },
  }
end

return M
