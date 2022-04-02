local commit = {
  fixcursorhold = "1bfb32e7ba1344925ad815cb0d7f901dbc0ff7c1",
  lua_dev = "a0ee77789d9948adce64d98700cc90cecaef88d5",
  nvim_web_devicons = "4415d1aaa56f73b9c05795af84d625c610b05d3b",
  packer = "c576ab3f1488ee86d60fd340d01ade08dcabd256",
  plenary = "14dfb4071022b22e08384ee125a5607464b6d397",
  schemastore = "265eabf9f8ab33cc6bf1683c286b04e280a2b2e7",
  structlog = "6f1403a192791ff1fa7ac845a73de9e860f781f1",
  toggleterm = "e97d0c1046512e975a9f3fa95afe98f312752b1c",
  which_key = "a3c19ec5754debb7bf38a8404e36a9287b282430",
}

return {
  -- Packer can manage itself as an optional plugin
  { "wbthomason/packer.nvim", commit = commit.packer },
  { "antoinemadec/FixCursorHold.nvim", commit = commit.fixcursorhold }, -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
  { "Tastyep/structlog.nvim", commit = commit.structlog },

  { "nvim-lua/plenary.nvim", commit = commit.plenary },
  {
    "folke/lua-dev.nvim",
    module = "lua-dev",
    commit = commit.lua_dev,
  },
  -- Whichkey
  {
    "folke/which-key.nvim",
    commit = commit.which_key,
    config = function()
      require("pvim.core.plugins.settings.whichkey").setup()
    end,
    event = "BufWinEnter",
    disable = not pvim.core.which_key.active,
  },

  -- Icons
  { "kyazdani42/nvim-web-devicons", commit = commit.nvim_web_devicons },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    commit = commit.toggleterm,
    event = "BufWinEnter",
    config = function()
      require("pvim.core.plugins.settings.terminal").setup()
    end,
    disable = not pvim.core.terminal.active,
  },

  -- SchemaStore
  {
    "b0o/schemastore.nvim",
    commit = commit.schemastore,
  },
}
