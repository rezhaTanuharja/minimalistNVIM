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
      organizeImports = true,
      lint = {
        extendSelect = {
          "A",
          "ARG",
          "B",
          "COM",
          "C4",
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

  on_init = function(client)
    client.offset_encoding = "utf-8"
    client.server_capabilities.hoverProvider = false
  end,

  on_attach = function(client, buffer)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = buffer,
      callback = function()
        vim.lsp.buf.format({ buffer = buffer, id = client.id })
      end,
    })
  end,

  settings = {},
}
