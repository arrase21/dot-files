return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				"vim",
				"lua",
				"bash",
				"python",
				"sql",
				"php",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"http",
			},
			sync_install = false,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "php", "markdown", "rust", "python" },
			},
			rainbow = {
				enable = true,
				-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
				extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
				max_file_lines = nil, -- Do not enable for files with more than n lines, int
				-- colors = {}, -- table of hex strings
				-- termcolors = {} -- table of colour name strings
			},
			autotag = {
				enable = true,
			},
			incremental_selection = {
				enable = false,
				keymaps = {
					init_selection = "<CR>",
					scope_incremental = "<CR>",
					node_incremental = "<TAB>",
					node_decremental = "<S-TAB>",
				},
			},
			indent = {
				enable = true,
				--disable = { "python" },
			},
			tree_docs = {
				enable = true,
			},
		})
	end,
}
