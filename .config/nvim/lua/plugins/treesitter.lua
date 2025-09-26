local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_args = vim.fn.argc(-1) > 0 and now or later

now_if_args(function()
  add({ source = "nvim-treesitter/nvim-treesitter" })

  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "lua",
      "go",
    },
    indent = {
      enable = true,
    },
    highlight = {
      enable = true,
      disable = function(_, buf)
        local max_filesize = 50 * 1024 -- 50 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
    auto_install = true,
  })
end)

