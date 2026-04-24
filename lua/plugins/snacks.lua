-- ~/.config/nvim/lua/plugins/snacks.lua
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          include = {
            "node_modules",
            ".env",
            "*.yaml",
          },
        },
        files = {
          include = {
            ".env",
            "*.yaml",
          },
        },
        grep = {
          include = {
            ".env",
            "*.yaml",
          },
        },
      },
    },
  },
}
