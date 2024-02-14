return {
	-- messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})
			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			opts.commands = {
				all = {
					-- options for the message history that you get with `:Noice`
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function(event)
					vim.schedule(function()
						require("noice.text.markdown").keys(event.buf)
					end)
				end,
			})

			opts.presets.lsp_doc_border = true
		end,
	},

	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 6000,
		},
	},

	-- animations
	{
		"echasnovski/mini.animate",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.scroll = {
				enable = false,
			}
		end,
	},

	-- buffer line
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
			{ "<A-c>", "<Cmd>BufferLinePickClose<CR>", desc = "bufferline: delete buffer" },
		},
		opts = {
			options = {
				-- mode = "tabs",
				separator_style = "slant",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
	},

	-- statusline
	-- {
	-- 	"nvim-lualine/lualine.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		options = {
	-- 			-- globalstatus = false,
	-- 			theme = "solarized_dark",
	-- 		},
	-- 	},
	-- },
	--
	--

	{
		"wthollingsworth/pomodoro.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		config = function()
			require("pomodoro").setup({
				time_work = 30,
				time_break_short = 3,
				time_break_long = 10,
				timers_to_long_break = 5,
			})
		end,
		keys = {
			{
				"<leader>ps",
				"<CMD>PomodoroStart <CR>",
				desc = "pomodoro start",
			},
			{
				"<leader>pd",
				"<CMD> PomodoroStop <CR>",
				desc = "pomodoro stop",
			},
			{
				"<leader>po",
				"<CMD> PomodoroStatus <CR>",
				desc = "pomodoro status",
			},
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local lualine = require("lualine")
			local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
				return function(str)
					local win_width = vim.fn.winwidth(0)
					if hide_width and win_width < hide_width then
						return ""
					elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
						return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
					end
					return str
				end
			end

      -- Color table for highlights
      -- stylua: ignore
      local colors = {
        bg      = '#000000',
        fg      = '#82aaff',
        glass   = '#1a1b26',
        yellow  = '#CCFF00',
        cyan    = '#00FEFC',
        green   = '#39FF14',
        orange  = '#F6890A',
        magenta = '#E23DA5',
        blue    = '#4D4DFF',
        red     = '#FF3131',
      }

			local conditions = {
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
				end,
				hide_in_width = function()
					return vim.fn.winwidth(0) > 80
				end,
				check_git_workspace = function()
					local filepath = vim.fn.expand("%:p:h")
					local gitdir = vim.fn.finddir(".git", filepath .. ";")
					return gitdir and #gitdir > 0 and #gitdir < #filepath
				end,
			}

			-- Config
			local config = {
				options = {
					-- Disable sections and component separators
					component_separators = "",

					disabled_filetypes = {
						"alpha",
						"dashboard",
						"neo-tree",
						"Outline",
						"terminal",
						"lazy",
						"undotree",
						"Telescope",
						"dapui*",
						"dapui_scopes",
						"dapui_watches",
						"dapui_console",
						"dapui_breakpoints",
						"dapui_stacks",
						"dap-repl",
						"term",
						"terminal",
						"toggleterm",
						"REPL",
						"repl",
						"Iron",
						"Ipython",
						"ipython",
						"spectre_panel",
						"Trouble",
						"help",
						"hoversplit",
						"which_key",
					},
					theme = {
						normal = { c = { fg = "None", bg = "None" } },
						inactive = { c = { fg = "None", bg = "None" } },
					},
				},
				sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					-- These will be filled later
					lualine_c = {},
					lualine_x = {},
				},
				inactive_sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
			}

			-- Inserts a component in lualine_c at left section
			local function ins_left(component)
				table.insert(config.sections.lualine_c, component)
			end

			-- Inserts a component in lualine_x at right section
			local function ins_right(component)
				table.insert(config.sections.lualine_x, component)
			end

			local function ins_left_Inactive(component)
				table.insert(config.inactive_sections.lualine_c, component)
			end

			-- Inserts a component in lualine_x at right section
			local function ins_right_Inactive(component)
				table.insert(config.inactive_sections.lualine_x, component)
			end

			ins_left({
				function()
					return " "
				end,
				color = function()
					local mode_color = {
						n = colors.red,
						i = colors.green,
						v = colors.blue,
						[""] = colors.blue,
						V = colors.blue,
						c = colors.magenta,
						no = colors.red,
						s = colors.orange,
						S = colors.orange,
						[""] = colors.orange,
						ic = colors.yellow,
						R = colors.purple,
						Rv = colors.purple,
						cv = colors.red,
						ce = colors.red,
						r = colors.cyan,
						rm = colors.cyan,
						["r?"] = colors.cyan,
						["!"] = colors.red,
						t = colors.red,
					}
					return { bg = mode_color[vim.fn.mode()], fg = colors.bg, gui = "bold" }
				end,
				padding = { left = 0, right = 0 },
			})

			ins_left({
				function()
					return ""
				end,
				color = { fg = colors.bg, bg = "None" },
				padding = -2,
			})
			ins_left({
				-- filesize component
				"filesize",
				cond = conditions.buffer_not_empty,
				color = { bg = colors.bg, fg = colors.green },
			})
			ins_left({
				"filetype",
				cond = conditions.buffer_not_empty,
				color = { bg = colors.bg, fg = colors.blue },
			})
			ins_left({ "location", color = { bg = colors.blue, fg = colors.bg }, padding = { left = -1, right = -1 } })

			ins_left({
				function()
					return ""
				end,
				color = { fg = colors.bg, bg = "None" },
				padding = -2,
			})

			ins_left({
				function()
					return ""
				end,
				color = { fg = colors.bg, bg = "None" },
				cond = function()
					local pomstat = require("pomodoro").statusline()
					return not string.find(pomstat, "inactive")
				end,
				padding = -2,
			})
			ins_left({
				function()
					return require("pomodoro").statusline()
				end,
				cond = function()
					local pomstat = require("pomodoro").statusline()
					return not string.find(pomstat, "inactive")
				end,
				color = { fg = colors.magenta, bg = colors.bg, gui = "bold" },
				icon = { "P", color = { fg = colors.green } },
			})
			ins_left({
				function()
					return ""
				end,
				color = { fg = colors.bg, bg = "None" },
				cond = function()
					local pomstat = require("pomodoro").statusline()
					return not string.find(pomstat, "inactive")
				end,
				padding = -2,
			})

			ins_left({
				function()
					return ""
				end,
				color = { fg = colors.bg, bg = "None" },
				padding = -2,
			})
			ins_left({
				-- Lsp server name .
				function()
					local bufcl = vim.lsp.get_clients()
					local null_server, null = pcall(require("null-ls"))
					local bufcl_names = {}
					for _, cl in pairs(bufcl) do
						if cl.name == "null-ls" then
							if null_server then
								for _, src in ipairs(null.get_source({ filetype = vim.bo.filetype })) do
									table.insert(bufcl_names, src.name)
								end
							end
						else
							table.insert(bufcl_names, cl.name)
						end
					end
					return table.concat(bufcl_names, ",")
				end,
				icon = { " ", color = { fg = colors.green } },
				color = { fg = colors.magenta, bg = colors.bg, gui = "bold" },
			})
			ins_left({
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " " },
				diagnostics_color = {
					color_error = { fg = colors.red },
					color_warn = { fg = colors.yellow },
					color_info = { fg = colors.cyan },
				},
				color = { bg = colors.bg },
				padding = { left = -1, right = -1 },
			})
			ins_left({
				function()
					return ""
				end,
				color = { fg = colors.bg, bg = "None" },
				padding = 0,
			})

			ins_right({
				function()
					return ""
				end,
				color = { fg = colors.bg, bg = "None" },
				padding = -2,
			})
			ins_right({
				"filename",
				path = 0,
				icon = { "", color = { fg = colors.orange } },
				color = { fg = colors.purple, bg = colors.bg },
				padding = 0,
			})
			ins_right({
				function()
					return ""
				end,
				color = { fg = colors.bg, bg = "None" },
				padding = 0,
			})
			-- InacTives

			ins_left_Inactive({
				function()
					return "-----%="
				end,
				color = { fg = colors.purple, bg = colors.glass, gui = "bold" },
			})

			ins_right_Inactive({
				function()
					return ""
				end,
				color = { fg = colors.bg, bg = "None" },
				padding = -2,
			})
			-- ins_right_Inactive({
			-- 	function()
			-- 		local res = vim.fn.getcwd()
			-- 		local home = os.getenv("HOME")
			-- 		if home and vim.startswith(res, home) then
			-- 			res = " " .. res:sub(home:len() + 1) .. "/"
			-- 		else
			-- 			res = " "
			-- 		end
			-- 		return res
			-- 	end,
			-- 	icon = { "", color = { fg = colors.orange } },
			-- 	color = { fg = colors.yellow, bg = colors.bg },
			-- 	padding = { left = 0, right = 0 },
			-- })
			ins_right_Inactive({
				"filename",
				path = 3,
				icon = { "", color = { fg = colors.orange } },
				color = { fg = colors.purple, bg = colors.bg },
				padding = 0,
			})
			ins_right_Inactive({
				function()
					return ""
				end,
				color = { fg = colors.bg, bg = "None" },
				padding = 0,
			})
			ins_right_Inactive({
				function()
					return "%=-----"
				end,
				color = { fg = colors.purple, bg = colors.glass, gui = "bold" },
			})

			ins_right({
				function()
					return ""
				end,
				color = { fg = colors.bg, bg = "None" },
				padding = -2,
			})

			ins_right({
				function()
					return require("dap").status()
				end,
				cond = function()
					return package.loaded["dap"] and require("dap").status() ~= ""
				end,
				icon = { " ", color = { fg = colors.green } },
				color = { bg = colors.bg },
			})

			ins_right({
				"branch",
				icon = { " ", color = { fg = colors.purple } },
				color = { fg = colors.purple, bg = colors.bg, gui = "bold" },
			})
			local function diff_source()
				local gitsigns = vim.b.gitsigns_status_dict
				if gitsigns then
					return {
						added = gitsigns.added,
						modified = gitsigns.changed,
						removed = gitsigns.removed,
					}
				end
			end
			ins_right({
				"diff",
				-- Is it me or the symbol for modified us really weird
				symbols = { added = " ", modified = "柳 ", removed = " " },
				source = diff_source(),
				diff_color = {
					added = { fg = colors.green, bg = colors.glass },
					modified = { fg = colors.orange, bg = colors.glass },
					removed = { fg = colors.red, bg = colors.glass },
				},
				cond = conditions.hide_in_width,
				color = { bg = colors.bg, fg = colors.purple },
			})

			ins_right({
				"encoding",
				color = { fg = colors.green, bg = colors.bg },
			})
			ins_right({
				require("lazy.status").updates,
				cond = require("lazy.status").has_updates,
				color = { fg = colors.orange, bg = colors.bg },
				icon = { " ", color = { fg = colors.cyan } },
			})

			ins_right({
				function()
					return os.date("%R")
				end,
				color = { fg = colors.orange, bg = colors.bg },
				icon = { "", color = { fg = colors.blue } },
			})
			ins_right({
				function()
					return ""
				end,
				color = { fg = colors.bg, bg = "None" },
				padding = -2,
			})
			-- Now don't forget to initialize lualine
			lualine.setup(config)
		end,
	},

	-- filename
	{
		"b0o/incline.nvim",
		dependencies = { "craftzdog/solarized-osaka.nvim" },
		event = "BufReadPre",
		priority = 1200,
		config = function()
			local colors = require("solarized-osaka.colors").setup()
			require("incline").setup({
				highlight = {
					groups = {
						InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
						InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
					},
				},
				window = { margin = { vertical = 0, horizontal = 1 } },
				hide = {
					cursorline = true,
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if vim.bo[props.buf].modified then
						filename = "[+] " .. filename
					end

					local icon, color = require("nvim-web-devicons").get_icon_color(filename)
					return { { icon, guifg = color }, { " " }, { filename } }
				end,
			})
		end,
	},

	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
				kitty = { enabled = false, font = "+2" },
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},

	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		opts = function(_, opts)
			local logo = [[
        ███╗   ██╗███████╗ ██████╗  █████╗ ██████╗ ██████╗  █████╗ ███████╗███████╗
        ████╗  ██║██╔════╝██╔═══██╗██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝
        ██╔██╗ ██║█████╗  ██║   ██║███████║██████╔╝██████╔╝███████║███████╗█████╗
        ██║╚██╗██║██╔══╝  ██║   ██║██╔══██║██╔══██╗██╔══██╗██╔══██║╚════██║██╔══╝
        ██║ ╚████║███████╗╚██████╔╝██║  ██║██║  ██║██║  ██║██║  ██║███████║███████╗
        ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝
      ]]

			logo = string.rep("\n", 8) .. logo .. "\n\n"
			opts.config.header = vim.split(logo, "\n")
		end,
	},
	{

		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,

		config = function()
			local status_ok, which_key = pcall(require, "which-key")
			if not status_ok then
				return
			end

			local setup = {
				plugins = {
					marks = true, -- shows a list of your marks on ' and `
					registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
					spelling = {
						enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
						suggestions = 20, -- how many suggestions should be shown in the list?
					},
					-- the presets plugin, adds help for a bunch of default keybindings in Neovim
					-- No actual key bindings are created
					presets = {
						operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
						motions = true, -- adds help for motions
						text_objects = true, -- help for text objects triggered after entering an operator
						windows = true, -- default bindings on <c-w>
						nav = true, -- misc bindings to work with windows
						z = true, -- bindings for folds, spelling and others prefixed with z
						g = true, -- bindings for prefixed with g
					},
				},
				-- add operators that will trigger motion and text object completion
				-- to enable all native operators, set the preset / operators plugin above
				-- operators = { gc = "Comments" },
				key_labels = {
					-- override the label used to display some keys. It doesn't effect WK in any other way.
					-- For example:
					-- ["<space>"] = "SPC",
					-- ["<cr>"] = "RET",
					-- ["<tab>"] = "TAB",
				},
				icons = {
					breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
					separator = "➜", -- symbol used between a key and it's label
					group = "+", -- symbol prepended to a group
				},
				popup_mappings = {
					scroll_down = "<c-d>", -- binding to scroll down inside the popup
					scroll_up = "<c-u>", -- binding to scroll up inside the popup
				},
				window = {
					border = "rounded", -- none, single, double, shadow
					position = "bottom", -- bottom, top
					margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
					padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
					winblend = 0,
				},
				layout = {
					height = { min = 4, max = 25 }, -- min and max height of the columns
					width = { min = 20, max = 50 }, -- min and max width of the columns
					spacing = 3, -- spacing between columns
					align = "left", -- align columns left, center or right
				},
				ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
				hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
				show_help = true, -- show help message on the command line when the popup is visible
				triggers = "auto", -- automatically setup triggers
				-- triggers = {"<leader>"} -- or specify a list manually
				triggers_blacklist = {
					-- list of mode / prefixes that should never be hooked by WhichKey
					-- this is mostly relevant for key maps that start with a native binding
					-- most people should not need to change this
					i = { "j", "k" },
					v = { "j", "k" },
				},
			}

			local opts = {
				mode = "n", -- NORMAL mode
				prefix = "<leader>",
				buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
				silent = true, -- use `silent` when creating keymaps
				noremap = true, -- use `noremap` when creating keymaps
				nowait = true, -- use `nowait` when creating keymaps
			}

			local mappings = {
				["a"] = { "<cmd>Alpha<cr>", "Alpha" },
				b = {
					name = "Buffers",
					j = { "<cmd>BufferLinePick<cr>", "Jump" },
					f = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
					b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
					n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
					W = { "<cmd>noautocmd w<cr>", "Save without formatting (noautocmd)" },
					-- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
					e = {
						"<cmd>BufferLinePickClose<cr>",
						"Pick which buffer to close",
					},
					h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
					l = {
						"<cmd>BufferLineCloseRight<cr>",
						"Close all to the right",
					},
					D = {
						"<cmd>BufferLineSortByDirectory<cr>",
						"Sort by directory",
					},
					L = {
						"<cmd>BufferLineSortByExtension<cr>",
						"Sort by language",
					},
				},
				["w"] = { "<cmd>w<CR>", "Save" },
				["q"] = { "<cmd>quitall<CR>", "Quit" },
				["H"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
				["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
				["C"] = { "<cmd>:cd %:p:h <CR> :! javac %:t<CR>", "Compiling Java" },
				d = {
					name = "Debug",
					b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
					c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
					i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
					o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
					O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
					r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
					l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
					u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
					x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
				},
				f = {
					name = "Find",
					a = { "<cmd>Telescope grep_string<cr>", "Find String" },
					b = { "<cmd>Telescope buffers<cr>", "Buffers" },
					c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
					C = { "<cmd>Telescope commands<cr>", "Commands" },
					f = { "<cmd>Telescope find_files<cr>", "Find files" },
					h = { "<cmd>Telescope help_tags<cr>", "Help" },
					i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
					k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
					l = { "<cmd>Telescope resume<cr>", "Last Search" },
					t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
					p = { "<cmd>Telescope lsp_references<cr>", "References" },
					r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
					s = {
						"<cmd>lua require('telescope').extensions.file_browser.file_browser({path='%:p:h', respect_gitignore = false, hidden = true,grouped = true,previewer = false, layout_config = { height = 40 },})<cr>",
						"File Browser",
					},
				},
				--[[ p = {
				name = "Packer",
				c = { "<cmd>PackerCompile<cr>", "Compile" },
				i = { "<cmd>PackerInstall<cr>", "Install" },
				s = { "<cmd>PackerSync<cr>", "Sync" },
				S = { "<cmd>PackerStatus<cr>", "Status" },
				u = { "<cmd>PackerUpdate<cr>", "Update" },
			}, ]]
				t = {
					name = "TagAlon",
					c = { "cw", "rename Tag cw" },
				},
				s = {
					name = "surround",
					c = { "cw", "change cs" },
					d = { "ds", "delete ds" },
					v = { "s", "visual s" },
					vl = { "gS", "visual line gS" },
				},
				g = {
					name = "Git",
					g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
					j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
					k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
					l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
					p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
					r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
					R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
					s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
					u = {
						"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
						"Undo Stage Hunk",
					},
					o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
					b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
					c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
					d = {
						"<cmd>Gitsigns diffthis HEAD<cr>",
						"Diff",
					},
				},
			}
			which_key.setup(setup)
			which_key.register(mappings, opts)
		end,
	},
}
