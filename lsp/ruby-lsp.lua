---
-- @file lsp/ruby-lsp.lua
--
-- @brief
-- The configuration file for the Ruby LSP
--
-- @author Tanuharja, R.A.
-- @date 2025-07-08
--

return {

  filetypes = { "ruby" },

  cmd = { "bundle", "exec", "ruby-lsp" },

  root_markers = { "Gemfile", ".git" },
  
  init_options = {
    enabledFeatures = {
      formatting = false,
    },
  },

  on_init = function(client)
    client.offset_encoding = "utf-8"
  end,

}
