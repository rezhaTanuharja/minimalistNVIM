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

  init_options = {
    settings = {
      organizeImports = false,
      lint = {
        extendSelect = {
          "A",
          "ANN",
          "ARG",
          "B",
          "COM",
          "C4",
          "D",
          "DOC",
          "FBT",
          "I",
          "ICN",
          "N",
          "PERF",
          "PL",
          "Q",
          "RET",
          "RUF",
          "SIM",
          "SLF",
          "TID",
          "W",
        },
      },
    },
  },

  settings = {},

}
