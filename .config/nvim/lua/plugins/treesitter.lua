return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "graphql",
        "bash",
        "lua",
        "vim",
        "python",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}

-- return {
--   "nvim-treesitter/nvim-treesitter",
--   build = ":TSUpdate",
--   dependencies = {
--     { "windwp/nvim-ts-autotag" },
--
--   },
--   config = function()
--     local configs = require("nvim-treesitter.configs")
--     configs.setup({
--       ensure_installed = {
--         "vim",
--         "lua",
--         "bash",
--         "python",
--         "sql",
--         "php",
--         "javascript",
--         "typescript",
--         "tsx",
--         "json",
--         "http",
--       },
--       sync_install = false,
--       highlight = {
--         enable = true,
--         additional_vim_regex_highlighting = { "php", "markdown", "rust", "python" },
--       },
--       rainbow = {
--         enable = true,
--         -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
--         extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
--         max_file_lines = nil, -- Do not enable for files with more than n lines, int
--         -- colors = {}, -- table of hex strings
--         -- termcolors = {} -- table of colour name strings
--       },
--       autotag = {
--         enable = true,
--       },
--       incremental_selection = {
--         enable = false,
--         keymaps = {
--           init_selection = "<CR>",
--           scope_incremental = "<CR>",
--           node_incremental = "<TAB>",
--           node_decremental = "<S-TAB>",
--         },
--       },
--       indent = {
--         enable = true,
--         --disable = { "python" },
--       },
--       tree_docs = {
--         enable = true,
--       },
--       fold = {
--         enable = true,
--       },
--     })
--     vim.o.foldmethod = "expr"
--     vim.o.foldexpr = "nvim_treesitter#foldexpr()"
--     vim.o.foldlevel = 99 -- Abre todos los pliegues por defecto
--   end,
-- }
--
-- -- return {
-- --
-- -- 	{
-- -- 		"nvim-treesitter/nvim-treesitter",
-- -- 		version = false, -- last release is way too old and doesn't work on Windows
-- -- 		build = ":TSUpdate",
-- -- 		event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
-- -- 		dependencies = {
-- -- 			{
-- -- 				"nvim-treesitter/nvim-treesitter-textobjects",
-- -- 				config = function()
-- -- 					-- When in diff mode, we want to use the default
-- -- 					-- vim text objects c & C instead of the treesitter ones.
-- -- 					local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
-- -- 					local configs = require("nvim-treesitter.configs")
-- -- 					for name, fn in pairs(move) do
-- -- 						if name:find("goto") == 1 then
-- -- 							move[name] = function(q, ...)
-- -- 								if vim.wo.diff then
-- -- 									local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
-- -- 									for key, query in pairs(config or {}) do
-- -- 										if q == query and key:find("[%]%[][cC]") then
-- -- 											vim.cmd("normal! " .. key)
-- -- 											return
-- -- 										end
-- -- 									end
-- -- 								end
-- -- 								return fn(q, ...)
-- -- 							end
-- -- 						end
-- -- 					end
-- -- 				end,
-- -- 			},
-- -- 			{ "nvim-treesitter/nvim-treesitter-context" },
-- -- 		},
-- -- 		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
-- -- 		init = function(plugin)
-- -- 			-- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
-- -- 			-- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
-- -- 			-- no longer trigger the **nvim-treesitter** module to be loaded in time.
-- -- 			-- Luckily, the only things that those plugins need are the custom queries, which we make available
-- -- 			-- during startup.
-- -- 			require("lazy.core.loader").add_to_rtp(plugin)
-- -- 			require("nvim-treesitter.query_predicates")
-- -- 		end,
-- -- 		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
-- -- 		keys = {
-- -- 			{ "<c-space>", desc = "Increment Selection" },
-- -- 			{ "<bs>", desc = "Decrement Selection", mode = "x" },
-- -- 		},
-- -- 		opts_extend = { "ensure_installed" },
-- -- 		---@type TSConfig
-- -- 		---@diagnostic disable-next-line: missing-fields
-- -- 		opts = {
-- -- 			highlight = { enable = true },
-- -- 			indent = { enable = true },
-- -- 			ensure_installed = {
-- -- 				"bash",
-- -- 				"c",
-- -- 				"diff",
-- -- 				"html",
-- -- 				"javascript",
-- -- 				"jsdoc",
-- -- 				"json",
-- -- 				"jsonc",
-- -- 				"lua",
-- -- 				"luadoc",
-- -- 				"luap",
-- -- 				"markdown",
-- -- 				"markdown_inline",
-- -- 				"printf",
-- -- 				"python",
-- -- 				"query",
-- -- 				"regex",
-- -- 				"toml",
-- -- 				"tsx",
-- -- 				"typescript",
-- -- 				"vim",
-- -- 				"vimdoc",
-- -- 				"xml",
-- -- 				"yaml",
-- -- 			},
-- -- 			incremental_selection = {
-- -- 				enable = true,
-- -- 				keymaps = {
-- -- 					init_selection = "<C-space>",
-- -- 					node_incremental = "<C-space>",
-- -- 					scope_incremental = false,
-- -- 					node_decremental = "<bs>",
-- -- 				},
-- -- 			},
-- -- 			textobjects = {
-- -- 				move = {
-- -- 					enable = true,
-- -- 					goto_next_start = {
-- -- 						["]f"] = "@function.outer",
-- -- 						["]c"] = "@class.outer",
-- -- 						["]a"] = "@parameter.inner",
-- -- 					},
-- -- 					goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
-- -- 					goto_previous_start = {
-- -- 						["[f"] = "@function.outer",
-- -- 						["[c"] = "@class.outer",
-- -- 						["[a"] = "@parameter.inner",
-- -- 					},
-- -- 					goto_previous_end = {
-- -- 						["[F"] = "@function.outer",
-- -- 						["[C"] = "@class.outer",
-- -- 						["[A"] = "@parameter.inner",
-- -- 					},
-- -- 				},
-- -- 			},
-- -- 		},
-- -- 		config = function(_, opts)
-- -- 			if type(opts.ensure_installed) == "table" then
-- -- 				---@type table<string, boolean>
-- -- 				local added = {}
-- -- 				opts.ensure_installed = vim.tbl_filter(function(lang)
-- -- 					if added[lang] then
-- -- 						return false
-- -- 					end
-- -- 					added[lang] = true
-- -- 					return true
-- -- 				end, opts.ensure_installed)
-- -- 			end
-- -- 			require("nvim-treesitter.configs").setup(opts)
-- -- 		end,
-- -- 	},
-- -- 	{ "windwp/nvim-ts-autotag", event = { "BufReadPost", "BufNewFile", "BufReadPre", "VeryLazy" }, opts = {} },
-- -- 	{
-- -- 		"nvim-treesitter/nvim-treesitter-context",
-- -- 		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
-- -- 		enabled = true,
-- -- 		event = "VeryLazy",
-- -- 		opts = { mode = "cursor", max_lines = 3 },
-- -- 	},
-- -- 	{
-- -- 		"JoosepAlviste/nvim-ts-context-commentstring",
-- -- 		event = "VeryLazy",
-- -- 		opts = {
-- -- 			enable_autocmd = false,
-- -- 		},
-- -- 	},
-- -- }
