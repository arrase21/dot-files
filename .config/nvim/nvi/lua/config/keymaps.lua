local discipline = require("arrase.discipline")

discipline.cowboy()

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

-- keymap("n", "<leader>s", ":split<Return>", opts)
keymap("n", "<leader>v", ":vsplit<Return><C-w>w", opts)

keymap("n", "<leader>s", ":term python % <CR>", opts)
keymap("n", "<leader>s", ":term node % <CR>", opts)

-- Do things without affecting the registers
keymap("n", "x", '"_x')
keymap("n", "<Leader>p", '"0p')
keymap("n", "<Leader>P", '"0P')
keymap("v", "<Leader>p", '"0p')
keymap("n", "<Leader>c", '"_c')
keymap("n", "<Leader>C", '"_C')
keymap("v", "<Leader>c", '"_c')
keymap("v", "<Leader>C", '"_C')
keymap("n", "<Leader>d", '"_d')
keymap("n", "<Leader>D", '"_D')
keymap("v", "<Leader>d", '"_d')
keymap("v", "<Leader>D", '"_D')

-- Increment/decrement
keymap("n", "+", "<C-a>")
keymap("n", "-", "<C-x>")

-- Delete a word backwards
keymap("n", "dw", 'vb"_d')

-- Select all
keymap("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap("n", "<Leader>o", "o<Esc>^Da", opts)
keymap("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap("n", "te", ":tabedit")
keymap("n", "<tab>", ":tabnext<Return>", opts)
keymap("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
keymap("n", "ss", ":split<Return>", opts)
keymap("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap("n", "sh", "<C-w>h")
keymap("n", "sk", "<C-w>k")
keymap("n", "sj", "<C-w>j")
keymap("n", "sl", "<C-w>l")

-- Diagnostics
keymap("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, opts)

keymap("n", "<leader>r", function()
	require("arrase.hsl").replaceHexWithHSL()
end)

keymap("n", "<leader>i", function()
	require("arrase.lsp").toggleInlayHints()
end)
