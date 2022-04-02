local utils = require"pvim.core.utils"
local Log = require"pvim.core.log"

local M = {}
local user_config_dir = get_config_dir()
local user_config_file = utils.join_paths(user_config_dir, "config.lua")

function M:get_user_config_path()
  return user_config_file
end

local function apply_defaults(configs, defaults)
  configs = configs or {}
  return vim.tbl_deep_extend("keep", configs, defaults)
end

function M:init()
  if vim.tbl_isempty(pvim or {}) then
    pvim = vim.deepcopy(require "pvim.core.config.defaults")
  end
end

--- Override the configuration with a user provided one
-- @param config_path The path to the configuration overrides
function M:load(config_path)
  config_path = config_path or self.get_user_config_path()
  local ok, err = pcall(dofile, config_path)
  if not ok then
    if utils.is_file(user_config_file) then
      Log:warn("Invalid configuration: " .. err)
    else
      Log:warn(string.format("Unable to find configuration file [%s]", config_path))
    end
  end
end

return M
