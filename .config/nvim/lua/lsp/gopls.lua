-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "go",
--   callback = function(args)
--     vim.lsp.start({
--       name = "gopls",
--       cmd = { "gopls" },
--       root_dir = vim.fs.dirname(
--         vim.fs.find({ "go.mod", ".git" }, { upward = true })[1]
--       ),
--     })
--   end,
-- })
--

return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
    },
  },
}

-- lua/lsp/gopls.lua
-- vim.lsp.config["gopls"] = {
--   cmd = { "gopls" },
--   filetypes = { "go", "gomod", "gowork", "gotmpl" },
--   root_markers = { "go.work", "go.mod", ".git" },
--   settings = {
--     gopls = {
--       completeUnimported = true,
--       usePlaceholders = true,
--       analyses = {
--         unusedparams = true,
--         shadow = true,
--       },
--     },
--   },
-- }
--
-- -- arrancar inmediatamente
-- vim.lsp.enable("gopls")
