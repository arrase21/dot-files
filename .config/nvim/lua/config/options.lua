vim.g.mapleader = " "

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
vim.opt.laststatus = 3
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = "fish"
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.ignorecase = true -- case insensitive searching unless /c or capital in search
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false -- no wrap lines
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" }) -- finding files - search down into subfolders
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitbelow = true -- put new windows below current
vim.opt.splitright = true -- put new windows right of current
vim.opt.splitkeep = "cursor"
vim.opt.mouse = ""

-- undercurl
vim.cmd([[let &t_cs = "\e[4:3m"]])
vim.cmd([[let &t_ce = "\e[4:0m"]])

-- add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

vim.cmd([[au bufnewfile,bufread *.astro setf astro]])
vim.cmd([[au bufnewfile,bufread podfile setf ruby]])

if vim.fn.has("nvim-0.8") == 1 then
  vim.opt.cmdheight = 0
end

-- file types
vim.filetype.add({
  extension = {
    mdx = "mdx",
  },
})
