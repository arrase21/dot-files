local saga = require 'lspsaga'
local keymap = vim.keymap.set
saga.init_lsp_saga {
  error_sign = '🔥',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "round",
}
keymap("n", "gh", "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>")
keymap("n", "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>")
keymap("n", "<C-k>", "<Cmd>Lspsaga hover_doc<CR>")
keymap("n", "gh", "<Cmd>Lspsaga lsp_finder<CR>")
keymap("n", "gr", "<Cmd>Lspsaga rename<CR>")
keymap("n", "gx", "<Cmd>Lspsaga code_action<CR>")
keymap("n", "gx", "<Cmd>Lspsaga code_action<CR>")
