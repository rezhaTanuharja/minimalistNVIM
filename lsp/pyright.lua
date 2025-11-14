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

  cmd = { "pyright-langserver", "--stdio" },

  root_markers = { ".git", "pyproject.toml" },

  on_init = function(client)
    client.offset_encoding = "utf-8"
  end,

  settings = {

    pyright = {
      disableOrganizeImports = true,
    },

    python = {
      analysis = {
        autoImportCompletions = false,
        autoSeachPaths = false,
        diagnosticMode = "workspace",
        typeCheckingMode = "standard",
        diagnosticSeverityOverrides = {
          reportPrivateImportUsage = "none",
        },
      },
    },
  },
}
