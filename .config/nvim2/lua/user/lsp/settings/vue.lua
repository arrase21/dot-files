return {
	setup = {
		root_dir = function(fname)
			local util = require("vim.lspconfig/util")
			return util.root_pattern("package.json")(fname)
				or util.root_pattern("vue.config.js")(fname)
				or vim.fn.getcwd()
		end,
		cmd = { "vue-language-server", "--stdio" },
		filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
		-- fileypes = { "vue" },
		init_options = {
			config = {
				volar = {
					completion = {
						autoImport = true,
						tagCasing = "kebab",
						useScaffoldSnippets = true,
					},
					useWorkspaceDependencies = true,
					validation = {
						script = true,
						style = true,
						template = true,
					},
				},
			},
		},
	},
}
