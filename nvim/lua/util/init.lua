local Util = require("lazy.core.util")

local M = {}

M.root_patterns = { ".git", "lua" }

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			on_attach(client, buffer)
		end,
	})
end

---@param plugin string
function M.has(plugin)
	return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

function M.fg(name)
	---@type {foreground?:number}?
	local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name })
		or vim.api.nvim_get_hl_by_name(name, true)
	local fg = hl and hl.fg or hl.foreground
	return fg and { fg = string.format("#%06x", fg) }
end

---@param fn fun()
function M.on_very_lazy(fn)
	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		callback = function()
			fn()
		end,
	})
end

---@param name string
function M.opts(name)
	local plugin = require("lazy.core.config").plugins[name]
	if not plugin then
		return {}
	end
	local Plugin = require("lazy.core.plugin")
	return Plugin.values(plugin, "opts", false)
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
	---@type string?
	local path = vim.api.nvim_buf_get_name(0)
	path = path ~= "" and vim.loop.fs_realpath(path) or nil
	---@type string[]
	local roots = {}
	if path then
		for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
			local workspace = client.config.workspace_folders
			local paths = workspace
					and vim.tbl_map(function(ws)
						return vim.uri_to_fname(ws.uri)
					end, workspace)
				or client.config.root_dir and { client.config.root_dir }
				or {}
			for _, p in ipairs(paths) do
				local r = vim.loop.fs_realpath(p)
				if path:find(r, 1, true) then
					roots[#roots + 1] = r
				end
			end
		end
	end
	table.sort(roots, function(a, b)
		return #a > #b
	end)
	---@type string?
	local root = roots[1]
	if not root then
		path = path and vim.fs.dirname(path) or vim.loop.cwd()
		---@type string?
		root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
		root = root and vim.fs.dirname(root) or vim.loop.cwd()
	end
	---@cast root string
	return root
end

-- this will return a function that calls telescope.
-- cwd will default to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
function M.telescope(builtin, opts)
	local params = { builtin = builtin, opts = opts }
	return function()
		builtin = params.builtin
		opts = params.opts
		opts = vim.tbl_deep_extend("force", { cwd = M.get_root() }, opts or {})
		if builtin == "files" then
			if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
				opts.show_untracked = true
				builtin = "git_files"
			else
				builtin = "find_files"
			end
		end
		if opts.cwd and opts.cwd ~= vim.loop.cwd() then
			opts.attach_mappings = function(_, map)
				map("i", "<a-c>", function()
					local action_state = require("telescope.actions.state")
					local line = action_state.get_current_line()
					M.telescope(
						params.builtin,
						vim.tbl_deep_extend("force", {}, params.opts or {}, { cwd = false, default_text = line })
					)()
				end)
				return true
			end
		end

		require("telescope.builtin")[builtin](opts)
	end
end

---@type table<string,LazyFloat>
local terminals = {}

-- Opens a floating terminal (interactive by default)
---@param cmd? string[]|string
---@param opts? LazyCmdOptions|{interactive?:boolean, esc_esc?:false, ctrl_hjkl?:false}

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
	if values then
		if vim.opt_local[option]:get() == values[1] then
			vim.opt_local[option] = values[2]
		else
			vim.opt_local[option] = values[1]
		end
		return Util.info("Set " .. option .. " to " .. vim.opt_local[option]:get(), { title = "Option" })
	end
	vim.opt_local[option] = not vim.opt_local[option]:get()
	if not silent then
		if vim.opt_local[option]:get() then
			Util.info("Enabled " .. option, { title = "Option" })
		else
			Util.warn("Disabled " .. option, { title = "Option" })
		end
	end
end

local nu = { number = true, relativenumber = true }
function M.toggle_number()
	if vim.opt_local.number:get() or vim.opt_local.relativenumber:get() then
		nu = { number = vim.opt_local.number:get(), relativenumber = vim.opt_local.relativenumber:get() }
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		Util.warn("Disabled line numbers", { title = "Option" })
	else
		vim.opt_local.number = nu.number
		vim.opt_local.relativenumber = nu.relativenumber
		Util.info("Enabled line numbers", { title = "Option" })
	end
end

local enabled = true
function M.toggle_diagnostics()
	enabled = not enabled
	if enabled then
		vim.diagnostic.enable()
		Util.info("Enabled diagnostics", { title = "Diagnostics" })
	else
		vim.diagnostic.disable()
		Util.warn("Disabled diagnostics", { title = "Diagnostics" })
	end
end

function M.deprecate(old, new)
	Util.warn(("`%s` is deprecated. Please use `%s` instead"):format(old, new), { title = "LazyVim" })
end

-- delay notifications till vim.notify was replaced or after 500ms

function M.lsp_get_config(server)
	local configs = require("lspconfig.configs")
	return rawget(configs, server)
end

---@param server string
---@param cond fun( root_dir, config): boolean
function M.lsp_disable(server, cond)
	local util = require("lspconfig.util")
	local def = M.lsp_get_config(server)
	def.document_config.on_new_config = util.add_hook_before(
		def.document_config.on_new_config,
		function(config, root_dir)
			if cond(root_dir, config) then
				config.enabled = false
			end
		end
	)
end

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
	local Config = require("lazy.core.config")
	if Config.plugins[name] and Config.plugins[name]._.loaded then
		vim.schedule(function()
			fn(name)
		end)
	else
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyLoad",
			callback = function(event)
				if event.data == name then
					fn(name)
					return true
				end
			end,
		})
	end
end

Root_cache = {}
M.find_root = function(buf_id, patterns)
	local path = vim.api.nvim_buf_get_name(buf_id)
	if path == "" then
		return
	end
	path = vim.fs.dirname(path)

	-- Try using cache
	local res = Root_cache[path]
	if res ~= nil then
		return res
	end

	-- Find root
	local root_file = vim.fs.find(patterns, { path = path, upward = true })[1]
	if root_file == nil then
		return
	end

	-- Use absolute path and cache result
	res = vim.fn.fnamemodify(vim.fs.dirname(root_file), ":p")
	Root_cache[path] = res

	return res
end

function M.format(component, text, hl_group)
	if not hl_group then
		return text
	end
	---@type table<string, string>
	component.hl_cache = component.hl_cache or {}
	local lualine_hl_group = component.hl_cache[hl_group]
	if not lualine_hl_group then
		local utils = require("lualine.utils.utils")
		lualine_hl_group =
			component:create_hl({ fg = utils.extract_highlight_colors(hl_group, "fg") }, "LV_" .. hl_group)
		component.hl_cache[hl_group] = lualine_hl_group
	end
	return component:format_hl(lualine_hl_group) .. text .. component:get_default_hl()
end

---@param opts? {relative: "cwd"|"root", modified_hl: string?}
function M.pretty_path(opts)
	opts = vim.tbl_extend("force", {
		relative = "cwd",
		modified_hl = "Constant",
	}, opts or {})

	return function(self)
		local path = vim.fn.expand("%:p") --[[@as string]]

		if path == "" then
			return ""
		end
		local root = Util.root.get({ normalize = true })
		local cwd = Util.root.cwd()

		if opts.relative == "cwd" and path:find(cwd, 1, true) == 1 then
			path = path:sub(#cwd + 2)
		else
			path = path:sub(#root + 2)
		end

		local sep = package.config:sub(1, 1)
		local parts = vim.split(path, "[\\/]")
		if #parts > 3 then
			parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
		end

		if opts.modified_hl and vim.bo.modified then
			parts[#parts] = M.format(self, parts[#parts], opts.modified_hl)
		end

		return table.concat(parts, sep)
	end
end

function M.unique(t)
	-- build set of unique values, so that uniqueElements[v] := true
	local uniqueElements = {}
	if type(t) == "table" then
		for k, v in pairs(t) do
			if not uniqueElements[v] then
				uniqueElements[v] = true
			end
		end
	elseif type(t) == "userdata" and t:dim() == 1 then
		for i = 1, t:size(1) do
			uniqueElements[t[i]] = true
		end
	elseif type(t) == "userdata" and t:dim() == 2 then
		for r = 1, t:size(1) do
			for c = 1, t:size(2) do
				uniqueElements[t[r][c]] = true
			end
		end
	else
		error("bad type or dim for t; type(t) = " .. type(t))
	end

	-- convert the set into a sequence
	local result = {}
	for k, v in pairs(uniqueElements) do
		table.insert(result, k)
	end

	return result
end
---@generic A: any
---@generic B: any
---@generic C: any
---@generic F: function
---@param fn F|fun(a:A, b:B, c:C)
---@param wrapper fun(a:A, b:B, c:C): boolean?
---@return F
function M.args(fn, wrapper)
	return function(...)
		if wrapper(...) == false then
			return
		end
		return fn(...)
	end
end

function M.get_upvalue(func, name)
	local i = 1
	while true do
		local n, v = debug.getupvalue(func, i)
		if not n then
			break
		end
		if n == name then
			return v
		end
		i = i + 1
	end
end

M.load_highlight = function(group)
	for hl, col in pairs(group) do
		vim.api.nvim_set_hl(0, hl, col)
	end
end

M.keymap_factory = function(mode)
	return function(keybind, custom, description, opts)
		local options = { noremap = true, silent = true }

		if opts then
			options = vim.tbl_extend("force", options, opts)
		end

		if description then
			options = vim.tbl_extend("force", options, { desc = description })
		end

		vim.juan.set(mode, keybind, custom, options)
	end
end

M.termcodes = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.focus_nvim_tree = function(key)
	local k = key or ""

	return function()
		local bufname = vim.api.nvim_buf_get_name(0)

		if string.find(bufname, "NvimTree") then
			vim.api.nvim_input("<C-w>h")
			return
		end

		vim.api.nvim_input(k .. "<C-w>l")
	end
end

M.text_padding = function(str)
	return "\n" .. str:gsub("([^\n]+)", "      %1      ") .. "\n"
end

M.cmd = function(str)
	return "<cmd> " .. str .. " <CR>"
end

M.schedule = function(fn, ms)
	ms = ms or 5
	local timer = vim.loop.new_timer()
	timer:start(ms, 0, vim.schedule_wrap(fn))
end

M.preserve_cursor_position = function(fn)
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	fn()

	M.schedule(function()
		local lastline = vim.fn.line("$")
		if line > lastline then
			line = lastline
		end
		vim.api.nvim_win_set_cursor(0, { line, col })
	end)
end

M.normalize_path = function(path)
	local Path = require("plenary.path")
	local cwd = vim.fn.getcwd()
	return Path:new(path):normalize(cwd)
end

M.get_selected_content = function()
	local curr_buffer = vim.fn.bufnr("%")
	local mode = vim.fn.mode()
	if mode == "v" or mode == "V" then
		start_pos = vim.fn.getpos("'<")
		end_pos = vim.fn.getpos("'>")
		end_pos[3] = vim.fn.col("'>")
	else
		local cursor = vim.fn.getpos(".")
		start_pos = cursor
		end_pos = start_pos
	end

	local content = table.concat(
		vim.api.nvim_buf_get_text(curr_buffer, start_pos[2] - 1, start_pos[3] - 1, end_pos[2] - 1, end_pos[3] - 1, {}),
		"\n"
	)

	return content
end

M.common_keymaps = {
	"a",
	"s",
	"d",
	"l",
	"k",
	"j",
	"q",
	"w",
	"e",
	"p",
	"o",
	"i",
	"r",
	"t",
	"y",
	"u",
	"g",
	"h",
	"f",
}

M.to_macos_keys = function(keymap)
	return keymap
		:gsub("CR", "↩")
		:gsub("<", "")
		:gsub(">", "")
		:gsub("-", " ")
		:gsub("D", "⌘")
		:gsub("A", "⌥")
		:gsub("C", "⌃")
		:gsub("BS", "⌫")
		:gsub("leader", vim.g.mapleader .. " ")
end

return M
