return {
  {
    "saghen/blink.cmp",
    lazy = true,
    event = { "InsertEnter" },
    dependencies = {
      {
        "saghen/blink.compat",
        optional = true, -- make optional so it's only enabled if any extras need it
        opts = {},
        version = not vim.g.lazyvim_blink_main and "*",
      },
      "rafamadriz/friendly-snippets",
    },

    version = "*",
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
      "sources.default",
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        ["<CR>"] = { "accept", "fallback" },
        ["<Esc>"] = { "hide", "fallback" },
        -- ["<C-c>"] = { "cancel", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-e>"] = { "cancel", "show", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-y>"] = { "select_and_accept" },

        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.snippet_forward()
            else
              return cmp.select_next()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<S-up>"] = { "scroll_documentation_up", "fallback" },
        ["<S-down>"] = { "scroll_documentation_down", "fallback" },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
        kind_icons = require("extras.icons").kind_icons,
      },
      snippets = {
        preset = "default",
      },
      completion = {
        accept = {
          create_undo_point = true,
          auto_brackets = { enabled = false },
        },
        menu = {
          max_height = 10,
          draw = {
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
            treesitter = { "lsp" },
          },
        },
        documentation = {
          window = {
            max_height = 15,
            max_width = 40,
          },
          auto_show = true,
          auto_show_delay_ms = 100,
          treesitter_highlighting = true,
        },
        ghost_text = { enabled = false },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          lsp = {
            name = "[lsp]",
            timeout_ms = 1000,
          },
          snippets = {
            name = "[snips]",
            min_keyword_length = 2,
            score_offset = -1,
          },
          path = { name = "[path]", opts = { get_cwd = vim.uv.cwd } },
          buffer = {
            name = "[buf]",
            max_items = 4,
            min_keyword_length = 4,
            score_offset = -3,

            opts = {
              get_bufnrs = function()
                local mins = 15
                local allOpenBuffers = vim.fn.getbufinfo({ buflisted = 1, bufloaded = 1 })
                local recentBufs = vim
                  .iter(allOpenBuffers)
                  :filter(function(buf)
                    local recentlyUsed = os.time() - buf.lastused < (60 * mins)
                    local nonSpecial = vim.bo[buf.bufnr].buftype == ""
                    return recentlyUsed and nonSpecial
                  end)
                  :map(function(buf)
                    return buf.bufnr
                  end)
                  :totable()
                return recentBufs
              end,
            },
          },
        },
      },
    },
    config = function(_, opts)
      local enabled = opts.sources.default
      for _, source in ipairs(opts.sources.compat or {}) do
        opts.sources.providers[source] = vim.tbl_deep_extend(
          "force",
          { name = source, module = "blink.compat.source" },
          opts.sources.providers[source] or {}
        )
        if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
          table.insert(enabled, source)
        end
      end
      opts.sources.compat = nil
      for _, provider in pairs(opts.sources.providers or {}) do
        ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
        if provider.kind then
          local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
          local kind_idx = #CompletionItemKind + 1

          CompletionItemKind[kind_idx] = provider.kind
          ---@diagnostic disable-next-line: no-unknown
          CompletionItemKind[provider.kind] = kind_idx

          ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
          local transform_items = provider.transform_items
          ---@param ctx blink.cmp.Context
          ---@param items blink.cmp.CompletionItem[]
          provider.transform_items = function(ctx, items)
            items = transform_items and transform_items(ctx, items) or items
            for _, item in ipairs(items) do
              item.kind = kind_idx or item.kind
            end
            return items
          end

          provider.kind = nil
        end
      end
      require("blink.cmp").setup(opts)
    end,
  },
}
