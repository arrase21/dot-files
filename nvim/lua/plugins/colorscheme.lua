-- return {
--   {
--     "craftzdog/solarized-osaka.nvim",
--     lazy = true,
--     priority = 1000,
--     opts = function()
--       return {
--         transparent = true,
--       }
--     end,
--   },
-- }
return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		event = "VeryLazy",
		priority = 1000,
		opts = {
			transparent = false, -- Enable this to disable setting the background color
			terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
			styles = {
				-- Style to be applied to different syntax groups
				-- Value is any valid attr-list value for `:help nvim_set_hl`
				comments = { italic = true },
				keywords = { italic = true },
				functions = {},
				variables = { bold = true },
				-- Background styles. Can be "dark", "transparent" or "normal"
				sidebars = "dark", -- style for sidebars, see below
				floats = "dark", -- style for floating windows
			},
			sidebars = { "qf", "help", "neo-tree", "termim" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
		},
	},
}

-- return {
-- 	"catppuccin/nvim",
-- 	lazy = true,
-- 	name = "catppuccin",
-- 	opts = {
-- 		integrations = {
-- 			aerial = true,
-- 			alpha = true,
-- 			cmp = true,
-- 			dashboard = true,
-- 			flash = true,
-- 			gitsigns = true,
-- 			headlines = true,
-- 			illuminate = true,
-- 			indent_blankline = { enabled = true },
-- 			leap = true,
-- 			lsp_trouble = true,
-- 			mason = true,
-- 			markdown = true,
-- 			mini = true,
-- 			native_lsp = {
-- 				enabled = true,
-- 				underlines = {
-- 					errors = { "undercurl" },
-- 					hints = { "undercurl" },
-- 					warnings = { "undercurl" },
-- 					information = { "undercurl" },
-- 				},
-- 			},
-- 			navic = { enabled = true, custom_bg = "lualine" },
-- 			neotest = true,
-- 			neotree = true,
-- 			noice = true,
-- 			notify = true,
-- 			semantic_tokens = true,
-- 			telescope = true,
-- 			treesitter = true,
-- 			treesitter_context = true,
-- 			which_key = true,
-- 		},
-- 	},
-- }
