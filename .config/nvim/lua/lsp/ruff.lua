return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  single_file_support = true,
  root_dir = function(fname)
    -- Asegurarse que fname sea string válido
    local path = (type(fname) == "string" and fname) or vim.fn.getcwd()

    -- Buscar proyecto
    local found = vim.fs.find(
      { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
      { path = path, upward = true }
    )[1]

    if found then
      return vim.fs.dirname(found)
    else
      return vim.fn.getcwd()
    end
  end,
}
-- lua/lsp/ruff.lua
-- return {
--   cmd = { "ruff", "server" },
--   filetypes = { "python" },
--   root_dir = function(fname)
--     return vim.fs.dirname(vim.fs.find(
--       { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
--       { path = fname, upward = true }
--     )[1]) or vim.fn.getcwd()
--   end,
--   single_file_support = true,
-- }
