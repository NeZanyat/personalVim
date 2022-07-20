local function add_user_plugin(plugin)
  table.insert(pvim.user.plugins, plugin)
end

return {
  plugins = {
    { "wbthomason/packer.nvim" },
  },
  user = {
    plugins = {},
  },
  use = add_user_plugin,
}
