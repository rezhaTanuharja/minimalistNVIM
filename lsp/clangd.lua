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

  settings = {},

}
