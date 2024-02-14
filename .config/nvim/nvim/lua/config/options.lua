vim.g.mapleader = " "

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = "fish"
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false -- No Wrap lines
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.splitkeep = "cursor"
vim.opt.mouse = "a"
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])

if vim.fn.has("nvim-0.8") == 1 then
	vim.opt.cmdheight = 0
end

-- vim.cmd("set confirm")
-- local options = {
-- 	backup = false,
-- 	clipboard = "unnamedplus",
-- 	cmdheight = 1,
-- 	completeopt = { "menuone", "noselect" },
-- 	conceallevel = 1,
-- 	fileencoding = "utf-8",
-- 	hlsearch = true,
-- 	ignorecase = true,
-- 	mouse = "a",
-- 	pumheight = 10,
-- 	showmode = false,
-- 	showcmd = true,
-- 	showtabline = 4,
-- 	smartcase = true, -- smart case
-- 	smartindent = true,
-- 	swapfile = false,
-- 	termguicolors = true,
-- 	timeoutlen = 100,
-- 	updatetime = 300,
-- 	writebackup = false,
-- 	expandtab = true,
-- 	shiftwidth = 2,
-- 	tabstop = 2,
-- 	cursorline = true,
-- 	number = true,
-- 	relativenumber = true,
-- 	signcolumn = "yes",
-- 	wrap = true,
-- 	scrolloff = 4, -- is one of my fav
-- 	sidescrolloff = 4,
-- 	ruler = false,
-- 	guifont = "Iosevka Regular",
-- 	-- foldmethod = "expr",
-- 	foldmethod = "marker",
-- 	-- foldexpr = "VimFolds(v:lnum)",
-- }
-- vim.opt.fillchars.eob = " "
-- vim.opt.shortmess:append("c")
-- vim.opt.iskeyword:append("-")
-- vim.opt.whichwrap:append("<,>,[,],h,l")
--
-- for k, v in pairs(options) do
-- 	vim.opt[k] = v
-- end
--
-- -- vim.cmd [[set backspace=start,eol,indent]]
-- vim.cmd([[filetype plugin indent on]])
-- vim.cmd("set ai")
-- vim.cmd("set si")
-- vim.cmd("set clipboard+=unnamedplus")
-- vim.cmd([[let g:OmniSharp_server_stdio = 1]])
