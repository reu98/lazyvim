-- ~/.config/nvim/lua/plugins/extras.lua
return {
  -- Tự động đóng/rename HTML tag (React Native JSX)
  { "windwp/nvim-ts-autotag", event = "InsertEnter", opts = {} },

  -- Hiện màu inline cho hex/rgb trong code (#7aa2f7 → hiện ô màu)
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPost",
    opts = {
      filetypes = { "css", "scss", "html", "javascript", "typescript", "typescriptreact", "javascriptreact", "lua" },
      user_default_options = { tailwind = true },
    },
  },

  -- Package.json: hiện version mới nhất inline
  {
    "vuki656/package-info.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    ft = "json",
    opts = {},
  },
}
