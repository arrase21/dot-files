local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Press kj fast to enter
keymap("i", "kj", "<ESC>", opts)
keymap("i", "KJ", "<ESC>", opts)

-- Quit
keymap("n", "<Leader>w", ":w<ESC>", opts)
-- keymap("n", "<Leader>q", ":quitall<ESC>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<Up>", ":resize -2<CR>", opts)
keymap("n", "<Down>", ":resize +2<CR>", opts)
keymap("n", "<Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<Right>", ":vertical resize +2<CR>", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)

keymap("i", "<A-k> <esc>", ":m .+1<CR>==gi", opts)
keymap("i", "<A-k> <esc>", ":m .-2<CR>==gi", opts)

-- Delete word
keymap("n", "<backspace>", "diw", opts)

-- Copy paste
keymap("n", "<Leader>y", "mzyyp`zj", opts)

-- Increment/decrement
keymap("n", "+", "<C-a>")
keymap("n", "-", "<C-x>")

-- Delete a word backwards
keymap("n", "dw", 'vb"_d')

-- Select all
keymap("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Jumplist
keymap("n", "<C-m>", "<C-i>", opts)

-- Split window

keymap("n", "ss", ":split<Return>", opts)
keymap("n", "sv", ":vsplit<Return>", opts)

local map = vim.keymap.set

map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

map({ "n", "i", "v", "s" }, "<C-s>", "<Cmd>w<CR><esc>", { desc = "Save", noremap = true, silent = true })

map("n", "<C-q>", "<Cmd>q!<CR>", { desc = "Quit", noremap = true, silent = true })
map("n", "<C-c>", "<Cmd>bdelete!<CR>", { desc = "Kill Buffer", noremap = true, silent = true })
--[[
-- Moving
--]]

map("n", "<S-Down>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<S-Up>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<S-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<S-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<S-Down>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<S-Up>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })
--[[
-- Focusing
--]]
map("n", "<C-h>", "<C-w>h", { desc = "Focus Left", noremap = true, silent = true })
map("n", "<C-j>", "<C-w>j", { desc = "Focus Down", noremap = true, silent = true })
map("n", "<C-k>", "<C-w>k", { desc = "Focus Up", noremap = true, silent = true })
map("n", "<C-l>", "<C-w>l", { desc = "Focus Right", noremap = true, silent = true })
--[[
-- Resizing
--]]
map("n", "<C-Up>", "<Cmd> resize +2<CR>", { desc = "Inc Height", noremap = true, silent = true })
map("n", "<C-Down>", "<Cmd> resize -2<CR>", { desc = "Dec Height", noremap = true, silent = true })
map("n", "<C-Left>", "<Cmd> vertical resize +2<CR>", { desc = "Inc Width", noremap = true, silent = true })
map("n", "<C-Right>", "<Cmd> vertical resize -2<CR>", { desc = "Dec Width", noremap = true, silent = true })

--[[
--indenting
--]]

map("v", "<", "<gv")
map("v", ">", ">gv")
