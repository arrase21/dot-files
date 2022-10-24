local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
---@diagnostic disable-next-line: missing-parameter
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  -- snapshot = "july-24",
  snapshot_path = fn.stdpath "config" .. "/snapshots",
  max_jobs = 50,
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
    prompt_border = "rounded", -- Border style of prompt popups.
  },
}
-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "goolord/alpha-nvim"
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "kyazdani42/nvim-web-devicons"
  use "nvim-lualine/lualine.nvim"
  use "RRethy/vim-illuminate"
  use "ahmedkhalf/project.nvim"
  --[[ use "lewis6991/impatient.nvim" ]]
  use "lukas-reineke/indent-blankline.nvim"
  --[[ use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight ]]
  use "romgrk/barbar.nvim"
  use "folke/which-key.nvim"

  -- Show Css color
  use "brenoprata10/nvim-highlight-colors"
  -- Aurorename tag
  use "AndrewRadev/tagalong.vim"
  -- Colorschemes
  use "tanvirtin/monokai.nvim"
  --[[ use "svrana/neosolarized.nvim" ]]
  -- use "matsuuu/pinkmare"
  use "arrase21/molokai"
  use "arrase21/yiyi.nvim"
  use "tjdevries/colorbuddy.nvim"

    -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use 'nvim-telescope/telescope-ui-select.nvim'
  use "nvim-telescope/telescope-file-browser.nvim"

  -- Treesitter
  use "nvim-treesitter/nvim-treesitter"
  use "nvim-treesitter/playground"
  use "p00f/nvim-ts-rainbow"

  -- Comment
  --[[ use "JoosepAlviste/nvim-ts-context-commentstring" ]]
  -- use "numToStr/Comment.nvim"
  use "b3nj5m1n/kommentary"

  -- Float term
  use "voldikss/vim-floaterm"
  -- use "folke/todo-comments.nvim"
  -- Lsp Saga
  use "tami5/lspsaga.nvim"
  -- Replace brackets
  --[[ use "tpope/vim-surround" ]]
  use "kylechui/nvim-surround"
  -- Notfy
  use  "rcarriga/nvim-notify"
  -- Java
  use 'mfussenegger/nvim-jdtls'

  -- DAP
  use { "mfussenegger/nvim-dap"}
  use { "rcarriga/nvim-dap-ui"}
  use { "ravenxrz/DAPInstall.nvim"}
  use 'mfussenegger/nvim-dap-python'

  use "lvimuser/lsp-inlayhints.nvim"
  use "j-hui/fidget.nvim"

  -- use 'nvim-telescope/telescope-dap.nvim'
  use "NTBBloodbath/rest.nvim"
  --[[ use "windwp/nvim-spectre" ]]

  use "is0n/jaq-nvim"
  use {
    "0x100101/lab.nvim",
    run = "cd js && npm ci",
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
