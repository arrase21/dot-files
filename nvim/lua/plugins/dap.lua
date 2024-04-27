return {

	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"rcarriga/cmp-dap",
		"ravenxrz/DAPInstall.nvim",
		"mfussenegger/nvim-dap-python",
	},
	keys = { { "<leader>d", desc = "Open Debug menu" } },
	config = function()
		require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
		-- require('dap-python').setup('~/.miniconda/bin/python3')
		table.insert(require("dap").configurations.python, {
			type = "python",
			request = "launch",
			name = "My custom launch configuration",
			program = "${file}",
			-- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
		})

		vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "➡️", texthl = "", linehl = "DebugBreakpointLine", numhl = "" })

		require("dapui").setup({
			icons = { expanded = "▾", collapsed = "▸" },
			mappings = {
				-- Use a table to apply multiple mappings
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				edit = "e",
				repl = "r",
				toggle = "t",
			},
			-- Expand lines larger than the window
			-- Requires >= 0.7
			expand_lines = vim.fn.has("nvim-0.7"),

			layouts = {
				{
					elements = {
						"scopes",
						"breakpoints",
						"stacks",
						"watches",
					},
					size = 40,
					position = "left",
				},
				{
					elements = {
						"repl",
						"console",
					},
					size = 10,
					position = "bottom",
				},
			},
			floating = {
				max_height = nil, -- These can be integers or a float between 0 and 1.
				max_width = nil, -- Floats will be treated as percentage of your screen.
				border = "single", -- Border style. Can be "single", "double" or "rounded"
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			windows = { indent = 1 },
			render = {
				max_type_length = nil, -- Can be integer or nil.
			},
		})

		local dap, dapui = require("dap"), require("dapui")
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end,
}
