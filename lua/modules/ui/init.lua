local M = {}

function M:apply_vim_settings()
  vim.cmd("colorscheme " .. pvim.ui.colorscheme)
end

return M
