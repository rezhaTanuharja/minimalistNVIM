---
-- @file lua/rezha/pluginConfig/treesitter.lua
--
-- @brief
-- The configuration file for the plugin treesitter
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-13
--

local success, treesitter = pcall(require, "nvim-treesitter.configs")
if not success then
  vim.notify("Error loading plugin: treesitter")
  return
end

treesitter.setup {
  ensure_installed = {
    "python",
  },
  sync_install = true,
  ignore_install = {},
  highlight = {
    enable = true,
    disable = {"markdown"},
  },
  indent = {enable = true, disable = {"css", "latex"}},
}
