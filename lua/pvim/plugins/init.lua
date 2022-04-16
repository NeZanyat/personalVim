local M = {}
local provider = require("pvim.plugins.providers." .. PLUGINS_PROVIDER)
local dirs = require "pvim.dirs"
local helpers = require "pvim.helpers"

function M:init()
  if vim.fn.empty(vim.fn.glob(provider:get_provider_install_dir())) == 1 then
    provider:install()
  end
end

function M:resolve_plugin_config(module_name, plugin_name)
  local user_config = helpers:join_paths(dirs:get_config_dir(), "plugins", plugin_name .. ".lua")

  if helpers:is_file(user_config) then
    return user_config
  else
    return helpers:join_paths(dirs:get_src_root(), "modules", module_name, "plugins", "settings", plugin_name .. ".lua")
  end
end

function M:exec_config(file_path)
  local ok, _ = pcall(dofile, file_path)
  if not ok then
    print("Invalid configuration file " .. file_path)
  end
end

function M:setup_plugin_config(module_name, plugin_name)
  local plugin_config_file = M:resolve_plugin_config(module_name, plugin_name)
  M:exec_config(plugin_config_file)
end

return M
