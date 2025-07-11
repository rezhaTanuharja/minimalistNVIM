---
-- @file lsp/ruby-lsp.lua
--
-- @brief
-- The configuration file for the Pyright LSP
--
-- @author Tanuharja, R.A.
-- @date 2025-07-08
--

return {

  filetypes = { "ruby" },

  cmd = { "ruby-lsp" },

  root_markers = { "Gemfile", ".git" },
  
  init_options = {
    formatter = 'standard',
    linters = { 'standard' },
  },

}
