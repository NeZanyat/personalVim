_G.PVIM_MODULES = {
  "ui",
}
_G.PLUGINS_PROVIDER = "packer"
_G.pvim = {}

local init_path = debug.getinfo(1, "S").source:sub(2)
local base_dir = init_path:match("(.*[/\\])"):sub(1, -2)

if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) then
  vim.opt.rtp:append(base_dir)
end

require("pvim"):init()
require("modules"):init()
require("pvim"):load_user_config()
require("modules"):load()
