_G.PVIM_MODULES = {
  "pvim.core",
}

local init_path = debug.getinfo(1, "S").source:sub(2)
local base_dir = init_path:match("(.*[/\\])"):sub(1, -2)

if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) then
  vim.opt.rtp:append(base_dir)
end

local bootstrap = require "pvim.bootstrap"

_G.dirs = bootstrap:init(base_dir)

bootstrap:init_modules()
bootstrap:load_modules()
