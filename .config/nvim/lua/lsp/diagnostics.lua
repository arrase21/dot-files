vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
  float = {
    source = "always",     -- Show the source of the message
    header = "",           -- No header
    border = "single",     -- Use a single-line border
    focusable = false,
  },
  -- Add virtual text to display the message right next to the code
  virtual_text = true,
})
-- config = function()
--   vim.api.nvim_create_user_command("LspStop", function(args)
--     local lsp_name = args.fargs[1]
--     local filter = {}
--     if lsp_name then
--       filter.name = lsp_name
--     end
--     vim.lsp.stop_client(vim.lsp.get_clients(filter))
--     vim.cmd("edit")
--   end, {
--     nargs = "?",
--     complete = function()
--       return vim.iter(vim.lsp.get_clients())
--           :map(function(client)
--             return client.name
--           end)
--           :totable()
--     end,
--   })
--
--   vim.lsp.config("*", {
--     capabilities = require("blink.cmp").get_lsp_capabilities(),
--   })
--
-- vim.lsp.enable("lua_ls")
-- vim.lsp.enable("gopls", "go")
