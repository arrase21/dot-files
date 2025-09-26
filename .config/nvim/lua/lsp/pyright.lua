local function organize_imports()
  local params = {
    command = "pyright.organizeimports",
    arguments = { vim.uri_from_bufnr(0) },
  }
  for _, client in ipairs(vim.lsp.get_clients { bufnr = vim.api.nvim_get_current_buf(), name = "pyright" }) do
    client.request("workspace/executeCommand", params, nil, 0)
  end
end

local function set_python_path(path)
  for _, client in ipairs(vim.lsp.get_clients { bufnr = vim.api.nvim_get_current_buf(), name = "pyright" }) do
    if client.settings then
      client.settings.python = vim.tbl_deep_extend("force", client.settings.python, { pythonPath = path })
    else
      client.config.settings = vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
    end
    client.notify("workspace/didChangeConfiguration", { settings = nil })
  end
end

return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".git",
  },
  single_file_support = true,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
  commands = {
    PyrightOrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
    PyrightSetPythonPath = {
      set_python_path,
      description = "Reconfigure pyright with the provided python path",
      nargs = 1,
      complete = "file",
    },
  },
}
