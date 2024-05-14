return {
	{
		"nvimdev/lspsaga.nvim",
		config = true,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
		vim.keymap.set("n", "<leader>rn", "<CMD>:Lspsaga rename<CR>"),
	},

	{
		"kylechui/nvim-surround",
		event = { "BufReadPre", "BufNewFile" },
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = true,
	},
}
