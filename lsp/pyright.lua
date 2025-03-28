---
-- @file lsp/pyright.lua
--
-- @brief
-- The configuration file for the Pyright LSP
--
-- @author Tanuharja, R.A.
-- @date 2025-03-28
--


return {

  filetypes = { "python" },

  cmd = {"pyright-langserver", "--stdio"},

  root_markers = { ".git", "pyproject.toml" },

  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSeachPaths = true,
        indexing = true,
      }
    },
  },

}
