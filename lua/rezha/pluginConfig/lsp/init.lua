---
-- @file lua/rezha/pluginConfig/lsp/init.lua
--
-- @brief
-- The configuration file for the plugin nvim-lsp
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-13
--

local success, _ = pcall(require, "lspconfig")
if not success then
  vim.notify("Error loading plugin: lspconfig")
  return
end

local location = "rezha.pluginConfig.lsp"

require(location .. ".mason")
-- require(location .. ".handlers")
