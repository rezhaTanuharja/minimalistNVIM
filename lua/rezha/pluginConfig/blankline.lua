---
-- @file lua/rezha/pluginConfig/blankline
--
-- @brief
-- The configuration file for the plugin blankline
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-13
--

local success, blankline = pcall(require, "ibl")
if not success then
  vim.notify("Error loading plugin: blankline")
  return
end

blankline.setup {}
