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
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        autoImportCompletions= true,
        autoSeachPaths = false,
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "basic",
        diagnosticSeverityOverrides = {
          reportPrivateImportUsage = "none",
        },
      }
    },
  },

}
