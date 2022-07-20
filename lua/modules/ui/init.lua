local M = {}

function M:apply_vim_settings()
  if pvim.ui.colorscheme then
    vim.g.colors_name = pvim.ui.colorscheme
    vim.api.nvim_command("colorscheme " .. pvim.ui.colorscheme)
  end
end

return M
