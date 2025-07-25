---
-- @file after/ftplugin/typescript.lua
--
-- @brief
-- TS - specific config
--
-- @author Tanuharja, R.A.
-- @date 2025-07-08
--

if vim.fn.executable("typescript-language-server") == 1 then
  vim.lsp.enable("typescript-language-server")
end

if vim.fn.executable("vscode-eslint-language-server") == 1 then
  vim.lsp.enable("vscode-eslint-language-server")
end
