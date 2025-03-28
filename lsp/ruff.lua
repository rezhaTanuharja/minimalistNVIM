---
-- @file lsp/ruff.lua
--
-- @brief
-- The configuration file for the Ruff LSP
--
-- @author Tanuharja, R.A.
-- @date 2025-03-28
--


return {

  filetypes = { "python" },

  cmd = { "ruff", "server" },

  root_markers = { ".git", "pyproject.toml" },

  settings = {},

}
