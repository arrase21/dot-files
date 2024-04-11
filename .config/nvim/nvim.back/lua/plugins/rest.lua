return {
	-- {
	-- 	"camspiers/luarocks",
	-- 	dependencies = {
	-- 		"rcarriga/nvim-notify", -- Optional dependency
	-- 	},
	-- 	opts = {
	-- 		rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" }, -- Specify LuaRocks packages to install
	-- 	},
	-- },
	{
		"vhyrro/luarocks.nvim",
		-- opts = {
		-- 	rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" }, -- Specify LuaRocks packages to install
		-- },
		priority = 1000,
		config = true,
	},
	-- {
	-- 	"rest-nvim/rest.nvim",
	-- 	ft = "http",
	-- 	dependencies = { "luarocks.nvim" },
	-- 	config = function()
	-- 		require("rest-nvim").setup()
	-- 	end,
	-- },
	{
		"rest-nvim/rest.nvim",
		ft = "http",
		dependencies = { "luarocks.nvim" },
		config = function()
			require("rest-nvim").setup({
				keybinds = {
					{
						"<Leader>rr",
						"<cmd>Rest run<cr>",
						"Run request under the cursor",
					},
					{
						"<Leader>rh",
						"<cmd>Rest run last<cr>",
						"Re-run latest request",
					},
				},
				result = {
					keybinds = {
						buffer_local = true,
					},
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"rest-nvim/rest.nvim",
		},
		opts = function()
			require("telescope").load_extension("rest")
		end,
	},
}
