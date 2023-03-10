local status_saga_ok, saga = pcall(require, "lspsaga")
if not status_saga_ok then
  return
end
local keymap = vim.keymap.set
saga.setup({
  ui = {
    -- code_action = "💡",
    winblend = 10,
    border = 'rounded',
    colors = {
      normal_bg = '#002b36'
    },
    kind = {}
  }
})

keymap('n', '<A-g>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
-- keymap('n', '<leader>l', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
keymap('n', 'gl', '<Cmd>Lspsaga show_diagnostic<CR>', opts)
keymap('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
keymap('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
-- vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
keymap('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
keymap('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)

-- code action
local codeaction = require("lspsaga.codeaction")
keymap("n", "<leader>ca", function() codeaction:code_action() end, { silent = true })
keymap("v", "<leader>ca", function()
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
  codeaction:range_code_action()
end, { silent = true })

