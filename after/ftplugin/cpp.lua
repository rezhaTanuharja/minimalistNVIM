---
-- @file after/ftplugin/cpp.lua
--
-- @brief
-- C++ - specific config
--
-- @author Tanuharja, R.A.
-- @date 2025-03-28
--


if vim.fn.executable("clangd") == 1 then
  vim.lsp.enable("clangd")
end
