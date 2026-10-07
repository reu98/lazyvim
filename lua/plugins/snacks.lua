-- Snacks.nvim — file picker & explorer config
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          include = {
            "node_modules",
            ".env*",
            "*.yaml",
            ".dev.vars",
            "specs",
          },
        },
        files = {
          include = {
            ".env*",
            "*.yaml",
            ".dev.vars",
          },
        },
        grep = {
          include = {
            ".env*",
            "*.yaml",
            ".dev.vars",
            "specs",
          },
        },
      },
    },
    image = {
      enabled = true,
    },
  },
}
