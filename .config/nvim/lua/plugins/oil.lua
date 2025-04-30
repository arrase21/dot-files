return {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  opts = {
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name, _)
        return name == "node_modules" or name == ".git"
      end,
    },
    keymaps = {
      vim.keymap.set("n", "<leader>o", "<CMD>Oil --float<CR>", { desc = "Open parent directory" }),
      ["<c-c>"] = false,
      ["q"] = "actions.close",
    },
  },
}
