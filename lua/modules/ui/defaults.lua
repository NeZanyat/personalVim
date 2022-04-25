return {
  ui = {
    colorscheme = "desert",
    one_monokai = {
      transparent = true,
    },
    nvimtree = {
      open_on_setup = true,
      view = {
        mappings = {
          list = {
            { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
            { key = "h", action = "close_node" },
            { key = "v", action = "vsplit" },
            { key = "C", action = "cd" },
          },
        },
      },
    },
  },
}
