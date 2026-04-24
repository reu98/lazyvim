return {
  "evanmcpheron/rocketlog.nvim",
  event = "VeryLazy",
  config = function()
    require("rocketlog").setup({
      label = "DEBUG",
    })
  end,
}
