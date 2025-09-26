local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_args = vim.fn.argc(-1) > 0 and now or later


later(function()
  add('mason-org/mason.nvim')
  require('mason').setup({
			ui = {
				icons = {
					package_installed = " ",
					package_pending = "➜",
					package_uninstalled = " ",
				},
			},
  })
end)
