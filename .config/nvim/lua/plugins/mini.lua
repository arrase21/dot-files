local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_args = vim.fn.argc(-1) > 0 and now or later

now(function()
  require('mini.icons').setup({
    use_file_extension = function(ext, _)
      local suf3, suf4 = ext:sub(-3), ext:sub(-4)
      return suf3 ~= 'scm' and suf3 ~= 'txt' and suf3 ~= 'yml' and suf4 ~= 'json' and suf4 ~= 'yaml'
    end,
  })
  later(MiniIcons.mock_nvim_web_devicons)
  later(MiniIcons.tweak_lsp_kind)
end)


later(function()
  require('mini.pick').setup()
  vim.ui.select = MiniPick.ui_select
  vim.keymap.set('n', ',', '<Cmd>Pick buf_lines scope="current" preserve_order=true<CR>', { nowait = true })

  MiniPick.registry.projects = function()
    local cwd = vim.fn.expand('~/repos')
    local choose = function(item)
      vim.schedule(function() MiniPick.builtin.files(nil, { source = { cwd = item.path } }) end)
    end
    return MiniExtra.pickers.explorer({ cwd = cwd }, { source = { choose = choose } })
  end
end)

later(function()
  require('mini.diff').setup({
    view = {
      style = "sign",
      signs = { add = '▒', change = '▒', delete = '消' },
    }
  })
end)

later(function()
  require('mini.files').setup({
    mappings = {
      go_in_plus = "<CR>",       -- Entrar y abrir en ventana reciente
      synchronize = "<Leader>w", -- Remapear sincronización a <Leader>w
    },
    windows = {
      preview = true,
      width_focus = 30,
      width_nofocus = 15,
      width_preview = 85,
    },
  })
end)

later(function()
  add("Exafunction/codeium.vim")
  add("nvim-lua/plenary.nvim")

  -- Set up mini.completion
  local process_items_opts = { kind_priority = { Text = 99, Snippet = 1 } }
  local process_items = function(items, base)
    return require('mini.completion').default_process_items(items, base, process_items_opts)
  end

  -- Custom source for Codeium to show suggestions in the popup
  local codeium_source = {
    name = 'codeium',
    get_completions = function()
      local completions = vim.fn['codeium#Complete']()
      local items = {}
      if type(completions) == 'table' then
        for _, completion in ipairs(completions) do
          table.insert(items, {
            word = completion.text or completion, -- Adapt to Codeium's output
            kind = 'Codeium',
            menu = '[Codeium]',
            info = completion.info or '',
          })
        end
      end
      return items
    end,
  }

  require('mini.completion').setup({
    lsp_completion = {
      source_func = 'omnifunc',
      auto_setup = true,
      process_items = process_items,
    },
    -- Add Codeium as a custom source
    sources = { codeium_source },
    mappings = {
      force_twostage = '<C-x><C-o>', -- Trigger LSP and Codeium (popup)
      force_oneshot = '<C-x><C-c>',  -- Trigger Codeium inline (ghost text)
    },
  })

  -- Attach omnifunc for LSP only
  local on_attach = function(args)
    vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
  end
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = on_attach,
  })

  -- Ensure LSP capabilities for Neovim 0.11 if needed
  if vim.fn.has('nvim-0.11') == 1 then
    vim.lsp.config('*', { capabilities = require('mini.completion').get_lsp_capabilities() })
  end

  -- Keymaps for Codeium (for ghost text and cycling suggestions)
  vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
  vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
  vim.keymap.set('i', '<C-[>', function() return vim.fn['codeium#CycleCompletions'](1) end,
    { expr = true, silent = true })
  vim.keymap.set('i', '<C-]>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
    { expr = true, silent = true })

  -- Ensure completeopt is set for popup menu
  vim.o.completeopt = 'menu,menuone,noselect'
end)


-- later(function()
--   local process_items_opts = { kind_priority = { Text = 99, Snippet = 1 } }
--   local process_items = function(items, base)
--     return MiniCompletion.default_process_items(items, base, process_items_opts)
--   end
--   require('mini.completion').setup({
--     lsp_completion = {
--       source_func = 'omnifunc',
--       auto_setup = true,
--       process_items = process_items },
--   })
--
--   local on_attach = function(args) vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp' end
--   vim.api.nvim_create_autocmd('LspAttach', { callback = on_attach })
--   if vim.fn.has('nvim-0.11') == 1 then vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() }) end
-- end)


later(function()
  local miniclue = require('mini.clue')
  miniclue.setup({
    window = {
      delay = 100,
      scroll_down = '<C-d>',
      scroll_up = '<C-u>',
    },
    clues = {
      { mode = 'n', keys = '<Leader>c', desc = '  Coding' },
      { mode = 'n', keys = '<Leader>b', desc = '󰓩  Buffers' },
      { mode = 'n', keys = '<Leader>f', desc = '󰱼  Files' },
      { mode = 'n', keys = '<Leader>q', desc = '󰗼  Quit/Session' },
      { mode = 'n', keys = '<Leader>u', desc = '  UI/Toggles' },
      { mode = 'n', keys = '<Leader>w', desc = '  Windows' },
      { mode = 'n', keys = '<Leader>d', desc = '  Debug' },
      Config.leader_group_clues,
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows({ submode_resize = true }),
      miniclue.gen_clues.z(),
    },
    triggers = {
      { mode = 'n', keys = '<Leader>' }, -- Leader triggers
      { mode = 'x', keys = '<Leader>' },
      { mode = 'n', keys = [[\]] },      -- mini.basics
      { mode = 'n', keys = '[' },        -- mini.bracketed
      { mode = 'n', keys = ']' },
      { mode = 'x', keys = '[' },
      { mode = 'x', keys = ']' },
      { mode = 'i', keys = '<C-x>' }, -- Built-in completion
      { mode = 'n', keys = 'g' },     -- `g` key
      { mode = 'x', keys = 'g' },
      { mode = 'n', keys = "'" },     -- Marks
      { mode = 'n', keys = '`' },
      { mode = 'x', keys = "'" },
      { mode = 'x', keys = '`' },
      { mode = 'n', keys = '"' }, -- Registers
      { mode = 'x', keys = '"' },
      { mode = 'i', keys = '<C-r>' },
      { mode = 'c', keys = '<C-r>' },
      { mode = 'n', keys = '<C-w>' }, -- Window commands
      { mode = 'n', keys = 'z' },     -- `z` key
      { mode = 'x', keys = 'z' },
    },
  })
end)
