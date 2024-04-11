vim.opt.title = true
vim.opt.autoindent = true
vim.opt.shell = "fish"
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({ "*/node_modules/*" })

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])

vim.cmd("set confirm")
local options = {
	backup = false,
	clipboard = "unnamedplus",
	cmdheight = 1,
	completeopt = { "menuone", "noselect" },
	conceallevel = 1,
	cursorline = true,
	expandtab = true,
	fileencoding = "utf-8",
	formatoptions = "jcroqlnt",
	grepformat = "%f:%l:%c:%m",
	grepprg = "rg --vimgrep",
	hlsearch = true,
	ignorecase = true,
	mouse = "a",
	number = true,
	relativenumber = true,
	pumheight = 10,
	ruler = false,
	sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" },
	shiftwidth = 2,
	shiftround = true,
	scrolloff = 4,
	showmode = false,
	showcmd = true,
	showtabline = 4,
	sidescrolloff = 4,
	signcolumn = "yes",
	smartcase = true, -- smart case
	smartindent = true,
	splitbelow = true,
	splitkeep = "screen",
	splitright = true,
	swapfile = false,
	termguicolors = true,
	timeoutlen = 300,
	tabstop = 2,
	updatetime = 200,
	undofile = true,
	undolevels = 10000,
	writebackup = false,
	wrap = false,
	virtualedit = "block",
	wildmode = "longest:full,full",
	winminwidth = 5,
	fillchars = {
		foldopen = "",
		foldclose = "",
		-- fold = "⸱",
		fold = " ",
		foldsep = " ",
		diff = "╱",
		eob = " ",
	},

	vim.filetype.add({
		extension = {
			tex = "tex",
			typ = "typst",
		},
	}),
}

vim.g.markdown_recommended_style = 0
vim.loader.enable()

vim.g.python3_host_prog = "/usr/bin/python"

vim.g.Tex_MultipleCompileFormats = "pdf,bib,pdf"

vim.g.typst_cmd = "typst"
