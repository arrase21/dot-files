return {
	-- Create annotations with one keybind, and jump your cursor in the inserted annotation
	{
		"danymat/neogen",
		keys = {
			{
				"<leader>cc",
				function()
					require("neogen").generate({})
				end,
				desc = "Neogen Comment",
			},
		},
		opts = { snippet_engine = "luasnip" },
	},

	-- Incremental rename
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
		vim.keymap.set("n", "<leader>rn", ":IncRename "),
	},

	-- Refactoring tool
	{
		"ThePrimeagen/refactoring.nvim",
		keys = {
			{
				"<leader>rf",
				function()
					require("refactoring").select_refactor()
				end,
				mode = "v",
				noremap = true,
				silent = true,
				expr = false,
			},
		},
		opts = {},
	},

	-- Go forward/backward with square brackets
	{
		"echasnovski/mini.bracketed",
		event = "BufReadPost",
		config = function()
			local bracketed = require("mini.bracketed")
			bracketed.setup({
				file = { suffix = "" },
				window = { suffix = "" },
				quickfix = { suffix = "" },
				yank = { suffix = "" },
				treesitter = { suffix = "n" },
			})
		end,
	},

	-- Better increase/descrease
	{
		"monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.bool,
					augend.semver.alias.semver,
					augend.constant.new({ elements = { "let", "const" } }),
				},
			})
		end,
	},

	{
		"simrat39/symbols-outline.nvim",
		keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
		cmd = "SymbolsOutline",
		opts = {
			position = "right",
		},
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "hrsh7th/cmp-path" }, -- Completion engine for path
			{ "hrsh7th/cmp-buffer" }, -- Completion engine for buffer
			{ "hrsh7th/cmp-cmdline" }, -- Completion engine for CMD
			{ "hrsh7th/cmp-nvim-lsp-document-symbol" },
			{ "kdheepak/cmp-latex-symbols" },
			{ "saadparwaiz1/cmp_luasnip" },
			{
				"Exafunction/codeium.nvim",
				cmd = "Codeium",
				build = ":Codeium Auth",
				opts = {},
			},
			{
				"L3MON4D3/LuaSnip",
				build = vim.fn.has("win32") ~= 0 and "make install_jsregexp" or nil,
				dependencies = {
					"rafamadriz/friendly-snippets",
				},
				config = function(_, opts)
					if opts then
						require("luasnip").config.setup(opts)
					end
					vim.tbl_map(function(type)
						require("luasnip.loaders.from_" .. type).lazy_load()
					end, { "vscode", "snipmate" })
					require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/Snippets/" }) -- friendly-snippets - enable standardized comments snippets
					require("luasnip").filetype_extend("typescript", { "tsdoc" })
					require("luasnip").filetype_extend("javascript", { "jsdoc" })
					require("luasnip").filetype_extend("lua", { "luadoc" })
					require("luasnip").filetype_extend("python", { "pydoc" })
					require("luasnip").filetype_extend("rust", { "rustdoc" })
					require("luasnip").filetype_extend("cs", { "csharpdoc" })
					require("luasnip").filetype_extend("java", { "javadoc" })
					require("luasnip").filetype_extend("c", { "cdoc" })
					require("luasnip").filetype_extend("cpp", { "cppdoc" })
					require("luasnip").filetype_extend("php", { "phpdoc" })
					require("luasnip").filetype_extend("kotlin", { "kdoc" })
					require("luasnip").filetype_extend("ruby", { "rdoc" })
					require("luasnip").filetype_extend("sh", { "shelldoc" })
				end,
			}, -- Snippets manager
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local Icons = require("arrase.Icons")
			local neogen = require("neogen")
			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local function borderMenu(hl_name)
				return {
					{ "", "CmpBorderIconsLT" },
					{ "─", hl_name },
					{ "▼", "CmpBorderIconsCT" },
					{ "│", hl_name },
					{ "╯", hl_name },
					{ "─", hl_name },
					{ "╰", hl_name },
					{ "│", hl_name },
				}
			end

			local function borderDoc(hl_name)
				return {
					{ "▲", "CmpBorderIconsCT" },
					{ "─", hl_name },
					{ "╮", hl_name },
					{ "│", hl_name },
					{ "╯", hl_name },
					{ "─", hl_name },
					{ "╰", hl_name },
					{ "│", hl_name },
				}
			end

			local function Kinder(item)
				if item == "Function" then
					return "Func"
				elseif item == "Codeium" then
					return "Code"
				elseif item == "Text" then
					return item
				elseif item == "Module" then
					return "Modl"
				elseif item == "Snippet" then
					return "Snip"
				elseif item == "Variable" then
					return "Varl"
				elseif item == "Folder" then
					return "Dire"
				elseif item == "Method" then
					return "Mthd"
				elseif item == "Keyword" then
					return "Kywd"
				elseif item == "Constant" then
					return "Cost"
				elseif item == "Property" then
					return "Prop"
				elseif item == "Field" then
					return "Fild"
				else
					return item
				end
			end
			local winhighlightMenu = {
				border = borderMenu("CmpBorder"),
				scrollbar = true,
				scrolloff = 6,
				col_offset = -2,
				side_padding = 0,
				winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder,Search:None",
			}

			local winhighlightDoc = {
				border = borderDoc("CmpBorderDoc"),
				col_offset = -1,
				side_padding = 0,
				scrollbar = false,
				winhighlight = "Normal:CmpNormal,CursorLine:CmpCursorLine",
			}

			cmp.setup({
				completion = {
					completeopt = "menu,menuone,noselect",
				},
				preselect = cmp.PreselectMode.None,
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = {
					["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
					["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<C-y>"] = cmp.config.disable,
					["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif neogen.jumpable() then
							neogen.jump_next()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						elseif neogen.jumpable(true) then
							neogen.jump_prev()
						else
							fallback()
						end
					end, { "i", "s" }),
				},

				sources = cmp.config.sources({
					{ name = "codeium", priority = 100 },
					{ name = "nvim_lsp", priority = 3000 },
					{ name = "luasnip", priority = 1000 },
					{ name = "buffer", priority = 500 },
					{ name = "path", priority = 250 },
					{
						name = "latex_symbols",
						filetype = { "tex", "latex" },
						option = { cache = true, strategy = 2 }, -- avoids reloading each time
						priority = 500,
					},
				}),

				formatting = {
					fields = { "kind", "abbr", "menu" },
					expandable_indicator = true,
					format = function(entry, item)
						item.kind = string.format("%s-{%s}", Icons.kind_icons[item.kind], Kinder(item.kind))
						item.menu = ({
							nvim_lua = "{Lua}",
							nvim_lsp = "{Lsp}",
							luasnip = "{Snip}",
							buffer = "{Buff}",
							path = "{Path}",
							latex_symbols = "{TeX}",
						})[entry.source.name]
						return item
					end,
				},

				view = {
					entries = { name = "custom" },
					docs = {
						auto_open = true,
					},
					separator = "|",
				},
				duplicates = {
					nvim_lsp = 1,
					luasnip = 1,
					cmp_tabnine = 1,
					buffer = 1,
					path = 1,
				},

				experimental = {
					ghost_text = true,
				},
				window = {
					completion = winhighlightMenu,

					documentation = winhighlightDoc,
				},
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "nvim_lsp_document_symbol" },
					{ name = "buffer" },
				},
				view = {
					entries = {
						name = "wildmenu",
						separator = "|",
					},
				},
			})
			--
			-- -- `:` cmdline setup.
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),

				view = {
					entries = {
						name = "wildmenu",
						separator = " | ",
					},
				},
			})
		end,
	},
}
