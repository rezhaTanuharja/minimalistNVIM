---
-- @file after/ftplugin/typescriptreact.lua
--
-- @brief
-- TS React - specific config
--
-- @author Tanuharja, R.A.
-- @date 2025-07-08
--

if vim.fn.executable("typescript-language-server") == 1 then
  vim.lsp.enable("typescript-language-server")
end
