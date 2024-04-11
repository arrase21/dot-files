return {
	{
		"vhyrro/luarocks.nvim",
		-- opts = {
		-- 	rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" }, -- specifies a list of rocks to install
		-- 	luarocks_build_args = { "--with-lua=/usr/local/include/" }, -- extra options to pass to luarocks's configuration script
		-- },
		priority = 1000,
		config = true,
	},
	{
		"rest-nvim/rest.nvim",
		ft = "http",
		dependencies = { "luarocks.nvim" },
		config = function()
			-- require("rest-nvim").setup()
		end,
	},
}
