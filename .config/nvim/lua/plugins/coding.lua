return {

  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
      { "<F10>", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    config = function()
      local cfg = require("extras.outline")
      require("outline").setup(cfg)
    end,
  },
  -- {
  --   "2kabhishek/termim.nvim",
  --   lazy = true,
  --   cmd = { "Fterm", "FTerm", "Sterm", "STerm", "Vterm", "VTerm" },
  --   keys = {
  --     {
  --       "<A-1>",
  --       "<Cmd> Fterm <CR>",
  --       desc = "Terminal Full",
  --     },
  --     {
  --       "<A-2>",
  --       "<Cmd> Vterm <CR>",
  --       desc = "Terminal Vert",
  --     },
  --     {
  --       "<A-3>",
  --       "<Cmd> Sterm <CR>",
  --       desc = "Terminal Horz",
  --     },
  --   },
  -- }, -- Commenting tools
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6", -- recomended as each new version will have breaking changes
    opts = {
      -- Config goes here
    },
  },
  {
    "kylechui/nvim-surround",
    event = { "BufNewFile", "BufReadPost", "BufWritePre", "VeryLazy" },
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { show_start = false, show_end = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
    main = "ibl",
  },

  -- {
  --   "Bekaboo/dropbar.nvim",
  --   event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
  --   keys = {
  --     {
  --       "<leader>pb",
  --       function()
  --         require("dropbar.api").pick()
  --       end,
  --       desc = "Dropbar select",
  --     },
  --   },
  --   config = function()
  --     local ver = vim.version()
  --     if ver.minor == "10" then
  --       local cfg = require("SciVim.extras.winbar")
  --       require("dropbar").setup(cfg)
  --     end
  --   end,
  -- },
  {
    "cshuaimin/ssr.nvim",
    lazy = true,
    -- Calling setup is optional.
    config = function()
      require("ssr").setup({
        border = "rounded",
        min_width = 50,
        min_height = 5,
        max_width = 120,
        max_height = 25,
        adjust_window = true,
        keymaps = {
          close = "q",
          next_match = "n",
          prev_match = "N",
          replace_confirm = "<cr>",
          replace_all = "<leader><cr>",
        },
      })
    end,
    keys = {
      {
        "<A-r>",
        function()
          require("ssr").open()
        end,
        desc = "Search and Replace Structural",
      },
    },
  },
  {
    "chrisgrieser/nvim-rip-substitute",
    lazy = true,
    keys = {
      {
        "<A-s>",
        function()
          require("rip-substitute").sub()
        end,
        mode = { "n", "x" },
        desc = " rip substitute",
      },
    },
  },

  {
    "kwindwp/nvim-ts-autotag",
    Config = {
      enable_close = true,           -- Auto close tags
      enable_rename = true,          -- Auto rename pairs of tags
      enable_close_on_slash = false, -- Auto close on trailing </
      per_filetype = {
        ["html"] = {
          enable_close = false
        },
        [{ "ts", "tsx", "python", "js" }] = {
          enable_close = false
        },

      }
    },
  },
}
