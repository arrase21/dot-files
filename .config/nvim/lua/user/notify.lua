local notify = require('notify')

notify.setup({
    timeout = 30,
    on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 3000 })
    end,
    background_colour = "#000000"
})

vim.notify = notify
