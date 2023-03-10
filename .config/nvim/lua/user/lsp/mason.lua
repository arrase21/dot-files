local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local servers = {
  "emmet_ls",
  "cssls",
  "html",
  "bashls",
  "pyright",
  --[[ "pylsp", ]]
  "jsonls",
  --[[ "tailwindcss", ]]
  "tsserver",
  "volar"
}
local settings = {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}
-- mason.setup()
require("mason").setup(settings)
require("mason-lspconfig").setup {
  ensure_installed = servers,
  automatic_installation = true,
}
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }


  lspconfig[server].setup(opts)
end
