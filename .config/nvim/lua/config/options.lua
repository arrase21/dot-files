vim.g.mapleader = " "
--
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.winborder = "rounded"
vim.g.autoformat = true
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
vim.opt.conceallevel = 2                                    -- Hide * markup for bold and italic, but not markers with substitutions
vim.opt.confirm = true                                      -- Confirm to save changes before exiting modified buffer
vim.opt.cursorline = true                                   -- Enable highlighting of the current line
vim.opt.expandtab = true
vim.opt.completeopt = "noselect,menu,menuone"

vim.opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.inccommand = "nosplit"
vim.opt.jumpoptions = "view"
vim.opt.laststatus = 3

vim.opt.pumblend = 2     -- Popup blend
vim.opt.pumheight = 15   -- Maximum number of entries in a popup

vim.opt.linebreak = true -- Wrap lines at convenient points
vim.opt.mouse = "a"      -- Enable mouse mode
vim.opt.scrolloff = 10
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.smartcase = true   -- Don't ignore case with capitals
vim.opt.smartindent = true
vim.opt.smoothscroll = true

vim.opt.tabstop = 2
vim.opt.smarttab = true

vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200               -- Save swap file and trigger CursorHold
vim.opt.virtualedit = "block"          -- Allow cursor to move where there is no text in visual block mode
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.winminwidth = 10               -- Minimum window width
vim.opt.wrap = false                   -- Disable line wrap

vim.opt.autoindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 0
vim.opt.breakindent = true
vim.opt.wrap = false -- No Wrap lines

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- vim.opt.guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"


