return {
	{
		"Exafunction/codeium.nvim",
		event = "BufEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
		end,
	},
}

-- return {
-- 	"leocus/codeassistant.vim",
-- }

-- return {
-- 	{
-- 		"codota/tabnine-nvim",
-- 		build = "./dl_binaries.sh",
-- 		event = "BufEnter",
-- 		config = function()
-- 			local tabnine = require("tabnine")
-- 			tabnine.setup({
-- 				disable_auto_comment = true,
-- 				accept_keymap = "<Tab>",
-- 				dismiss_keymap = "<C-]>",
-- 				debounce_ms = 800,
-- 				suggestion_color = { gui = "#808080", cterm = 244 },
-- 				exclude_filetypes = { "TelescopePrompt", "NvimTree" },
-- 				log_file_path = nil, -- absolute path to Tabnine log file
-- 			})
-- 		end,
-- 	},
-- }
