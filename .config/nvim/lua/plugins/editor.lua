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
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
		keys = {
			{ "<leader>tb", ":DBUIToggle<cr>", mode = "n" },
		},
	},
	{
		"aznhe21/actions-preview.nvim",
		config = function()
			vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
		end,
	},
	{
		"rmagatti/goto-preview",
		-- event = "VeryLazy",
		keys = {

			{
				"<leader>pd",
				function()
					require("goto-preview").goto_preview_definition()
				end,
				{ desc = "Preview Definition", silent = true },
			},
			{
				"<leader>pt",
				function()
					require("goto-preview").goto_preview_type_definition()
				end,
				{ desc = "Preview Type Definition", silent = true },
			},
			{
				"<leader>pi",
				function()
					require("goto-preview").goto_preview_type_definition()
				end,
				{ desc = "Preview Implementation", silent = true },
			},
			{
				"<leader>pr",
				function()
					require("goto-preview").goto_preview_references()
				end,
				{ desc = "Preview References", silent = true },
			},
			{
				"<leader>pc",
				function()
					require("goto-preview").close_all_win()
				end,
				{ desc = "Close Previews", silent = true },
			},
		},
		config = function()
			require("goto-preview").setup()
		end,
	},
	-- { -- This plugin
	-- 	"Zeioth/compiler.nvim",
	-- 	cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
	-- 	dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
	-- 	opts = {},
	-- 	keys = {
	-- 		{ "<F6>", "<cmd>CompilerOpen<cr>", mode = "n" },
	-- 		{ "<F3>", "<cmd>CompilerStop<cr>" .. "<cmd>CompilerRedo", mode = "n" },
	-- 		{ "<F7>", "<cmd>CompilerToggleResults<cr>", mode = "n" },
	-- 	},
	-- },
	-- { -- The task runner we use
	-- 	"stevearc/overseer.nvim",
	-- 	commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
	-- 	cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
	-- 	opts = {
	-- 		task_list = {
	-- 			direction = "top",
	-- 			min_height = 25,
	-- 			max_height = 25,
	-- 			default_detail = 1,
	-- 		},
	-- 	},
	-- },
}
