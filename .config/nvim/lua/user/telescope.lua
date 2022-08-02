-- local status_ok, telescope = pcall(require, "telescope")
-- if not status_ok then
--   return
-- end
--
-- local actions = require "telescope.actions"
--
-- telescope.setup {
--   defaults = {
--
--     prompt_prefix = " ",
--     selection_caret = " ",
--     path_display = { "smart" },
--
--     mappings = {
--       i = {
--         ["<C-n>"] = actions.cycle_history_next,
--         ["<C-p>"] = actions.cycle_history_prev,
--
--         ["<C-j>"] = actions.move_selection_next,
--         ["<C-k>"] = actions.move_selection_previous,
--
--         ["<C-c>"] = actions.close,
--
--         ["<Down>"] = actions.move_selection_next,
--         ["<Up>"] = actions.move_selection_previous,
--
--         ["<CR>"] = actions.select_default,
--         ["<C-x>"] = actions.select_horizontal,
--         ["<C-v>"] = actions.select_vertical,
--         ["<C-t>"] = actions.select_tab,
--
--         ["<C-u>"] = actions.preview_scrolling_up,
--         ["<C-d>"] = actions.preview_scrolling_down,
--
--         ["<PageUp>"] = actions.results_scrolling_up,
--         ["<PageDown>"] = actions.results_scrolling_down,
--
--         ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
--         ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
--         ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
--         ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
--         ["<C-l>"] = actions.complete_tag,
--         ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
--       },
--
--       n = {
--         ["<esc>"] = actions.close,
--         ["<CR>"] = actions.select_default,
--         ["<C-x>"] = actions.select_horizontal,
--         ["<C-v>"] = actions.select_vertical,
--         ["<C-t>"] = actions.select_tab,
--
--         ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
--         ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
--         ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
--         ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
--
--         ["j"] = actions.move_selection_next,
--         ["k"] = actions.move_selection_previous,
--         ["H"] = actions.move_to_top,
--         ["M"] = actions.move_to_middle,
--         ["L"] = actions.move_to_bottom,
--
--         ["<Down>"] = actions.move_selection_next,
--         ["<Up>"] = actions.move_selection_previous,
--         ["gg"] = actions.move_to_top,
--         ["G"] = actions.move_to_bottom,
--
--         ["<C-u>"] = actions.preview_scrolling_up,
--         ["<C-d>"] = actions.preview_scrolling_down,
--
--         ["<PageUp>"] = actions.results_scrolling_up,
--         ["<PageDown>"] = actions.results_scrolling_down,
--
--         ["?"] = actions.which_key,
--       },
--     },
--   },
--   pickers = {
--     lsp_code_actions = {
--         theme = "cursor"
--     },
--     code_action = {
--         theme = "cursor"
--     },
--     lsp_workspace_diagnostics = {
--         theme = "dropdown"
--     }
--   },
--   extensions = {
--     ["ui-select"] = {
--         require("telescope.themes").get_cursor {
--         -- even more opts
--         }
--     }
--   }
-- }
--
local actions = require('telescope.actions')
require('telescope').setup{
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--ignore',
            '--hidden'
        },
        file_ignore_patterns = {
            ".git",
            "node_modules"
        },
        prompt_prefix = "🔎 ",
        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
                ["<esc>"] = actions.close
            }
        }
    },
    pickers = {
        lsp_code_actions = {
            theme = "cursor"
        },
        code_action = {
            theme = "cursor"
        },
        lsp_workspace_diagnostics = {
            theme = "dropdown"
        }
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_cursor {
            -- even more opts
            }
        }
    }
}
require("telescope").load_extension("ui-select")

vim.api.nvim_set_keymap("n", "<Leader><CR>", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>gr", "<cmd>Telescope lsp_references<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>gs", "<cmd>Telescope git_status<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>sd", "<cmd>Telescope diagnostics<CR>", { noremap = true })

vim.cmd([[
  highlight TelescopeSelection guifg=#FF38A2 gui=bold
  highlight TelescopeMatching guifg=#d9bcef
]])
