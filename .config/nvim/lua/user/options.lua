local options = {
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 1,
  completeopt = { "menuone", "noselect" },
  conceallevel = 1,
  fileencoding = "utf-8",
  hlsearch = true,
  ignorecase = true,
  mouse = "a",
  pumheight = 10,
  showmode = false,
  showcmd = true,
  showtabline = 4,
  smartcase = true,                        -- smart case
  smartindent = true,
  swapfile = false,
  termguicolors = true,
  timeoutlen = 100,
  updatetime = 300,
  writebackup = false,
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  cursorline = true,
  number = true,
  relativenumber = true,
  signcolumn = "yes",
  wrap = true,
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  ruler = false,
  guifont = "Iosevka Regular",
}
vim.opt.fillchars.eob=" "
vim.opt.shortmess:append "c"
vim.opt.iskeyword:append("-")
vim.opt.whichwrap:append("<,>,[,],h,l")

for k, v in pairs(options) do
  vim.opt[k] = v
end
-- vim.cmd [[set backspace=start,eol,indent]]
vim.cmd [[filetype plugin indent on]]
vim.cmd "set ai"
vim.cmd "set si"
vim.cmd "set clipboard+=unnamedplus"
