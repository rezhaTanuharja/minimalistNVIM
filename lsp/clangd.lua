---
-- @file lsp/clangd.lua
--
-- @brief
-- The configuration file for the clangd LSP
--
-- @author Tanuharja, R.A.
-- @date 2025-03-28
--


return {

  filetypes = {"c", "cpp"},

  cmd = {"clangd", "--background-index", "--clang-tidy", "--log=verbose"},

  root_markers = { ".git", "compile_commands.json" },

  init_options = {
    fallbackFlag = {"-std=c++17"},
  },

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
