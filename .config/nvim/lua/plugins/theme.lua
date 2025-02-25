-- return {
--   {
--     "folke/tokyonight.nvim",
--     event = { "VeryLazy" },
--     priority = 1000,
--     opts = {
--       style = "moon",
--     },
--   },
-- }

return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
      }
    end,
  },
}
