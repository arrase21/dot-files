local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local servers = {
  "sumneko_lua",
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

  if server == "sumneko_lua" then
    local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server == "tsserver" then
    local tsserver_opts = require "user.lsp.settings.tsserver"
    opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
  end

  if server == "emmet_ls" then
    local emmet_ls_opts = require "user.lsp.settings.emmet_ls"
    opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
  end

  if server == "pyright" or server == "pylsp" then
    local pyright_opts = require "user.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "pylsp" then
    local pylsp_opts = require "user.lsp.settings.pylsp"
    opts = vim.tbl_deep_extend("force", pylsp_opts, opts)
  end
  if server == "volar" then
    local volar_opts = require "user.lsp.settings.vue"
    opts = vim.tbl_deep_extend("force", volar_opts, opts)
  end

  lspconfig[server].setup(opts)
end
