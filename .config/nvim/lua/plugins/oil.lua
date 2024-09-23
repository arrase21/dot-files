return {
  'stevearc/oil.nvim',
  opts = {
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }),
    vim.keymap.set("n", "<leader>-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" }),
    vim.keymap.set("n", "<leader>--", "<CMD>bd<CR>", { desc = "Open parent directory" })
  },
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
}
