local function augroup(name)
  return vim.api.nvim_create_augroup("vim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = "*.py",
  callback = function(args)
    local bufnr = args.buf
    local clients = vim.lsp.get_clients { bufnr = bufnr, name = "ruff" }
    if #clients == 0 then
      vim.lsp.start({
        name = "ruff",
        cmd = { "ruff", "server" },
        filetypes = { "python" },
        single_file_support = true,
        root_dir = function(fname)
          local start_path = (type(fname) == "string" and fname) or vim.fn.getcwd()
          local found = vim.fs.find(
            { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
            { path = start_path, upward = true }
          )[1]
          if found then
            return vim.fs.dirname(found)
          else
            return vim.fn.getcwd()
          end
        end,
      })
    end
  end,
})
-- Autoformat on save
local buffer_autoformat = function(bufnr)
  local group = 'lsp_autoformat'
  vim.api.nvim_create_augroup(group, { clear = false })
  vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

  vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = bufnr,
    group = group,
    desc = 'LSP format on save',
    callback = function()
      -- note: do not enable async formatting
      vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
    end,
  })
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local id = vim.tbl_get(event, 'data', 'client_id')
    local client = id and vim.lsp.get_client_by_id(id)
    if client == nil then
      return
    end

    -- make sure there is at least one client with formatting capabilities
    if client.supports_method('textDocument/formatting') then
      buffer_autoformat(event.buf)
    end
  end
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})


vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].vim_last_loc then
      return
    end
    vim.b[buf].vim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
