---
-- @file after/ftplugin/go.lua
--
-- @brief
-- Go - specific config
--
-- @author Tanuharja, R.A.
-- @date 2025-07-25
--

if vim.fn.executable("gopls") == 1 then
  vim.lsp.enable("gopls")
end
