---
-- @file lsp/rubocop.lua
--
-- @brief
-- The configuration file for the Rubocop LSP
--
-- @author Tanuharja, R.A.
-- @date 2025-07-27
--

return {

  cmd = { "bundle", "exec", "rubocop", "--lsp" },
  filetypes = { "ruby" },
  root_markers = { "Gemfile", ".git" },

  on_init = function(client)
    client.offset_encoding = "utf-8"
  end,

  on_attach = function(client, buffer)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = buffer,
      callback = function()
        vim.lsp.buf.format({ buffer = buffer, id = client.id })
      end,
    })
  end,
}
